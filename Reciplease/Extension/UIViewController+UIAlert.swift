//
//  UIViewController+UIAlert.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 20/08/2021.
//

import UIKit

extension UIViewController {
    
    //  To alert when the user doesn't have a network.
    //  The service is available or the searched ingredient doesn't exist.
    
    func showErrorAlertController() {
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
