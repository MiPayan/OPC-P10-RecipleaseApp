//
//  HealtInformationCollectionViewCell.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 01/09/2021.
//

import UIKit

final class HealtInformationsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var healtTextField: SettingTextFieldSearchView!

    func displayText(with text: String) {
        healtTextField.text = text
    }
}
