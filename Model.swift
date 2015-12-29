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
    func errorUpdating(error: NSError)
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
    
    func addPerson(person: Person) {
        people.append(person)
        self.delegate?.modelUpdated()
    }
    
//    DEPRICATED
//    func notifyUser(title: String, message: String) -> Void {
//        let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
//        alert.show()
//    }
    
    func notifyUser(title: String, message: String) -> Void {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction.init(title: "OK", style: .Default, handler: nil)
        alert.addAction(OKAction)
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - Cloudkit
    
    func toCKRecord(person: Person) -> CKRecord {
        let myRecord = CKRecord(recordType: "Person")
        myRecord.setObject(person.givenName, forKey: "givenName")
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
    
    func saveRecord(person: Person) {
        let theRecord = self.toCKRecord(person)
        publicDB.saveRecord(theRecord, completionHandler: ({returnRecord, error in
            if let err = error {
                self.notifyUser("Save Error", message: err.localizedDescription)
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    // Save locally
                    self.addPerson(person)
                    print("Record saved successfuly")
                    self.notifyUser("Success", message: "Person saved successfully")
                }
            }
        }))
    }
    
    func fetchPeople() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Person", predicate: predicate)
        
        let sortGivenName = NSSortDescriptor(key: "givenName", ascending: true)
        query.sortDescriptors = [sortGivenName]
        
        publicDB.performQuery(query, inZoneWithID: nil) { results, error in
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.updateInterfaceForNetworkIssue()
                    self.delegate?.errorUpdating(error!)
                    print("Error fetching: \(error)")
                }
            } else {
                self.people.removeAll(keepCapacity: true)
                for record in results! {
                    let person = Person(record: record, database: self.publicDB)
                    self.people.append(person)
                }
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.modelUpdated()
                }
            }
        }
    }
}











