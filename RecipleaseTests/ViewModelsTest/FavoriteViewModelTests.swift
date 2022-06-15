//
//  FavoriteViewModelTests.swift
//  RecipleaseTests
//
//  Created by Mickael PAYAN on 05/04/2022.
//

import XCTest
@testable import Reciplease

final class FavoriteViewModelTests: XCTestCase {
    
    private var favoriteViewModel: FavoriteViewModel!
    private var recipe: RecipeResponse?
    
    override func setUpWithError() throws {
        favoriteViewModel = FavoriteViewModel()
    }
    
    override func tearDownWithError() throws {
        favoriteViewModel = nil
    }
    
    func testStringArray_WhenTransformToArrayAsIngredientType_ThenIsAnArrayAsIngredientType() {
        
    }
}
