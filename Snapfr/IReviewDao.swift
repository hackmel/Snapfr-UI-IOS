//
//  IReviewDao.swift
//  Snapfr
//
//  Created by Rommel Suarez on 20/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation

protocol IReviewDao {
    
    /**
     This writes a review from users
     - parameter review: The review object to create.
     - parameter call back : returns the review and response message.
     - returns:  Nothing
     */
    func createReview(review : Review ,completion: (data:Review!, responseMessage:ResponseMessage!) -> ())
    /**
     This updates a review from users
     - parameter review: The review object to update.
     - parameter call back : returns the review and response message.
     - returns:  Nothing
     */
    func updateReview(review : Review ,completion: (data:Review!, responseMessage:ResponseMessage!) -> ())
    
    /**
     This returns all the reviews of a user
     - parameter profile: The profile object to search.
     - parameter isCustomer: true for customer.
     - parameter call back : returns array of reviews and response message.
     - returns:  Nothing
     */
    func getReviews(profile : Profile,isCustomer: Bool ,completion: (data:Array<Review>!, responseMessage:ResponseMessage!) -> ())
    
}
