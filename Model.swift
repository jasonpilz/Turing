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
    
    
    // MARK: - Cloudkit
}
