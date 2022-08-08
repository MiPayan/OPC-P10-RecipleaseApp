//
//  RecipePeeckingMock.swift
//  RecipleaseTests
//
//  Created by Mickael PAYAN on 05/07/2022.
//
// swiftlint:disable identifier_name

import Foundation
@testable import Reciplease

final class RecipePeeckingMock: RecipePeecking {
    
    var invokedRecipesCount = 0
    var stubbedRecipes: [Recipes]!
    var recipes: [Recipes] {
        invokedRecipesCount += 1
        return stubbedRecipes
    }
    
    var checkIfRecipeIsAlreadySavedCount = 0
    var invokedCheckIfRecipeIsAlreadySavedParameter: String?
    var stubbedIsRecipeAlreadySaved: Bool!
    func checkIfRecipeIsAlreadySaved(_ label: String) -> Bool {
        checkIfRecipeIsAlreadySavedCount += 1
        invokedCheckIfRecipeIsAlreadySavedParameter = label
        return stubbedIsRecipeAlreadySaved
    }
}
