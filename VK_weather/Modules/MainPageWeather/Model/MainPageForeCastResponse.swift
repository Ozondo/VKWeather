//
//  MainPageWeatherForeCastResponse.swift
//  VK_weather
//
//  Created by Егор Иванов on 21.03.2024.
//

import Foundation

struct MainPageWeatherForeCastResponse: Decodable {
    struct City: Decodable {
        let name: String
        let country: String
    }
    
    struct Weather: Decodable {
        struct MainInfo: Decodable {
            let temp: Double?
            let pressure: Int?
            let humidity: Int?
        }
        struct WeatherDetails: Decodable {
            let icon: String?
        }
        struct Wind: Decodable {
            let speed: Double?
        }
        
        let dt: Double
        let wind: Wind
        let main: MainInfo
        let weather: [WeatherDetails]
        let visibility: Int?
    }
    
    let list: [Weather]
    let city: City?
}


