//
//  MainPageWeatherService.swift
//  VK_weather
//
//  Created by Егор Иванов on 21.03.2024.
//
import Foundation

enum ApiError: Error{
    case badUrl
    case emptyData
    case wrongData
    case custom(Error)
}

protocol MainPageWeatherService {
    func getWeather(lat: Double, lon: Double, completion: @escaping (Result<MainPageWeatherForeCastResponse, ApiError>) -> ())
}

final class MainPageWeatherServiceImpl: MainPageWeatherService {
    
    private enum Constants {
        static let baseUrl = "https://api.openweathermap.org"
        static let apiKey = "18869d26c6503e1e1020f847c736fef7"
    }
    
    func getWeather(lat: Double, lon: Double, completion: @escaping (Result<MainPageWeatherForeCastResponse, ApiError>) -> ()) {
        var urlComponents = URLComponents(string: "\(Constants.baseUrl)/data/2.5/forecast")
        urlComponents?.queryItems = [
            .init(name: "lat", value: String(lat)),
            .init(name: "lon", value: String(lon)),
            .init(name: "cnt", value: "7"),
            .init(name: "appid", value: Constants.apiKey),
            .init(name: "units", value: "metric")
        ]
        
        guard let url = urlComponents?.url else {
            return completion(.failure(.badUrl))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error {
                return completion(.failure(.custom(error)))
            }
            guard let data else {
                return completion(.failure(.emptyData))
            }
            
            do {
                let weather = try JSONDecoder().decode(MainPageWeatherForeCastResponse.self, from: data)
                completion(.success(weather))
            } catch {
                return completion(.failure(.custom(error)))
            }
        }
        dataTask.resume()
    }
    
}
