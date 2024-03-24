//
//  MainPageIO.swift
//  VK_weather
//
//  Created by Егор Иванов on 20.03.2024.
//

import UIKit

protocol MainPageInput: AnyObject {
    var isActivityIndicatorVisible: Bool { get set }
    
    func updateCollection(weather: [MainPageWeatherForeCastResponse.Weather])
    func updateWeather(weather: MainPageWeatherForeCastResponse.Weather, city: MainPageWeatherForeCastResponse.City?)
}

protocol MainPageOutput: AnyObject {
    func viewDidLoad()
    func rightButtonTapped()
}
