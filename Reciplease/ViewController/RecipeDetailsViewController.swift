//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 26/08/2021.
//

import UIKit

final class RecipeDetailsViewController: UIViewController {
    
    enum OpenBy {
        case search
        case favorite
    }
    
    @IBOutlet private weak var recipeDetailsTableView: UITableView!
    var recipe: RecipeResponse?
    var openBy: OpenBy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        recipeDetailsTableView.dataSource = self
    }
}

extension RecipeDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipe = recipe else { return 1 }
        return recipe.ingredients.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipe = recipe else { return UITableViewCell() }
        
        if indexPath.row == 0,
           let recipeDetailsCell = recipeDetailsTableView.dequeueReusableCell(
            withIdentifier: "RecipesDetailsCell",
            for: indexPath
           ) as? RecipeDetailsTableViewCell {
            recipeDetailsCell.dismissDelegate = self
            recipeDetailsCell.configureCell(recipe: recipe)
            return recipeDetailsCell
        }
        
        guard let ingredientCell = recipeDetailsTableView.dequeueReusableCell(
            withIdentifier: "IngredientsCell",
            for: indexPath
        ) as? IngredientTableViewCell else { return UITableViewCell() }
        let ingredientText = recipe.ingredients[indexPath.row - 1].text
        let imageString = recipe.ingredients[indexPath.row - 1].image ?? ""
        let ingredientImage = URL(string: imageString)
        
        ingredientCell.configureCell(with: ingredientImage, ingredientText: ingredientText)
        return ingredientCell
    }
}

extension RecipeDetailsViewController: DismissButtonTableViewCellDelegate {
    func dismissViewController() {
        guard let openBy = openBy else { return }
        switch openBy {
        case .search:
            performSegue(withIdentifier: "unwindToRecipeSearchResult", sender: self)
        case .favorite:
            performSegue(withIdentifier: "unwindToFavorite", sender: self)
        }
    }
}
