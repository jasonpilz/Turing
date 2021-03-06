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
    var navBorder:UIView = UIView()
    
    @IBOutlet weak var givenName: UITextField!
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
    @IBOutlet weak var staff: UISwitch!
    @IBOutlet weak var mentor: UISwitch!
    @IBOutlet weak var alumni: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Allows the textFieldShouldReturn method to work
        givenName.delegate = self
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
        self.givenName.becomeFirstResponder()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        tableView.keyboardDismissMode = .Interactive
       
        // This line informs Navigation Controller to set the nav item title in white
        self.navigationController?.navigationBar.barStyle = .Black
        
        self.staff.onTintColor = tealColor
        self.mentor.onTintColor = tealColor
        self.alumni.onTintColor = tealColor
        
    }
    
    override func viewWillLayoutSubviews() {
        self.navBorder.removeFromSuperview()
        self.setNavbarBottomBorder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case givenName: self.lastName.becomeFirstResponder()
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
            
            let person = Person.init(givenName: givenName.text!,
                lastName: lastName.text!,
                emailAddress: email.text!,
                phoneNumber: phone.text!,
                slackScreenName: slack.text!,
                githubUserName: github.text!,
                twitterUserName: twitter.text!,
                linkedInUserName: linkedIn.text!,
                posse: posse.text!,
                cohort: (cohort.text as NSString!).integerValue,
                employer: employer.text!,
                isAlumnus: alumni.on,
                isStaff: staff.on,
                isMentor: mentor.on)
            
            if let p = person {
                // CloudKit Storage
                Model.sharedInstance.saveRecord(p)
            } else {
                // TODO - Notify user to fill in first and last name
            }
        }
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
