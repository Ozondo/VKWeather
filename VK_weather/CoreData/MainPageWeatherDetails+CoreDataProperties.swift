//
//  MainPageWeatherDetails+CoreDataProperties.swift
//  VK_weather
//
//  Created by Егор Иванов on 24.03.2024.
//
//

import Foundation
import CoreData


extension MainPageWeatherDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainPageWeatherDetails> {
        return NSFetchRequest<MainPageWeatherDetails>(entityName: "MainPageWeatherDetails")
    }

    @NSManaged public var icon: String?

}

extension MainPageWeatherDetails : Identifiable {

}
