//
//  DismissSegue.swift
//  Turing
//
//  Created by Jason Pilz on 11/5/15.
//  Copyright © 2015 Jason Pilz. All rights reserved.
//

import UIKit

@objc(DismissSegue) class DismissSegue: UIStoryboardSegue {
    
    override func perform() {
        if let controller = sourceViewController.presentingViewController {
            controller.dismissViewControllerAnimated(true, completion: nil);
        }
    }
    
}
