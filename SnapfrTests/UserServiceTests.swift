//
//  UserServiceTests.swift
//  Snapfr
//
//  Created by Rommel Suarez on 10/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import UIKit
import XCTest
@testable import Snapfr


class UserServiceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    
    
    func testGetProfileById() {
        
        let userService = UserService(newProfileDao: ProfileDao(),newUserDao: UserDao())
        
        let user = User()
        
        user.email = "hackmel@yahoo.com"
        user.password = ""
        
        // Declare our expectation
        let readyExpectation = expectationWithDescription("ready")
        
        userService.getProfileById("568e546e7f457c4f1c78d05e") { (data, responseMessage) -> () in
            
            XCTAssertTrue(data != nil, "getProfileById returns nil")
            XCTAssertTrue(responseMessage.message == "Successful", "getProfileById response message is not successful")
            XCTAssertTrue(responseMessage.code == ResponseStatus.Success, "getProfileById return code is not 01")
            XCTAssertTrue(responseMessage.errorType == nil, "getProfileById response errorType is not null")
            XCTAssertTrue(responseMessage.error.allKeys.count == 0 , "getProfileById response error is not null")
            
            
            // And fulfill the expectation...
            readyExpectation.fulfill()
        }
        
        
        waitForExpectationsWithTimeout(5) { (error) -> Void in
            XCTAssertNil(error, "Error")
        }
    }

    
    func testIsUserExist() {
       
        let userService = UserService(newProfileDao: ProfileDao(),newUserDao: UserDao())
        
        let user = User()
        
        user.email = "hackmel@yahoo.com"
        user.password = ""
        
        // Declare our expectation
        let readyExpectation = expectationWithDescription("ready")
        
        userService.isUserExist(user) { (data, responseMessage) -> () in
            
            XCTAssertTrue(data != nil, "IsUserExist returns nil")
            XCTAssertTrue(responseMessage.message == "Successful", "IsUserExist response message is not successful")
            XCTAssertTrue(responseMessage.code == ResponseStatus.Success, "IsUserExist return code is not 01")
            XCTAssertTrue(responseMessage.errorType == nil, "IsUserExist response errorType is not null")
            XCTAssertTrue(responseMessage.error.allKeys.count == 0 , "IsUserExist response error is not null")
            
            
            // And fulfill the expectation...
            readyExpectation.fulfill()
        }
        
        
        waitForExpectationsWithTimeout(5) { (error) -> Void in
            XCTAssertNil(error, "Error")
        }
    }

    
    func testGetProfileByEmail() {
       
   
        let userService = UserService(newProfileDao: ProfileDao(),newUserDao: UserDao())
      
        
        
        
        // Declare our expectation
        let readyExpectation = expectationWithDescription("ready")
        
        userService.getProfileByEmail("hackmel@yahoo.com") { (data, responseMessage) -> () in
            
            
            XCTAssertTrue(data != nil, "getProfileByEmail returns nil")
            XCTAssertTrue(responseMessage.message == "Successful", "getProfileByEmail response message is not successful")
            XCTAssertTrue(responseMessage.code == ResponseStatus.Success, "getProfileByEmail return code is not 01")
            XCTAssertTrue(responseMessage.errorType == nil, "getProfileByEmail response errorType is not null")
            XCTAssertTrue(responseMessage.error.allKeys.count == 0 , "getProfileByEmail response error is not null")
            
            // And fulfill the expectation...
            readyExpectation.fulfill()
        }
        
        
        waitForExpectationsWithTimeout(5) { (error) -> Void in
            XCTAssertNil(error, "Error")
        }
    }
        
        
    func testLogin() {
            
        
        let userService = UserService(newProfileDao: ProfileDao(), newUserDao: UserDao())
            
            let user = User()
        
             user.email = "hackmel@yahoo.com"
             user.password = ""
            
            
            // Declare our expectation
            let readyExpectation = expectationWithDescription("ready")
            
            userService.login(user) { (data, responseMessage) -> () in
                
                XCTAssertTrue(data != nil, "login returns nil")
                XCTAssertTrue(responseMessage.message == "Successful", "login response message is not successful")
                XCTAssertTrue(responseMessage.code == ResponseStatus.Success, "login return code is not 01")
                XCTAssertTrue(responseMessage.errorType == nil, "login response errorType is not null")
                XCTAssertTrue(responseMessage.error.allKeys.count == 0 , "login response error is not null")

                
                // And fulfill the expectation...
                readyExpectation.fulfill()

             }
        
                
        
        
            
            
            waitForExpectationsWithTimeout(5) { (error) -> Void in
                XCTAssertNil(error, "Error")
            }

    
        
    }
    
    func testGetProfileByName() {
        
        
        let userService = UserService(newProfileDao: ProfileDao(), newUserDao: UserDao())
        
        let user = User()
        
        user.email = "hackmel@yahoo.com"
        user.password = ""
        
        
        // Declare our expectation
        let readyExpectation = expectationWithDescription("ready")
        
        userService.getProfileByName("test", completion: { (data, responseMessage) -> () in
            
            XCTAssertTrue(responseMessage.dataCollection.count > 0 , "getProfileByName returns empty")
            XCTAssertTrue(responseMessage.message == "Successful", "getProfileByName response message is not successful")
            XCTAssertTrue(responseMessage.code == ResponseStatus.Success, "getProfileByName return code is not 01")
            XCTAssertTrue(responseMessage.errorType == nil, "getProfileByName response errorType is not null")
            XCTAssertTrue(responseMessage.error.allKeys.count == 0 , "getProfileByName response error is not null")
            
            
            // And fulfill the expectation...
            readyExpectation.fulfill()
            

        })
            
        
        
        
        
        
        
        
        waitForExpectationsWithTimeout(5) { (error) -> Void in
            XCTAssertNil(error, "Error")
        }
        
        
        
    }


    
}
