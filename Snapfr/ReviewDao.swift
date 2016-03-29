//
//  ReviewDao.swift
//  Snapfr
//
//  Created by Rommel Suarez on 20/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation

class ReviewDao : IReviewDao {
    
    /**
     This writes a review from users via REST Api
     - parameter review: The review object to create.
     - parameter call back : returns the review and response message.
     - returns:  Nothing
     */
    func createReview(review : Review ,completion: (data:Review!, responseMessage:ResponseMessage!) -> ()){

        
        
        let httpUtil = HttpUtil()
        let responseMessage = ResponseMessage()
        
        
        let reviewDict: Dictionary<String, AnyObject> =
        [
            "booking_id":review.booking.id,
            "rating":review.rating,
            "comments":review.comments,
            "rating_for":review.ratingFor.id,
            "rating_from":review.ratingFrom.id,
            "is_customer":review.isCustomer
            
        ]
        
        
        httpUtil.sendRequest(reviewDict,method:"POST",url: "http://localhost:3000/createReview/",
            completion: {(data:NSData!, error:NSError!) in
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    return
                }
                
                
                let retVal = ResponseBuilder.populateReviewResponse(data, httpUtil: httpUtil)
                completion (data: retVal.data,responseMessage: retVal.responseMessage)
                
                
        })
        
        
    }
    
    /**
     This updates a review from users via REST API
     - parameter review: The review object to update.
     - parameter call back : returns the review and response message.
     - returns:  Nothing
     */
    
    func updateReview(review : Review ,completion: (data:Review!, responseMessage:ResponseMessage!) -> ()){
        
        
        let httpUtil = HttpUtil()
        let responseMessage = ResponseMessage()
        
        
        let reviewDict: Dictionary<String, AnyObject> =
        [
            "booking_id":review.booking.id,
            "rating":review.rating,
            "comments":review.comments,
            "rating_for":review.ratingFor.id,
            "rating_from":review.ratingFrom.id,
            "is_customer":review.isCustomer,
            "id":review.id
            
        ]
        
        
        httpUtil.sendRequest(reviewDict,method:"POST",url: "http://localhost:3000/updateReview/",
            completion: {(data:NSData!, error:NSError!) in
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    return
                }
                
                let retVal = ResponseBuilder.populateReviewResponse(data, httpUtil: httpUtil)
                completion (data: retVal.data,responseMessage: retVal.responseMessage)
                
                
                
                
                
        })
        
        
    }
    
    /**
     This returns all the reviews of a user via REST API
     - parameter profile: The profile object to search.
     - parameter isCustomer: true for customer.
     - parameter call back : returns array of reviews and response message.
     - returns:  Nothing
     */
    func getReviews(profile : Profile,isCustomer: Bool ,completion: (data:Array<Review>!, responseMessage:ResponseMessage!) -> ()){
        
        
        let httpUtil = HttpUtil()
        let responseMessage = ResponseMessage()
        
        
        let reviewDict: Dictionary<String, AnyObject> =
        [
            "rating_for":profile.id,
            "is_customer":isCustomer
            
            
        ]
        
        
        httpUtil.sendRequest(reviewDict,method:"POST",url: "http://localhost:3000/getReviews/",
            completion: {(data:NSData!, error:NSError!) in
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    return
                }
                
                let retVal = ResponseBuilder.populateReviewResponseCollection(data, httpUtil: httpUtil)
                completion (data: retVal.data,responseMessage: retVal.responseMessage)
                
                
                
                
        })
        
        
    }
    
    

    
}
