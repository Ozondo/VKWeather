//
//  MainPageCity+CoreDataProperties.swift
//  VK_weather
//
//  Created by Егор Иванов on 24.03.2024.
//
//

import Foundation
import CoreData


extension MainPageCity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainPageCity> {
        return NSFetchRequest<MainPageCity>(entityName: "MainPageCity")
    }

    @NSManaged public var name: String?
    @NSManaged public var country: String?

}

extension MainPageCity : Identifiable {

}
