//
//  MainPageCache+CoreDataProperties.swift
//  VK_weather
//
//  Created by Егор Иванов on 24.03.2024.
//
//

import Foundation
import CoreData


extension MainPageCache {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainPageCache> {
        return NSFetchRequest<MainPageCache>(entityName: "MainPageCache")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var city: MainPageCity?
    @NSManaged public var list: NSSet?

}

// MARK: Generated accessors for list
extension MainPageCache {

    @objc(addListObject:)
    @NSManaged public func addToList(_ value: MainPageWeather)

    @objc(removeListObject:)
    @NSManaged public func removeFromList(_ value: MainPageWeather)

    @objc(addList:)
    @NSManaged public func addToList(_ values: NSSet)

    @objc(removeList:)
    @NSManaged public func removeFromList(_ values: NSSet)

}

extension MainPageCache : Identifiable {

}
