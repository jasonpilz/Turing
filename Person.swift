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
    var givenName: String!
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
    //var bio: String?
    var isAlumnus: Bool = false
    var isStaff: Bool = false
    var isMentor: Bool = false
    var dateAdded: NSDate?
    
    // MARK: - Initializers
    
    // Failable initializer
    init?(givenName: String, lastName: String, emailAddress: String?, phoneNumber: String?, slackScreenName: String?, githubUserName: String?, twitterUserName: String?, linkedInUserName: String?, posse: String?, cohort: Int?, employer: String?, isAlumnus: Bool, isStaff: Bool, isMentor: Bool) {
        
        super.init()
        
        self.givenName = givenName
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
        self.isAlumnus = isAlumnus
        self.isStaff = isStaff
        self.isMentor = isMentor
        self.dateAdded = NSDate()
        
        if givenName.isEmpty || lastName.isEmpty {
            return nil
        }
    }
    
    init(record: CKRecord, database: CKDatabase) {
        self.record = record
        self.database = database
        
        self.givenName = record.objectForKey("givenName") as! String!
        self.lastName = record.objectForKey("lastName") as! String!
        self.emailAddress = record.objectForKey("emailAddress") as! String!
        self.phoneNumber = record.objectForKey("phoneNubmer") as! String!
        self.slackScreenName = record.objectForKey("slackScreenName") as! String!
        self.githubUserName = record.objectForKey("githubUserName") as! String!
        self.twitterUserName = record.objectForKey("twitterUserName") as! String!
        self.linkedInUserName = record.objectForKey("linkedInUserName") as! String!
        self.posse = record.objectForKey("posse") as! String!
        self.cohort = record.objectForKey("cohort") as! Int!
        self.employer = record.objectForKey("employer") as! String!
        self.isAlumnus = record.objectForKey("isAlumnus") as! Bool!
        self.isStaff = record.objectForKey("isStaff") as! Bool!
        self.isMentor = record.objectForKey("isMentor") as! Bool!
        self.dateAdded = record.objectForKey("dateAdded") as! NSDate!
    }
}
