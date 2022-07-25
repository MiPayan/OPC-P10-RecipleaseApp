//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 13/06/2022.
//

import CoreData

open class CoreDataStack {
    
    // MARK: - Property
    
    private let modelName: String
    
    // MARK: - Init
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Computed Properties
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    // MARK: - Methods
    
    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
