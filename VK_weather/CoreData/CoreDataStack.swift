//
//  CoreDataStack.swift
//  VK_weather
//
//  Created by Егор Иванов on 24.03.2024.
//

import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    var backgroundContext: NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
        }
        return container
    }()
    
    private init() {}
}
