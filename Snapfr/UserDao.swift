//
//  UserDao.swift
//  Snapfr
//
//  Created by Rommel Suarez on 15/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation

class UserDao : IUserDao {
    
    /**
     This returns a user  by passing the profile email address and password from a REST API
     - parameter email: The profile email address to search.
     - parameter password: The profile password to search.
     - parameter call back : returns the user and response message.
     - returns:  Nothing
     */
    
     func findByEmailAndPassword(user: User, completion: (data:User!, responseMessage:ResponseMessage!)  -> ()){
        
        let emailDict: Dictionary<String, AnyObject> =
        [
            "email":user.email,
            "password":user.password
        ]
        
        let url = "http://localhost:3000/getUserByEmailPassword/";
        
        
        ResponseBuilder.populateUserResponse(emailDict, url: url) { (data, reponseMessage) -> () in
            completion (data: data,responseMessage: reponseMessage);
        }
        
        
    }
    
    /**
     This returns a user  by passing the profile email address from a REST API
     - parameter email: The profile email address to search.
     - parameter call back : returns the user and response message.
     - returns:  Nothing
     */
     func findByEmail(user: User, completion: (data:User!, responseMessage:ResponseMessage!)  -> ()){
        
        let emailDict: Dictionary<String, AnyObject> =
        [
            "email":user.email
        ]
        
        let url = "http://localhost:3000/getUserByEmail/";
        
        
        ResponseBuilder.populateUserResponse(emailDict, url: url) { (data, reponseMessage) -> () in
            completion (data: data,responseMessage: reponseMessage);
        }
        
        
    }
    
    
    
}
