//
//  FindPageWeatherIO.swift
//  VK_weather
//
//  Created by Егор Иванов on 23.03.2024.
//

import UIKit

protocol FindPageInput: AnyObject {
    func setCities(cities : [String]) 
    func setBackButtonVisibility(_ isVisible: Bool)
}

protocol FindPageOutput: AnyObject {
    func viewDidLoad()
    
    func textChanged(cityName: String)
    func cellTapped(index: Int)
}
