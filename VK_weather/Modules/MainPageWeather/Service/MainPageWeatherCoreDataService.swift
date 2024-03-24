//
//  MainPageWeatherCoreDataService.swift
//  VK_weather
//
//  Created by Егор Иванов on 24.03.2024.
//

import Foundation

protocol MainPageWeatherCoreDataService {
    func getModel(lat: Double, lon: Double) -> MainPageWeatherForeCastResponse?
    func save(response: MainPageWeatherForeCastResponse, lat: Double, lon: Double)
}

final class MainPageWeatherCoreDataServiceImpl: MainPageWeatherCoreDataService {
    func getModel(lat: Double, lon: Double) -> MainPageWeatherForeCastResponse? {
        let viewContext = CoreDataStack.shared.viewContext
        
        let request = MainPageCache.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(
            format: "lat = %lf AND lon = %lf",
            roundCoordinate(lat),
            roundCoordinate(lon)
        )
        
        
        guard let cache = try? viewContext.fetch(request).first else {
            return nil
        }
        
        let city: MainPageWeatherForeCastResponse.City?
        if let name = cache.city?.name, let country = cache.city?.country {
            city = .init(name: name, country: country)
        } else {
            city = nil
        }
        
        return MainPageWeatherForeCastResponse(
            list: cache.list?.compactMap { element -> MainPageWeatherForeCastResponse.Weather? in
                guard let element = element as? MainPageWeather else { return nil }
                
                return MainPageWeatherForeCastResponse.Weather(
                    dt: element.dt,
                    wind: MainPageWeatherForeCastResponse.Weather.Wind(
                        speed: element.wind?.speed
                    ),
                    main: MainPageWeatherForeCastResponse.Weather.MainInfo(
                        temp: element.main?.temp,
                        pressure: Int(element.main?.pressure ?? 0),
                        humidity: Int(element.main?.humidity ?? 0)
                    ),
                    weather: element.weather?.compactMap { element in
                        guard let element = element as? MainPageWeatherDetails else { return nil }
                        return MainPageWeatherForeCastResponse.Weather.WeatherDetails(
                            icon: element.icon
                        )
                    } ?? [],
                    visibility: Int(element.visibility)
                )
            } ?? [],
            city: city
        )
    }
    
    func save(response: MainPageWeatherForeCastResponse, lat: Double, lon: Double) {
        let context = CoreDataStack.shared.backgroundContext
        
        let cache = MainPageCache(context: context)
        let city = MainPageCity(context: context)
        
        city.name = response.city?.name
        city.country = response.city?.country
        cache.city = city
        cache.lat = roundCoordinate(lat)
        cache.lon = roundCoordinate(lon)
        
        let list = response.list.map {
            let weather = MainPageWeather(context: context)
            let wind = MainPageWind(context: context)
            let main = MainPageMainInfo(context: context)
            let weatherDetails = $0.weather.map {
                let details = MainPageWeatherDetails(context: context)
                details.icon = $0.icon
                return details
            }
            
            $0.main.humidity.map {
                main.humidity = Int64($0)
            }
            $0.main.pressure.map {
                main.pressure = Int64($0)
            }
            $0.main.temp.map {
                main.temp = $0
            }
            $0.wind.speed.map {
                wind.speed = $0
            }
            
            weather.dt = $0.dt
            weather.wind = wind
            weather.main = main
            $0.visibility.map {
                weather.visibility = Int64($0)
            }
            weatherDetails.forEach {
                weather.addToWeather($0)
            }
            
            return weather
        }
        
        list.forEach {
            cache.addToList($0)
        }
    
        try? context.save()
    }
    
    private func roundCoordinate(_ value: Double) -> Double {
        round(value * 100) / 100
    }
}
