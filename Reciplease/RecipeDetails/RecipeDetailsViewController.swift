//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 26/08/2021.
//

import UIKit

final class RecipeDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var recipeDetailsTableView: UITableView!
    let recipeDetailsViewModel = RecipeDetailsViewModel()
    var openBy: OpenBy?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
    }
}

// MARK: - TableViewDataSource

extension RecipeDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return recipeDetailsViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeDetailsViewModel.ingredientsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipe = recipeDetailsViewModel.recipeResponse else { return UITableViewCell() }
        
        // First section.
        
        if indexPath.row == 0,
           let recipeDetailsCell = recipeDetailsTableView.dequeueReusableCell(
            withIdentifier: "RecipesDetailsCell",
            for: indexPath
           ) as? RecipeDetailsTableViewCell {
            let recipeDetailsTableViewCellViewModel = RecipeDetailsTableViewCellViewModel(recipeResponse: recipe)
            recipeDetailsCell.dismissDelegate = self
            recipeDetailsCell.configureCell(with: recipeDetailsTableViewCellViewModel)
            return recipeDetailsCell
        }
        
        // Second section.
        
        guard let ingredientCell = recipeDetailsTableView.dequeueReusableCell(
            withIdentifier: "IngredientsCell",
            for: indexPath
        ) as? IngredientTableViewCell,
              let ingredient = recipeDetailsViewModel.makeIngredient(at: indexPath.row - 1) else { return UITableViewCell() }
        let ingredientTableViewCellViewModel = IngredientTableViewCellViewModel(ingredientResponse: ingredient)
        ingredientCell.configureCell(with: ingredientTableViewCellViewModel)
        return ingredientCell
    }
}

// MARK: - Dismiss ViewController

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
