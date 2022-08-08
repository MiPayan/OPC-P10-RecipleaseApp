//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 13/06/2022.
//
// swiftlint:disable force_cast

import UIKit
import CoreData

final class CoreDataManager {
    
    // MARK: - Properties
    
    private var coreDataStack: CoreDataStack
    private var managedContext: NSManagedObjectContext
    static let shared: CoreDataManager = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let coreDataStack = appDelegate.coreDataStack
        return CoreDataManager(coreDataStack: coreDataStack)
    }()
    
    // MARK: - Init
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedContext = coreDataStack.managedContext
    }
}

// MARK: - RecipePeecking

extension CoreDataManager: RecipePeecking {
    var recipes: [Recipes] {
        let fetchRequest: NSFetchRequest<Recipes> = Recipes.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "label", ascending: true)]
        guard let recipes = try? managedContext.fetch(fetchRequest) else { return [] }
        return recipes
    }
    
    func checkIfRecipeIsAlreadySaved(_ label: String) -> Bool {
        let fetchRequest: NSFetchRequest<Recipes> = NSFetchRequest(entityName: "Recipes")
        fetchRequest.predicate = NSPredicate(format: "label == %@", label)
        do {
            let recipes = try managedContext.fetch(fetchRequest)
            return !recipes.isEmpty
        } catch {
            return false
        }
    }
    
}

// MARK: - RecipeWriter

extension CoreDataManager: RecipeWriting {
    func saveRecipe(_ recipe: RecipeResponse) {
        let entity = Recipes(context: managedContext)
        entity.label = recipe.label
        entity.image = recipe.image
        entity.ingredient = recipe.ingredients.map({ $0.text }).joined(separator: " - ")
        entity.ingredientImage = recipe.ingredients.map({ $0.image ?? "" }).joined(separator: " - ")
        entity.healthLabel = recipe.healthLabels.map({ $0 }).joined(separator: ",")
        entity.totalTime = String(recipe.totalTime)
        entity.calorie = String(recipe.calories.toTruncatedString())
        entity.yield = String(recipe.yield)
        entity.url = recipe.url
        coreDataStack.saveContext()
    }
    
    func deleteRecipeFromFavorite(_ recipe: String) {
        let fetchRequest: NSFetchRequest<Recipes> = NSFetchRequest(entityName: "Recipes")
        fetchRequest.predicate = NSPredicate(format: "label == %@", recipe)
        guard let recipe = try? managedContext.fetch(fetchRequest) else { return }
        guard let recipes = recipe.first else { return }
        managedContext.delete(recipes)
        coreDataStack.saveContext()
    }
}
