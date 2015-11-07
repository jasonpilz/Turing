//
//  Person.swift
//  Turing
//
//  Created by Jason Pilz on 11/4/15.
//  Copyright © 2015 Jason Pilz. All rights reserved.
//

import UIKit
import CloudKit

class Person: NSObject {
    
    // MARK: - Properties
    
    weak var database: CKDatabase!
    var record: CKRecord!
    var firstName: String!
    var lastName: String!
    var emailAddress: String?
    var phoneNumber: String?
    var slackScreenName: String?
    var githubUserName: String?
    var twitterUserName: String?
    var linkedInUserName: String?
    var posse: String?
    var cohort: Int?
    var employer: String?
    var bio: String?
    var isAlumnus: Bool = false
    var isStaff: Bool = false
    var isMentor: Bool = false
    var dateAdded: NSDate?
    
    // MARK: - Initializers
    
    // Failable initializer
    init?(firstName: String, lastName: String, emailAddress: String?, phoneNumber: String?, slackScreenName: String?, githubUserName: String?, twitterUserName: String?, linkedInUserName: String?, posse: String?, cohort: Int?, employer: String?, bio: String?, isAlumnus: Bool, isStaff: Bool, isMentor: Bool) {
        
        super.init()
        
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
        self.slackScreenName = slackScreenName
        self.githubUserName = githubUserName
        self.twitterUserName = twitterUserName
        self.linkedInUserName = linkedInUserName
        self.posse = posse
        self.cohort = cohort
        self.employer = employer
        self.bio = bio
        self.isAlumnus = isAlumnus
        self.isStaff = isStaff
        self.isMentor = isMentor
        self.dateAdded = NSDate()
        
        if firstName.isEmpty || lastName.isEmpty {
            return nil
        }
    }
}
