//
//  LoadURLImageView.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 23/08/2021.
//

import UIKit

extension UIImageView {
    
    //    To load image from an URL.
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
