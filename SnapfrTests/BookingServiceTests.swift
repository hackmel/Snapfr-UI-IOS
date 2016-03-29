//
//  BookingServiceTests.swift
//  Snapfr
//
//  Created by Rommel Suarez on 20/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import XCTest

class BookingServiceTests: XCTestCase {
    
    let bookingService = BookingService(newBookingDao: BookingDao())

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGetPendingBookingRequestsAsCustomer() {
        
        let readyExpectation = expectationWithDescription("ready")
        
        
        bookingService.getPendingBookingRequestsAsCustomer("55f95ef1fee9b8112700000e") { (data, responseMessage) -> () in
            
            XCTAssertTrue(responseMessage.dataCollection.count > 0 , "getPendingBookingRequestsAsCustomer returns empty")
            XCTAssertTrue(responseMessage.message == "Successful", "getPendingBookingRequestsAsCustomer response message is not successful")
            XCTAssertTrue(responseMessage.code == ResponseStatus.Success, "getPendingBookingRequestsAsCustomer return code is not 01")
            XCTAssertTrue(responseMessage.errorType == nil, "getPendingBookingRequestsAsCustomer response errorType is not null")
            XCTAssertTrue(responseMessage.error.allKeys.count == 0 , "getPendingBookingRequestsAsCustomer response error is not null")
            
            
            // And fulfill the expectation...
            readyExpectation.fulfill()

        }
       
            
         waitForExpectationsWithTimeout(5) { (error) -> Void in
                XCTAssertNil(error, "Error")
    }
   }

  func testGgetPendingBookingRequestsFromCustomers() {
        
        let readyExpectation = expectationWithDescription("ready")
        
        
        bookingService.getPendingBookingRequestsFromCustomers("55f95af4fee9b8112700000a") { (data, responseMessage) -> () in
            
            XCTAssertTrue(responseMessage.dataCollection.count > 0 , "getPendingBookingRequestsFromCustomers returns empty")
            XCTAssertTrue(responseMessage.message == "Successful", "getPendingBookingRequestsFromCustomers response message is not successful")
            XCTAssertTrue(responseMessage.code == ResponseStatus.Success, "getPendingBookingRequestsFromCustomers return code is not 01")
            XCTAssertTrue(responseMessage.errorType == nil, "getPendingBookingRequestsFromCustomers response errorType is not null")
            XCTAssertTrue(responseMessage.error.allKeys.count == 0 , "getPendingBookingRequestsFromCustomers response error is not null")
            
            
            // And fulfill the expectation...
            readyExpectation.fulfill()
            
        }
        
        
        waitForExpectationsWithTimeout(5) { (error) -> Void in
            XCTAssertNil(error, "Error")
        }
    }

    
    func testGetBookingsAsCustomer() {
        
        let readyExpectation = expectationWithDescription("ready")
        
        
        bookingService.getBookingsAsCustomer("55f95ef1fee9b8112700000e") { (data, responseMessage) -> () in
            
            XCTAssertTrue(responseMessage.dataCollection.count > 0 , "getBookingsAsCustomer returns empty")
            XCTAssertTrue(responseMessage.message == "Successful", "getBookingsAsCustomer response message is not successful")
            XCTAssertTrue(responseMessage.code == ResponseStatus.Success, "getBookingsAsCustomer return code is not 01")
            XCTAssertTrue(responseMessage.errorType == nil, "getBookingsAsCustomer response errorType is not null")
            XCTAssertTrue(responseMessage.error.allKeys.count == 0 , "getBookingsAsCustomer response error is not null")
            
            
            // And fulfill the expectation...
            readyExpectation.fulfill()
            
        }
        
        
        waitForExpectationsWithTimeout(5) { (error) -> Void in
            XCTAssertNil(error, "Error")
        }
    }

    
    func testGetBookingsFromCustomers() {
        
        let readyExpectation = expectationWithDescription("ready")
        
        
        bookingService.getBookingsFromCustomers("55f95af4fee9b8112700000a") { (data, responseMessage) -> () in
            
            XCTAssertTrue(responseMessage.dataCollection.count > 0 , "getBookingsFromCustomers returns empty")
            XCTAssertTrue(responseMessage.message == "Successful", "getBookingsFromCustomers response message is not successful")
            XCTAssertTrue(responseMessage.code == ResponseStatus.Success, "getBookingsFromCustomers return code is not 01")
            XCTAssertTrue(responseMessage.errorType == nil, "getBookingsFromCustomers response errorType is not null")
            XCTAssertTrue(responseMessage.error.allKeys.count == 0 , "getBookingsFromCustomers response error is not null")
            
            
            // And fulfill the expectation...
            readyExpectation.fulfill()
            
        }
        
        
        waitForExpectationsWithTimeout(5) { (error) -> Void in
            XCTAssertNil(error, "Error")
        }
    }


}
