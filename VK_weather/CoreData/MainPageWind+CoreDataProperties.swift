//
//  MainPageWind+CoreDataProperties.swift
//  VK_weather
//
//  Created by Егор Иванов on 24.03.2024.
//
//

import Foundation
import CoreData


extension MainPageWind {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainPageWind> {
        return NSFetchRequest<MainPageWind>(entityName: "MainPageWind")
    }

    @NSManaged public var speed: Double

}

extension MainPageWind : Identifiable {

}
