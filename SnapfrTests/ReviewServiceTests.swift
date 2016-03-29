//
//  ReviewServiceTests.swift
//  Snapfr
//
//  Created by Rommel Suarez on 20/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import XCTest

class ReviewServiceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGetReviews() {
       let reviewService = ReviewService(newReviewDao: ReviewDao())
        
        let profile = Profile()
        profile.id = "568fa14122117f5b21406794"
        
        let readyExpectation = expectationWithDescription("ready")
        reviewService.getReviews(profile, isCustomer: true) { (data, responseMessage) -> () in
            XCTAssertTrue(responseMessage.dataCollection.count > 0 , "getReviews returns empty")
            XCTAssertTrue(responseMessage.message == "Successful", "getReviews response message is not successful")
            XCTAssertTrue(responseMessage.code == ResponseStatus.Success, "getReviews return code is not 01")
            XCTAssertTrue(responseMessage.errorType == nil, "getReviews response errorType is not null")
            XCTAssertTrue(responseMessage.error.allKeys.count == 0 , "getReviews response error is not null")
            
            
            // And fulfill the expectation...
            readyExpectation.fulfill()

        }
        
        
        waitForExpectationsWithTimeout(5) { (error) -> Void in
            XCTAssertNil(error, "Error")
        }

    }

    
}
