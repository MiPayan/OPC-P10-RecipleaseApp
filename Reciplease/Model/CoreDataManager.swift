//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 13/06/2022.
//

import CoreData

// final class CoreDataManager {
//
//    private var managedContext: NSManagedObjectContext
//    private var coreDataStack: CoreDataStack
//
//    init(coreDataStack: CoreDataStack) {
//        self.coreDataStack = coreDataStack
//        self.managedContext = coreDataStack.managedContext
//    }
//
//    var recipes: [Recipes] {
//        let fetchRequest: NSFetchRequest<Recipes> = Recipes.fetchRequest()
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "label", ascending: true)]
//        guard let recipes = try? managedContext.fetch(fetchRequest) else { return [] }
//        return recipes
//    }
//
//    func saveRecipe(_ recipe: RecipeResponse) {
//        let entity = Recipes(context: managedContext)
//        entity.label = recipe.label
//        entity.image = recipe.image
//        entity.ingredient = recipe.ingredients.map({ $0.text }).joined(separator: " - ")
//        entity.ingredientImage = recipe.ingredients.map({ $0.image ?? "" }).joined(separator: " - ")
//        entity.healthLabel = recipe.healthLabels.map({ $0 }).joined(separator: ",")
//        entity.totalTime = String(recipe.totalTime)
//        entity.calorie = String(recipe.calories.toTruncatedString())
//        entity.yield = String(recipe.yield)
//        entity.url = recipe.url
//        coreDataStack.saveContext()
//    }
//
//    func checkIfRecipeIsAlreadySaved(_ label: String) -> Bool {
//        let fetchRequest: NSFetchRequest<Recipes> = NSFetchRequest(entityName: "Recipes")
//        fetchRequest.predicate = NSPredicate(format: "label == %@", label)
//        do {
//            let recipes = try managedContext.fetch(fetchRequest)
//            return !recipes.isEmpty
//        } catch {
//            return false
//        }
//    }
//
//    func deleteRecipeFromFavorite(_ recipe: String) {
//        let fetchRequest: NSFetchRequest<Recipes> = NSFetchRequest(entityName: "Recipes")
//        fetchRequest.predicate = NSPredicate(format: "label == %@", recipe)
//        guard let recipe = try? managedContext.fetch(fetchRequest) else { return }
//        guard let recipes = recipe.first else { return }
//        managedContext.delete(recipes)
//        coreDataStack.saveContext()
//    }
// }
