//
//  MainPageMainInfo+CoreDataProperties.swift
//  VK_weather
//
//  Created by Егор Иванов on 24.03.2024.
//
//

import Foundation
import CoreData


extension MainPageMainInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainPageMainInfo> {
        return NSFetchRequest<MainPageMainInfo>(entityName: "MainPageMainInfo")
    }

    @NSManaged public var temp: Double
    @NSManaged public var pressure: Int64
    @NSManaged public var humidity: Int64

}

extension MainPageMainInfo : Identifiable {

}
