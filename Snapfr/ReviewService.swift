//
//  ReviewService.swift
//  Snapfr
//
//  Created by Rommel Suarez on 22/11/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

/**
 This class implements the service layer of Review object
 */
class ReviewService {
    
    var reviewDao : IReviewDao
    
    init(newReviewDao : IReviewDao){
        self.reviewDao = newReviewDao
    }
    
    /**
     This writes a review from users
     - parameter review: The review object to create.
     - parameter call back : returns the review and response message.
     - returns:  Nothing
     */
    func createReview(review : Review ,completion: (data:Review!, responseMessage:ResponseMessage!) -> ()){
        reviewDao.createReview(review) { (data, responseMessage) -> () in
            completion(data: data, responseMessage: responseMessage)
        }
        
        
    }
    
    /**
     This updates a review from users
     - parameter review: The review object to update.
     - parameter call back : returns the review and response message.
     - returns:  Nothing
     */

    
    func updateReview(review : Review ,completion: (data:Review!, responseMessage:ResponseMessage!) -> ()){
        
        reviewDao.updateReview(review) { (data, responseMessage) -> () in
            completion(data: data, responseMessage: responseMessage)
        }
        
        
        
    }
    
    /**
     This returns all the reviews of a user
     - parameter profile: The profile object to search.
     - parameter isCustomer: true for customer.
     - parameter call back : returns array of reviews and response message.
     - returns:  Nothing
     */

    func getReviews(profile : Profile,isCustomer: Bool ,completion: (data:Array<Review>!, responseMessage:ResponseMessage!) -> ()){
        
        reviewDao.getReviews(profile, isCustomer: isCustomer) { (data, responseMessage) -> () in
            completion(data: data, responseMessage: responseMessage)
        }
        
       
    }


    
 
}
