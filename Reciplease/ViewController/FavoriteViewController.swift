//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 27/08/2021.
//

import UIKit

final class FavoriteViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var favoriteTableView: UITableView!
    @IBOutlet private weak var noFavoriteStackView: UIStackView!
    private var favoriteViewModel = FavoriteViewModel()
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteTableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReturnToRecipeDetails", let recipe = favoriteViewModel.selectedRecipe {
            guard let recipeDetailsViewController = segue.destination as? RecipeDetailsViewController else { return }
            recipeDetailsViewController.recipe = recipe
            recipeDetailsViewController.openBy = .favorite
        }
    }
    
    // MARK: - IBAction method
    
    @IBAction func unwindToFavorite(segue: UIStoryboardSegue) {
        favoriteTableView.reloadData()
    }
}

// MARK: - TableViewDataSource

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noFavoriteStackView.isHidden = favoriteViewModel.recipesCount != 0
        return favoriteViewModel.recipesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoriteTableView.dequeueReusableCell(
            withIdentifier: "FavoriteCell",
            for: indexPath
        ) as? FavoriteTableViewCell else { return UITableViewCell() }
        
        let recipe = favoriteViewModel.recipes[indexPath.row]
        cell.configureCell(recipe)
        cell.deleteHandler = { [weak self] in
            guard let self = self,
                  let recipeLabel = recipe.label else { return }
            self.favoriteViewModel.deleteRecipe(recipeLabel: recipeLabel)
            self.favoriteTableView.reloadData()
        }
        return cell
    }
}

// MARK: - TableViewDelegate

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favoriteViewModel.configureTableView(with: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ReturnToRecipeDetails", sender: self)
    }
}
