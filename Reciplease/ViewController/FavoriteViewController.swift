//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 27/08/2021.
//

import UIKit
import CoreData

final class FavoriteViewController: UIViewController {
    @IBOutlet private weak var favoriteTableView: UITableView!
    @IBOutlet private weak var noFavoriteStackView: UIStackView!
    private var favoriteViewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReturnToRecipeDetails", let recipe = favoriteViewModel.selectedRecipe {
            guard let recipeDetailsViewController = segue.destination as? RecipeDetailsViewController else { return }
            recipeDetailsViewController.recipe = recipe
            recipeDetailsViewController.openBy = .favorite
        }
    }
    
    @IBAction func unwindToFavorite(segue: UIStoryboardSegue) {
        favoriteTableView.reloadData()
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noFavoriteStackView.isHidden = !favoriteViewModel.recipes.recipes.isEmpty
        return favoriteViewModel.countRecipes()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoriteTableView.dequeueReusableCell(
            withIdentifier: "FavoriteCell",
            for: indexPath
        ) as? FavoriteTableViewCell else { return UITableViewCell() }
        
        let recipe = favoriteViewModel.recipes.recipes[indexPath.row]
        cell.configureCell(recipe)
        cell.deleteHandler = { [weak self] in
            guard let self = self else { return }
            AppDelegate.viewContext.delete(recipe)
            self.favoriteTableView.reloadData()
            do {
                try AppDelegate.viewContext.save()
            } catch let error as NSError {
                print(error)
            }
        }
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favoriteViewModel.configureTableView(with: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ReturnToRecipeDetails", sender: self)
    }
}
