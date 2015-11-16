//
//  Model.swift
//  Turing
//
//  Created by Jason Pilz on 11/4/15.
//  Copyright © 2015 Jason Pilz. All rights reserved.
//

import UIKit
import CloudKit

protocol ModelDelegate {
    func modelUpdated()
    func updateInterfaceForNetworkIssue()
}

class Model {
    
    // MARK: - Properties
    
    static let sharedInstance = Model()
    
    var delegate: ModelDelegate?
    var people: [Person] = []
    
    let container: CKContainer
    let publicDB: CKDatabase
    let privateDB: CKDatabase
    
    // MARK: - Initializer
    
    init() {
        container = CKContainer.defaultContainer()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
    }
    
    // MARK: - Functions
    
    func notifyUser(title: String, message: String) -> Void {
        let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    func toCKRecord(person: Person) -> CKRecord {
        let myRecord = CKRecord(recordType: "Person")
        myRecord.setObject(person.firstName, forKey: "firstName")
        myRecord.setObject(person.lastName, forKey: "lastName")
        myRecord.setObject(person.emailAddress, forKey: "emailAddress")
        myRecord.setObject(person.phoneNumber, forKey: "phoneNumber")
        myRecord.setObject(person.slackScreenName, forKey: "slackScreenName")
        myRecord.setObject(person.githubUserName, forKey: "githubUserName")
        myRecord.setObject(person.twitterUserName, forKey: "twitterUserName")
        myRecord.setObject(person.linkedInUserName, forKey: "linkedInUserName")
        myRecord.setObject(person.posse, forKey: "posse")
        myRecord.setObject(person.cohort, forKey: "cohort")
        myRecord.setObject(person.employer, forKey: "employer")
        myRecord.setObject(person.isAlumnus, forKey: "isAlumnus")
        myRecord.setObject(person.isStaff, forKey: "isStaff")
        myRecord.setObject(person.isMentor, forKey: "isMentor")
        myRecord.setObject(person.dateAdded, forKey: "dateAdded")
        return myRecord
    }
    
    
    // MARK: - Cloudkit
    
    func saveRecord(person: Person) {
        let theRecord = self.toCKRecord(person)
        publicDB.saveRecord(theRecord, completionHandler: ({returnRecord, error in
            if let err = error {
                self.notifyUser("Save Error", message: err.localizedDescription)
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    print("Record saved successfuly")
                    self.notifyUser("Success", message: "Person saved successfully")
                }
            }
        }))
    }
}











