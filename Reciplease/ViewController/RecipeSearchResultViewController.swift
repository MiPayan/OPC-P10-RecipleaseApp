//
//  RecipeSearchResultViewController.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 28/07/2021.
//

import UIKit

final class RecipeSearchResultViewController: UIViewController {
    
    @IBOutlet private weak var recipeSearchResultTableView: UITableView!
    private var selectedRecipe: RecipeResponse?
    var edamamAPIData: EdamamResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeSearchResultTableView.dataSource = self
        recipeSearchResultTableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipeDetails", let recipe = selectedRecipe {
            guard let recipeDetailsViewController = segue.destination as? RecipeDetailsViewController else { return }
            recipeDetailsViewController.recipe = recipe
            recipeDetailsViewController.openBy = .search
        }
    }
    
    @IBAction func unwindToRecipeSearchResult(segue: UIStoryboardSegue) {
        recipeSearchResultTableView.reloadData()
    }
}

extension RecipeSearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = edamamAPIData?.hits[indexPath.row].recipe
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowRecipeDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let edamamAPIData = edamamAPIData else { return 0 }
        return edamamAPIData.hits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "RecipeCell",
            for: indexPath
        ) as? RecipeSearchResultTableViewCell,
              let recipe = edamamAPIData?.hits[indexPath.row].recipe else { return UITableViewCell() }
        cell.configureCell(recipe: recipe)
        return cell
    }
}
