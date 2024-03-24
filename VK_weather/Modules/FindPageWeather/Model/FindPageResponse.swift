//
//  FindPageResponse.swift
//  VK_weather
//
//  Created by Егор Иванов on 23.03.2024.
//

import Foundation

struct CityResponseElement: Decodable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case lat, lon, country, state
    }
}

typealias CityResponse = [CityResponseElement]
