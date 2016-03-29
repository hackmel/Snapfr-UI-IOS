//
//  UserService.swift
//  Snapfr
//
//  Created by Rommel Suarez on 22/8/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import Foundation

/**
 This class implements the service layer of user object
 */
class UserService {
    
    var profileDao : IProfileDao
    var userDao : IUserDao
    
    /**
     This initialize dependency injection
     - parameter newProfileDao: IProfileDao implementation.
     - parameter newUserDao: IUserDao implementation.
     - returns:  Nothing
     */
    
    init(newProfileDao:IProfileDao, newUserDao:IUserDao){
        self.profileDao = newProfileDao
        self.userDao = newUserDao
        
    }
    
    
    /**
     This registers a new user to the app
     - parameter profile: The profile object to create.
     - parameter image: profile image of the user to create.
     - parameter call back : returns the new profile and response message.
     - returns:  Nothing
     */
    func signIn(profile : Profile, image:NSData ,completion: (data:Profile!, responseMessage:ResponseMessage!) -> ()){
        profileDao.create(profile, image: image) { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
        }
        
       
    }
    
    /**
     This logs-in an existing user to the app
     - parameter user: The user object to login.
     - parameter call back : returns the user and response message.
     - returns:  Nothing
     */

    func login(user: User, completion: (data:User!, responseMessage:ResponseMessage!)  -> ()){
        
        userDao.findByEmailAndPassword(user) { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
        }
        
       
    }
    
    
    /**
     This check if a user exist
     - parameter user: The user object to check.
     - parameter call back : returns the user and response message.
     - returns:  Nothing
     */
    func isUserExist(user:User,  completion: (data:User!, responseMessage:ResponseMessage!)  -> ()){
        userDao.findByEmail(user) { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
        }
        
    }
    
    /**
     This returns a user profile by using email
     - parameter email: The email to search.
     - parameter call back : returns the user profle and response message.
     - returns:  Nothing
     */
    func getProfileByEmail(email: String, completion: (data:Profile!,  responseMessage:ResponseMessage!) -> ()) {
        
        profileDao.findByEmail(email) { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
        }
        
        
        
        
    }
    

    /**
     This returns a user profile by using profileId
     - parameter profileId: The profileId to search.
     - parameter call back : returns the user profle and response message.
     - returns:  Nothing
     */
    
    func getProfileById(profileId: String, completion: (data:Profile!,  responseMessage:ResponseMessage!) -> ()) {
         profileDao.findProfile(profileId, completion: { (data, responseMessage) -> () in
             completion (data:data, responseMessage:responseMessage);
        })
        
        
    }

    
    /**
     This returns a user profile by using name
     - parameter name: The name to search.
     - parameter call back : returns array of user profle and response message.
     - returns:  Nothing
     */
    func getProfileByName(name: String, completion: (data:[Profile]!,  responseMessage:ResponseMessage!) -> ()) {
        profileDao.findProfileByName(name) { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
        }
       
    }

    
    /**
     This returns facebook profile of the current user
     - parameter call back : returns user profle and response message.
     - returns:  Nothing
     */
    
    func getFBUserData(completion: (data:Profile!, responseMessage:ResponseMessage!) -> ()) {
        profileDao.getSocialNetworkData { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
        }
    }
    
    
    
    
    /**
     This updates user profile
    - parameter profile: The profile object to update.
     - parameter call back : returns user profle and response message.
     - returns:  Nothing
     */
    func updateUserProfile(profile : Profile, image:NSData! ,completion: (data:Profile!,  responseMessage:ResponseMessage!) -> ()) {
        
        profileDao.update(profile, image: image) { (data, responseMessage) -> () in
            completion(data: data,responseMessage: responseMessage)
        }
        
      
    }
    
    


    
    

    
}




