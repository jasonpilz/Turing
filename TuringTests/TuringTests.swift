//
//  TuringTests.swift
//  TuringTests
//
//  Created by Aaron Careaga & Jason Pilz on 10/26/15.
//

import XCTest
//@testable import Turing

class TuringTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - Person Tests
    
    func testPersonInitialization() {
        
        // Success case
        let potentialPerson = Person.init(firstName: "Jason", lastName: "Pilz", emailAddress: "jasonpilz@gmail.com", phoneNumber: "720-717-1887", slackScreenName: "jasonpilz", githubUserName: "jasonpilz", twitterUserName: "JasonPilz", linkedInUserName: "Jason Pilz", posse: "Kay", cohort: 1508, employer: "", bio: "", isAlumnus: false, isStaff: false, isMentor: false)
        XCTAssertNotNil(potentialPerson)
        
        // Failure cases
        let noFirstName = Person.init(firstName: "", lastName: "Pilz", emailAddress: "jasonpilz@gmail.com", phoneNumber: "720-717-1887", slackScreenName: "jasonpilz", githubUserName: "jasonpilz", twitterUserName: "JasonPilz", linkedInUserName: "Jason Pilz", posse: "Kay", cohort: 1508, employer: "", bio: "", isAlumnus: false, isStaff: false, isMentor: false)
        XCTAssertNil(noFirstName, "Empty first name is Invalid")
        
        let noLastName = Person.init(firstName: "Jason", lastName: "", emailAddress: "jasonpilz@gmail.com", phoneNumber: "720-717-1887", slackScreenName: "jasonpilz", githubUserName: "jasonpilz", twitterUserName: "JasonPilz", linkedInUserName: "Jason Pilz", posse: "Kay", cohort: 1508, employer: "", bio: "", isAlumnus: false, isStaff: false, isMentor: false)
        XCTAssertNil(noLastName, "Empty last name is Invalid")
    }
    
}
