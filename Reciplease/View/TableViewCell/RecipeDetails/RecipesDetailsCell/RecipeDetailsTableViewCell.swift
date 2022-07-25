//
//  RecipeDetailsTableViewCell.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 02/09/2021.
//

import UIKit

protocol DismissButtonTableViewCellDelegate: AnyObject {
    func dismissViewController()
}

final class RecipeDetailsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var dismissButton: RoundedButtonSetting!
    @IBOutlet private weak var favoriteButton: RoundedButtonSetting!
    @IBOutlet private weak var recipeLabel: UILabel!
    @IBOutlet private weak var totalTimeLabel: UILabel!
    @IBOutlet private weak var caloriesLabel: UILabel!
    @IBOutlet private weak var yieldLabel: UILabel!
    @IBOutlet private weak var healthCollectionView: UICollectionView!
    private let recipeDetailsViewModel = RecipeDetailsViewModel()
    private var recipe: RecipeResponse? {
        didSet {
            guard recipe != nil else { return }
            healthCollectionView.reloadData()
        }
    }
    weak var dismissDelegate: DismissButtonTableViewCellDelegate?
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        healthCollectionView.dataSource = self
    }
    
    // MARK: - Methods
    
    func configureCell(recipe: RecipeResponse) {
        guard let recipeImage = recipe.image,
              let urlString = URL(string: recipeImage) else { return }
        recipeImageView.loadImage(url: urlString)
        recipeImageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        recipeLabel.text = recipe.label
        totalTimeLabel.text = String(recipe.totalTime) + " min"
        caloriesLabel.text = String(recipe.calories.toTruncatedString()) + " kcal"
        yieldLabel.text = String(recipe.yield) + " pers."
        self.recipe = recipe
        configureFavoriteButton()
    }
    
    func configureFavoriteButton() {
        guard let recipe = recipe else { return }
        let isRecipeAlreadySaved = recipeDetailsViewModel.checkIfRecipeIsAlreadySaved(with: recipe.label)
        let imageString = isRecipeAlreadySaved ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageString), for: .normal)
    }
    
}

// MARK: - IBAction Methods

private extension RecipeDetailsTableViewCell {
    @IBAction func didTapFavoriteButton() {
        guard let recipe = recipe else { return }
        if recipeDetailsViewModel.checkIfRecipeIsAlreadySaved(with: recipe.label) == true {
            recipeDetailsViewModel.deleteRecipe(with: recipe.label)
        } else {
            recipeDetailsViewModel.saveRecipe(with: recipe)
        }
        configureFavoriteButton()
    }
    
    @IBAction private func openRecipeInstruction(_ sender: Any) {
        guard let recipe = recipe,
              let url = URL(string: recipe.url) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func didTapDismissButton(_ sender: Any) {
        guard let dismissDelegate = dismissDelegate else { return }
        dismissDelegate.dismissViewController()
    }
}

// MARK: - CollectionViewDataSource

extension RecipeDetailsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let recipe = recipe else { return 1 }
        return recipe.healthLabels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = healthCollectionView.dequeueReusableCell(
            withReuseIdentifier: "HealthCollectionCell",
            for: indexPath
        ) as? HealthInformationCollectionViewCell,
              let recipe = recipe else { return UICollectionViewCell() }
        
        let healthText = recipe.healthLabels[indexPath.row]
        cell.configureText(with: healthText)
        return cell
    }
}
