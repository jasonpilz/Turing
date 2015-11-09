//
//  AddPersonViewController.swift
//  Turing
//
//  Created by Jason Pilz on 11/5/15.
//  Copyright © 2015 Jason Pilz. All rights reserved.
//

import UIKit

class AddPersonViewController: UITableViewController, UITextFieldDelegate {
    
    let tealColor = UIColor(red: 5.0/255.0, green: 194.0/255.0, blue: 209.0/255.0, alpha: 1.0)
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var slack: UITextField!
    @IBOutlet weak var github: UITextField!
    @IBOutlet weak var twitter: UITextField!
    @IBOutlet weak var linkedIn: UITextField!
    @IBOutlet weak var posse: UITextField!
    @IBOutlet weak var cohort: UITextField!
    @IBOutlet weak var employer: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Allows the textFieldShouldReturn method to work
        firstName.delegate = self
        lastName.delegate = self
        email.delegate = self
        phone.delegate = self
        slack.delegate = self
        github.delegate = self
        twitter.delegate = self
        linkedIn.delegate = self
        posse.delegate = self
        cohort.delegate = self
        employer.delegate = self
        self.firstName.becomeFirstResponder()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        tableView.keyboardDismissMode = .Interactive
       
        // This line informs Navigation Controller to set the nav item title in white
        self.navigationController?.navigationBar.barStyle = .Black
        
        // Set custom bottom navbar border
        if let navigationController = self.navigationController {
            
            let navigationBar = navigationController.navigationBar
            let navBorder: UIView = UIView(frame: CGRectMake(0, navigationBar.frame.size.height - 3, navigationBar.frame.size.width, 3))
            navBorder.backgroundColor = tealColor
            navBorder.opaque = true
            self.navigationController?.navigationBar.addSubview(navBorder)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case firstName: self.lastName.becomeFirstResponder()
        case lastName: self.email.becomeFirstResponder()
        case email: self.phone.becomeFirstResponder()
        case phone: self.slack.becomeFirstResponder()
        case slack: self.github.becomeFirstResponder()
        case github: self.twitter.becomeFirstResponder()
        case twitter: self.linkedIn.becomeFirstResponder()
        case linkedIn: self.posse.becomeFirstResponder()
        case posse: self.cohort.becomeFirstResponder()
        default: return false
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "dismissAndSave" {
            
            print("Time for some CloudKit Storage!!")
            // CloudKit Storage
        }
    }
}
