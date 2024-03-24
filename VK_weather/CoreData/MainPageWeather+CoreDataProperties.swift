//
//  MainPageWeather+CoreDataProperties.swift
//  VK_weather
//
//  Created by Егор Иванов on 24.03.2024.
//
//

import Foundation
import CoreData


extension MainPageWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainPageWeather> {
        return NSFetchRequest<MainPageWeather>(entityName: "MainPageWeather")
    }

    @NSManaged public var dt: Double
    @NSManaged public var visibility: Int64
    @NSManaged public var wind: MainPageWind?
    @NSManaged public var main: MainPageMainInfo?
    @NSManaged public var weather: NSSet?

}

// MARK: Generated accessors for weather
extension MainPageWeather {

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: MainPageWeatherDetails)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: MainPageWeatherDetails)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)

}

extension MainPageWeather : Identifiable {

}
