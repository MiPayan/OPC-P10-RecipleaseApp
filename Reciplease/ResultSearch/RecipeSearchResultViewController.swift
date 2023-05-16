//
//  RecipeSearchResultViewController.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 28/07/2021.
//

import UIKit

final class RecipeSearchResultViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var recipeSearchResultTableView: UITableView!
    var recipeSearchResultViewModel = RecipeSearchResultViewModel()
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipeSearchResultTableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipeDetails", let recipe = recipeSearchResultViewModel.selectedRecipe {
            guard let recipeDetailsViewController = segue.destination as? RecipeDetailsViewController else { return }
            recipeDetailsViewController.recipe = recipe
            recipeDetailsViewController.openBy = .search
        }
    }
}

// MARK: - IBAction Method

extension RecipeSearchResultViewController {
    @IBAction private func unwindToRecipeSearchResult(segue: UIStoryboardSegue) {
        recipeSearchResultTableView.reloadData()
    }
}

// MARK: - TableViewDataSource

extension RecipeSearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeSearchResultViewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "RecipeCell",
            for: indexPath
        ) as? RecipeSearchResultTableViewCell,
              let recipe = recipeSearchResultViewModel.makeRecipe(at: indexPath.row) else { return UITableViewCell() }
        let recipeSearchResultTableViewCellViewModel = RecipeSearchResultTableViewCellViewModel(recipeResponse: recipe)
        cell.configureCell(with: recipeSearchResultTableViewCellViewModel)
        return cell
    }
}

// MARK: - TableViewDelegate

extension RecipeSearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipeSearchResultViewModel.selectedRecipe = recipeSearchResultViewModel.makeRecipe(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowRecipeDetails", sender: self)
    }
}
