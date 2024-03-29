//
//  SearchIngredientViewController.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 17/08/2021.
//

import UIKit

final class SearchIngredientViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var ingredientTextField: UITextField!
    @IBOutlet private weak var ingredientCollectionView: UICollectionView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var searchButton: SearchButtonSetting!
    private let searchIngredientViewModel = SearchIngredientViewModel()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        hideKeyboardWhenTapScreen()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipes" {
            if let recipeSearchResultViewController = segue.destination as? RecipeSearchResultViewController,
               let recipesData = searchIngredientViewModel.edamamData {
                recipeSearchResultViewController.recipeSearchResultViewModel.edamamResponse = recipesData
            }
        }
    }
}

// MARK: - ViewController Methods

private extension SearchIngredientViewController {
    func configureViewModel() {
        searchIngredientViewModel.successHandler = {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "ShowRecipes", sender: self)
            }
        }
        searchIngredientViewModel.failureHandler = {
            self.showErrorAlertController()
        }
    }
    
    //    If the ingredient table is empty, you can press the search button. Otherwise, if it contains something, the search button can be used.
    func isSearchButtonEnabled() {
        searchButton.isEnabled = !searchIngredientViewModel.ingredientArray.isEmpty
    }
    
    func displayError() {
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseIn, animations: {
            self.errorLabel.text = "No ingredient, or has already been added"
            self.errorLabel.alpha = 1
        })
    }
    
    func hideError() {
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseIn, animations: {
            self.errorLabel.alpha = 0
        })
    }
    
    func hideKeyboardWhenTapScreen() {
        let tap: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - IBAction Methods

private extension SearchIngredientViewController {
    @IBAction func addIngredientInSearchList(_ sender: Any) {
        hideError()
        guard let ingredient = ingredientTextField.text else { return }
        if searchIngredientViewModel.formatIngredientArray(ingredient: ingredient) {
            ingredientCollectionView.reloadData()
            isSearchButtonEnabled()
        } else {
            displayError()
        }
        ingredientTextField.text?.removeAll()
    }
    
    @IBAction func removeAllIngredients(_ sender: Any) {
        searchIngredientViewModel.removeAllIngredients()
        ingredientCollectionView.reloadData()
        isSearchButtonEnabled()
    }
    
    @IBAction func didTapSearchButton(_ sender: Any) {
        searchIngredientViewModel.getRecipe()
    }
}

// MARK: CollectionViewDataSource

extension SearchIngredientViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchIngredientViewModel.countIngredient
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = ingredientCollectionView.dequeueReusableCell(
            withReuseIdentifier: "IngredientCollectionCell",
            for: indexPath
        ) as? SearchIngredientCollectionViewCell else { return UICollectionViewCell() }
        cell.configureIngredientLabel(searchIngredientViewModel.ingredientArray[indexPath.row])
        return cell
    }
}

// MARK: - CollectionView Delegate
extension SearchIngredientViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchIngredientViewModel.removeIngredient(at: indexPath.row)
        isSearchButtonEnabled()
        ingredientCollectionView.reloadData()
    }
}
