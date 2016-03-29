//
//  IProfileDao.swift
//  Snapfr
//
//  Created by Rommel Suarez on 11/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation

protocol IProfileDao {
    /**
     This creates a user profile
     - parameter profile: The profile object to create.
     - parameter image: The profile image of to upload.
     - parameter call back : returns the profile and response message.
     - returns:  Nothing
     */
    func create(profile : Profile, image:NSData ,completion: (data:Profile!, responseMessage:ResponseMessage!) -> ())
    
    /**
     This updates a user profile
     - parameter profile: The profile object to create.
     - parameter image: The profile image of to upload.
     - parameter call back : returns the profile and response message.
     - returns:  Nothing
     */
    func update(profile : Profile, image:NSData! ,completion: (data:Profile!, responseMessage:ResponseMessage!) -> ())
    
    /**
     This returns a user profile from a callback by passing the profile id
     - parameter profileId: The profile id to search.
     - parameter call back : returns the profile and response message.
     - returns:  Nothing
     */
    func findProfile(profileId: String, completion: (data:Profile!, responseMessage:ResponseMessage!) -> ())
    
    /**
     This returns a user profile from a callback by passing the profile name
     - parameter name: The profile name to search.
     - parameter call back : returns an array of profile and response message.
     - returns:  Nothing
     */
    func findProfileByName(name: String, completion: (data:Array<Profile>!, responseMessage:ResponseMessage!) -> ())
    
    /**
     This returns a user profile from a callback by passing the profile email address
     - parameter email: The profile email address to search.
     - parameter call back : returns the profile and response message.
     - returns:  Nothing
     */
    func findByEmail(email: String, completion: (data:Profile!, responseMessage:ResponseMessage!) -> ())
    
    /**
     This returns the social network info from a callback of the current user
     - parameter call back : returns the profile and response message.
     - returns:  Nothing
     */
    func getSocialNetworkData(completion: (data:Profile!, responseMessage:ResponseMessage!) -> ())
}
