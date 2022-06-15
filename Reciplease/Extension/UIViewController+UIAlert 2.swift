//
//  UIAlert.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 20/08/2021.
//

import UIKit

extension UIViewController {
    func showAlertController() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Error",
                message: "The service isn't available, or the ingredient searched doesn't exist.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
