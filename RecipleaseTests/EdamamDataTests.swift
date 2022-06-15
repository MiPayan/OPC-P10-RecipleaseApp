//
//  EdamamDataTests.swift
//  EdamamDataTests
//
//  Created by Mickael PAYAN on 03/01/2022.
//

import XCTest
@testable import Reciplease

final class EdamamDataTests: XCTestCase {
    
    func testEdamamDataJsonMapping() throws {
        let edamamResponseMock = EdamamResponseMock()
        guard let edamamResponse = edamamResponseMock.make(),
              let recipeLabel = edamamResponse.hits.first?.recipe.label,
              let image = edamamResponse.hits.first?.recipe.image,
              let url = edamamResponse.hits.first?.recipe.url,
              let yield = edamamResponse.hits.first?.recipe.yield,
              let heathLabel = edamamResponse.hits.first?.recipe.healthLabels,
              let ingredientLabel = edamamResponse.hits.first?.recipe.ingredients.first?.text,
              let ingredientImage = edamamResponse.hits.first?.recipe.ingredients.first?.image,
              let calories = edamamResponse.hits.first?.recipe.calories,
              let totalTime = edamamResponse.hits.first?.recipe.totalTime
        else { return }
        XCTAssertEqual(recipeLabel, "Salmon Rillettes/Salmon Spread")
        XCTAssertEqual(image, "https://www.edamam.com/web-img/2ad/2ada9d9680243e2cc13c09b7ed978e96.jpg")
        XCTAssertEqual(url, "http://www.davidlebovitz.com/2007/11/salmon-rillette/")
        XCTAssertEqual(yield, 6)
        XCTAssertEqual(
            heathLabel,
            [
                "Sugar-Conscious",
                "Kidney-Friendly",
                "Keto-Friendly",
                "Pescatarian",
                "Gluten-Free",
                "Wheat-Free",
                "Egg-Free",
                "Peanut-Free",
                "Tree-Nut-Free",
                "Soy-Free",
                "Shellfish-Free",
                "Pork-Free",
                "Red-Meat-Free",
                "Crustacean-Free",
                "Celery-Free",
                "Mustard-Free",
                "Sesame-Free",
                "Lupine-Free",
                "Mollusk-Free",
                "Alcohol-Free",
                "Sulfite-Free",
                "FODMAP-Free"
            ]
        )
        XCTAssertEqual(ingredientLabel, "8 ounce (250 g) piece of salmon, preferably wild, bones removed")
        XCTAssertEqual(ingredientImage, "https://www.edamam.com/food-img/9a0/9a0f38422e9f21dcedbc2dca0d8209ac.jpg")
        XCTAssertEqual(calories, 1269.955833024915)
        XCTAssertEqual(totalTime, 0)
    }
}
