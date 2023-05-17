//
//  RecipeDetailsTableViewCell.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 02/09/2021.
//

import UIKit

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
    private var viewModel: RecipeDetailsTableViewCellViewModel? {
        didSet {
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
    
    func configureCell(with viewModel: RecipeDetailsTableViewCellViewModel) {
        self.viewModel = viewModel
        if let url = viewModel.recipeImageURL {
            recipeImageView.loadImage(url: url)
        }
        recipeImageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        recipeLabel.text = viewModel.recipeText
        totalTimeLabel.text = viewModel.totalTimeText
        caloriesLabel.text = viewModel.caloriesText
        yieldLabel.text = viewModel.yieldText
        configureFavoriteButton()
    }
    
    private func configureFavoriteButton() {
        guard let viewModel else { return }
        let imageString = viewModel.checkIfRecipeIsAlreadySaved ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageString), for: .normal)
    }
    
}

// MARK: - IBAction Methods

private extension RecipeDetailsTableViewCell {
    @IBAction func didTapFavoriteButton() {
        guard let viewModel else { return }
        viewModel.checkIfRecipeIsAlreadySaved ? viewModel.deleteRecipe : viewModel.saveRecipe
        configureFavoriteButton()
    }
    
    @IBAction private func openRecipeInstruction(_ sender: Any) {
        if let url = viewModel?.urlToRecipePreparation {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func didTapDismissButton(_ sender: Any) {
        guard let dismissDelegate = dismissDelegate else { return }
        dismissDelegate.dismissViewController()
    }
}

// MARK: - CollectionViewDataSource

extension RecipeDetailsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.healthLabelsCount
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = healthCollectionView.dequeueReusableCell(
            withReuseIdentifier: "HealthCollectionCell",
            for: indexPath
        ) as? HealthInformationCollectionViewCell,
              let healthText = viewModel?.makeHealthText(at: indexPath.row) else { return UICollectionViewCell() }
        cell.configureText(with: healthText)
        return cell
    }
}
