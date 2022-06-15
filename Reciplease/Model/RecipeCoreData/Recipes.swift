//
//  Recipes.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 08/09/2021.
//

import Foundation
import CoreData

 final class Recipes: NSManagedObject {
    private let viewContext = AppDelegate.viewContext

    var recipes: [Recipes] {
        let fetchRequest: NSFetchRequest<Recipes> = Recipes.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "label", ascending: true)]
        guard let recipes = try? viewContext.fetch(fetchRequest) else { return [] }
        return recipes
    }

    func saveRecipe(_ recipe: RecipeResponse) {
        let entity = Recipes(context: viewContext)
        entity.label = recipe.label
        entity.image = recipe.image
        entity.ingredient = recipe.ingredients.map({ $0.text }).joined(separator: " - ")
        entity.ingredientImage = recipe.ingredients.map({ $0.image ?? "" }).joined(separator: " - ")
        entity.healthLabel = recipe.healthLabels.map({ $0 }).joined(separator: ",")
        entity.totalTime = String(recipe.totalTime)
        entity.calorie = String(recipe.calories.toTruncatedString())
        entity.yield = String(recipe.yield)
        entity.url = recipe.url
        do {
            try viewContext.save()
        } catch let error {
            print(error)
        }
    }

    func checkIfRecipeIsAlreadySaved(_ label: String) -> Bool {
        let fetchRequest: NSFetchRequest<Recipes> = NSFetchRequest(entityName: "Recipes")
        fetchRequest.predicate = NSPredicate(format: "label == %@", label)
        do {
            let recipes = try viewContext.fetch(fetchRequest)
            return !recipes.isEmpty
        } catch {
            return false
        }
    }

    func deleteRecipeFromFavorite(_ recipe: String) {
        let fetchRequest: NSFetchRequest<Recipes> = NSFetchRequest(entityName: "Recipes")
        fetchRequest.predicate = NSPredicate(format: "label == %@", recipe)
        guard let recipe = try? viewContext.fetch(fetchRequest) else { return }
        guard let recipes = recipe.first else { return }
        viewContext.delete(recipes)
        do {
            try viewContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
 }
