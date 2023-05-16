//
//  RecipeSearchResultViewModel.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 28/06/2022.
//

import Foundation

final class RecipeSearchResultViewModel {
    
    var edamamResponse: EdamamResponse?
    var selectedRecipe: RecipeResponse?
    
    var numberOfRowsInSection: Int {
        edamamResponse?.hits.count ?? 0
    }
    
    func makeRecipe(at index: Int) -> RecipeResponse? {
        edamamResponse?.hits[index].recipe
    }
}
