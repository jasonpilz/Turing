//
//  DesignableTableView.swift
//  Turing
//
//  Created by Jason Pilz on 11/6/15.
//  Copyright © 2015 Jason Pilz. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTableView: UITableView {
    
    @IBInspectable var backgroundImage: UIImage? {
        didSet {
            if let image = backgroundImage {
                let backgroundImage = UIImageView(image: image)
                backgroundImage.contentMode = UIViewContentMode.Center
                backgroundImage.clipsToBounds = false
                self.backgroundView = backgroundImage
            }
        }
    }
}
