//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 13/06/2022.
//

import CoreData

// final class CoreDataStack {
//
//    private let modelName: String
//
//    init(modelName: String) {
//        self.modelName = modelName
//    }
//
//    private lazy var storeContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: modelName)
//        container.loadPersistentStores { _, error in
//            if let error = error as NSError? {
//                print("Unresolved error \(error), \(error.userInfo)")
//            }
//        }
//        return container
//    }()
//
//    lazy var managedContext: NSManagedObjectContext = {
//        return storeContainer.viewContext
//    }()
//
//    func saveContext() {
//        guard managedContext.hasChanges else { return }
//        do {
//            try managedContext.save()
//        } catch let error as NSError {
//            print("Unresolved error \(error), \(error.userInfo)")
//        }
//    }
// }
