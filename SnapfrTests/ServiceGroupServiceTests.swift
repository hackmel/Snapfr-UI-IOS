//
//  ServiceGroupServiceTests.swift
//  Snapfr
//
//  Created by Rommel Suarez on 20/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import XCTest

class ServiceGroupServiceTests: XCTestCase {

    let serviceGroup = ServiceGroupServices(newServiceDao: ServiceDao(), newServiceGroupDao: ServiceGroupDao(), newServiceImageDao: ServiceImageDao())
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
      
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testgetServiceGroupsByProfileId() {
        
        let profileId = "568fa14122117f5b21406794"
        
        let readyExpectation = expectationWithDescription("ready")
        
        serviceGroup.getAllServiceGroup(profileId, completion: { (data, responseMessage) -> () in
            XCTAssertTrue(responseMessage.dataCollection.count > 0 , "getAllServiceGroup returns empty")
            XCTAssertTrue(responseMessage.message == "Successful", "getAllServiceGroup response message is not successful")
            XCTAssertTrue(responseMessage.code == ResponseStatus.Success, "getAllServiceGroup return code is not 01")
            XCTAssertTrue(responseMessage.errorType == nil, "getAllServiceGroup response errorType is not null")
            XCTAssertTrue(responseMessage.error.allKeys.count == 0 , "getAllServiceGroup response error is not null")
            
            
            // And fulfill the expectation...
            readyExpectation.fulfill()
            

        })
            
        
        
        
        waitForExpectationsWithTimeout(5) { (error) -> Void in
            XCTAssertNil(error, "Error")
        }
    

       
    }

    
    func testGetServicesByGroupId() {
        
        let serviceId = "561a675ee860bd08da000026"
        
        let readyExpectation = expectationWithDescription("ready")
        
       
        serviceGroup.getAllServicesByGroup(serviceId, completion: { (data, responseMessage) -> () in
            XCTAssertTrue(responseMessage.dataCollection.count > 0 , "getAllServicesByGroup returns empty")
            XCTAssertTrue(responseMessage.message == "Successful", "getAllServicesByGroup response message is not successful")
            XCTAssertTrue(responseMessage.code == ResponseStatus.Success, "getAllServicesByGroup return code is not 01")
            XCTAssertTrue(responseMessage.errorType == nil, "getAllServicesByGroup response errorType is not null")
            XCTAssertTrue(responseMessage.error.allKeys.count == 0 , "getAllServicesByGroup response error is not null")
            
            
            // And fulfill the expectation...
            readyExpectation.fulfill()
            
            
        })
        
        
        
        
        waitForExpectationsWithTimeout(5) { (error) -> Void in
            XCTAssertNil(error, "Error")
        }
        
        
        
    }
    
    func testGetAllPhotosByServie() {
        
        let serviceId = "561a675ee860bd08da000026"
        
        let readyExpectation = expectationWithDescription("ready")
        
        
        serviceGroup.getAllPhotosByServie(serviceId, completion: { (data, responseMessage) -> () in
            XCTAssertTrue(responseMessage.dataCollection.count > 0 , "getAllPhotosByServie returns empty")
            XCTAssertTrue(responseMessage.message == "Successful", "getAllPhotosByServie response message is not successful")
            XCTAssertTrue(responseMessage.code == ResponseStatus.Success, "getAllPhotosByServie return code is not 01")
            XCTAssertTrue(responseMessage.errorType == nil, "getAllPhotosByServie response errorType is not null")
            XCTAssertTrue(responseMessage.error.allKeys.count == 0 , "getAllPhotosByServie response error is not null")
            
            
            // And fulfill the expectation...
            readyExpectation.fulfill()
            
            
        })
        
        
        
        
        waitForExpectationsWithTimeout(5) { (error) -> Void in
            XCTAssertNil(error, "Error")
        }
        
        
        
    }


   
}
