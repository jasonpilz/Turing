//
//  DetailViewController.swift
//  Turing
//
//  Created by Aaron Careaga & Jason Pilz on 10/26/15.
//

import UIKit

class DetailViewController: UIViewController {
    
    let tealColor = UIColor(red: 5.0/255.0, green: 194.0/255.0, blue: 209.0/255.0, alpha: 1.0)
    var navBorder:UIView = UIView()

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let person = self.detailItem {
            self.navigationItem.title = person.givenName
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // This line informs Navigation Controller to set the nav item title in white
        self.navigationController?.navigationBar.barStyle = .Black
        
        // Toolbar config
        self.navigationController?.toolbarHidden = false
        self.navigationController?.toolbar.barTintColor = tealColor
        
        self.configureView()
    }
    
    override func viewWillLayoutSubviews() {
        self.navBorder.removeFromSuperview()
        self.setNavbarBottomBorder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Custom Functions
    
    func setNavbarBottomBorder() {
        if let navigationController = self.navigationController {
            let navigationBar = navigationController.navigationBar
            self.navBorder = UIView(frame: CGRectMake(0, navigationBar.frame.size.height - 3, navigationBar.frame.size.width, 3))
            navBorder.backgroundColor = tealColor
            navBorder.opaque = true
            self.navigationController?.navigationBar.addSubview(self.navBorder)
        }
    }
}