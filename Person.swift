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
    var employer: String?
    var bio: String?
    
    var isAlumnus: Bool = false
    var isStaff: Bool = false
    var isMentor: Bool = false
    
    var posse: String?
    
    
    // MARK: - Initializers
}
