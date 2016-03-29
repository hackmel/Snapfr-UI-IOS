//
//  IUserDao.swift
//  Snapfr
//
//  Created by Rommel Suarez on 15/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation

protocol IUserDao {
    /**
     This returns a user  from a callback by passing the profile email address and password
     - parameter email: The profile email address to search.
     - parameter password: The profile password to search.
     - parameter call back : returns the user and response message.
     - returns:  Nothing
     */
    func findByEmailAndPassword(user: User, completion: (data:User!, responseMessage:ResponseMessage!)  -> ())
    
    /**
     This returns a user from a callback  by passing the profile email address
     - parameter email: The profile email address to search.
     - parameter call back : returns the user and response message.
     - returns:  Nothing
     */
    func findByEmail(user: User, completion: (data:User!, responseMessage:ResponseMessage!)  -> ())
    
    
    
    
}
