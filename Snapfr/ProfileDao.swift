//
//  ProfileDao.swift
//  Snapfr
//
//  Created by Rommel Suarez on 11/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation
import FBSDKLoginKit

/**
*
*
*/

class ProfileDao : IProfileDao {
    
    
    /**
     This creates a user profile by sending request to a REST API
     - parameter profile: The profile object to create.
     - parameter image: The profile image of to upload.
     - parameter call back : returns the profile and response message.
     - returns:  Nothing
     */
     func create(profile : Profile, image:NSData ,completion: (data:Profile!, responseMessage:ResponseMessage!) -> ()){
        
        let httpUtil = HttpUtil()
        let responseMessage = ResponseMessage()
        
        let profileDict: Dictionary<String, AnyObject> =
        [
            "name":profile.name,
            "location":profile.location,
            "is_customer":profile.isCustomer,
            "is_photographer":profile.isPhotographer,
            "email":profile.user.email,
            "password": profile.user.password
        ]
        
        
        httpUtil.sendUploadRequest(profileDict,imageData:image,imageKey:"avatar",method:"POST",url: "http://localhost:3000/registerUserProfile/",
            completion: {(data:NSData!, error:NSError!) in
                
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    return
                }
                
                
                let retVal = ResponseBuilder.populateProfileResponse(data, httpUtil: httpUtil)
                
                completion (data: retVal.data,responseMessage: retVal.responseMessage)
                
        })
        
        
    }
    
    
    
    /**
     This updates a user profile by sending request to a REST API
     - parameter profile: The profile object to create.
     - parameter image: The profile image of to upload.
     - parameter call back : returns the profile and response message.
     - returns:  Nothing
     */
     func update(profile : Profile, image:NSData! ,completion: (data:Profile!, responseMessage:ResponseMessage!) -> ()){
        
        
        let httpUtil = HttpUtil()
        let responseMessage = ResponseMessage()
        
        
        
        let profileDict: Dictionary<String, AnyObject> =
        [
            "name":profile.name,
            "location":profile.location,
            "is_customer":profile.isCustomer,
            "is_photographer":profile.isPhotographer,
            "email":profile.user.email,
            "password": profile.user.password
        ]
        
        

        
        if image != nil {
            
            
            httpUtil.sendUploadRequest(profileDict,imageData:image,imageKey:"avatar",method:"POST",url: "http://localhost:3000/updateUserProfilewithAvatar/",
                completion: {(data:NSData!, error:NSError!) in
                    if error != nil {
                        responseMessage.nsError = error
                        completion (data: nil,responseMessage: responseMessage)
                        return
                    }
                    
                    
                    let retVal = ResponseBuilder.populateProfileResponse(data, httpUtil: httpUtil)
                    
                    completion (data: retVal.data,responseMessage: retVal.responseMessage)
                    
                    
                    
            })
            
            
            
        }else {
            
            httpUtil.sendRequest(profileDict, method: "POST", url: "http://localhost:3000/updateUserProfile/",
                completion: {(data:NSData!, error:NSError!) in
                    if error != nil {
                        responseMessage.nsError = error
                        completion (data: nil,responseMessage: responseMessage)
                        return
                    }
                    
                    
                    let retVal = ResponseBuilder.populateProfileResponse(data, httpUtil: httpUtil)
                    
                    completion (data: retVal.data,responseMessage: retVal.responseMessage)
                    
                    
                    
            })
            
            
        }
    }
    
    
    
    /**
     This returns a user profile through a call back by sending request to a REST API
     - parameter profileId: The profile id to search.
     - parameter call back : returns the profile and response message.
     - returns:  Nothing
     */
     func findProfile(profileId: String, completion: (data:Profile!, responseMessage:ResponseMessage!) -> ()){
        let httpUtil = HttpUtil()
        let responseMessage = ResponseMessage()
        
        
        let nameDict: Dictionary<String, AnyObject> =
        [
            "profile_id":profileId
        ]
        
        
        httpUtil.sendRequest(nameDict,method:"POST" ,url: "http://localhost:3000/getProfileById"
            , completion: {(data:NSData!, error:NSError!) in
            
            if error != nil {
                responseMessage.nsError = error
                completion (data: nil,responseMessage: responseMessage)
                return
            }
            
            let retVal = ResponseBuilder.populateProfileResponse(data, httpUtil: httpUtil)
            
            completion (data: retVal.data,responseMessage: retVal.responseMessage)
            
            
            
            
            
            
        })
        
        
    }
    
    /**
     This returns a user profile through a call back by sending request to a REST API
     - parameter name: The profile name to search.
     - parameter call back : returns the array of profiles and response message.
     - returns:  Nothing
     */
     func findProfileByName(name: String, completion: (data:Array<Profile>!, responseMessage:ResponseMessage!) -> ()){
        
        let httpUtil = HttpUtil()
        let responseMessage = ResponseMessage()
        
        let nameDict: Dictionary<String, AnyObject> =
        [
            "name":name
        ]
        
        
        httpUtil.sendRequest(nameDict,method:"POST" ,url: "http://localhost:3000/getProfileByName", completion: {(data:NSData!, error:NSError!) in
            
            if error != nil {
                responseMessage.nsError = error
                completion (data: nil,responseMessage: responseMessage)
                return
            }
            
            let retVal = ResponseBuilder.populateProfileCollectionResponse(data, httpUtil: httpUtil)
            
            completion (data: retVal.data,responseMessage: retVal.responseMessage)
  
           
        })
        
        
    }
    
    
    /**
     This returns a user profile through a call back by sending request to a REST API
     - parameter email: The profile email to search.
     - parameter call back : returns the profile and response message.
     - returns:  Nothing
     */
    func findByEmail(email: String, completion: (data:Profile!, responseMessage:ResponseMessage!) -> ()){
        
        let httpUtil = HttpUtil()
        let responseMessage = ResponseMessage()
        
        let nameDict: Dictionary<String, AnyObject> =
        [
            "email":email
        ]
        
        
        httpUtil.sendRequest(nameDict,method:"POST" ,url: "http://localhost:3000/getProfileByEmail", completion: {(data:NSData!, error:NSError!) in
            
            
            if error != nil {
                responseMessage.nsError = error
                completion (data: nil,responseMessage: responseMessage)
                return
            }
            
            let retVal = ResponseBuilder.populateProfileResponse(data, httpUtil: httpUtil)
            
            completion (data: retVal.data,responseMessage: retVal.responseMessage)
            
            
            
        })
        
        
        
        
        
    }
    
    
    
    
    /**
     This returns the current user social media data through a call back by sending request to a REST API
     - parameter name: The profile name to search.
     - parameter call back : returns the profile and response message.
     - returns:  Nothing
     */
     func getSocialNetworkData(completion: (data:Profile!, responseMessage:ResponseMessage!) -> ()){
        
        let responseMessage = ResponseMessage()
        
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email,location"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    
                    let profile = Profile()
                    let user = User()
                    
                    let name = result.valueForKey("name")as! String
                    let email = result.valueForKey("email") as! String
                    
                    
                    var location = ""
                    if let locationJSON: NSDictionary = result.valueForKey("location") as? NSDictionary {
                        location = locationJSON.valueForKey("name") as! String
                        
                    }
                    
                    if let profilePicArrayJSON: NSDictionary = result.valueForKey("picture") as? NSDictionary {
                        if let profilePicArray: AnyObject = profilePicArrayJSON.valueForKey("data") {
                            if let profilePicObjs = profilePicArray as? NSDictionary {
                                
                                if let profilePicture = profilePicObjs.valueForKey("url") as? String {
                                    profile.avatar = profilePicture
                                }
                            }
                        }
                        
                        
                    }
                    
                    
                    
                    
                    user.email = email
                    profile.name = name
                    profile.location = location
                    profile.user = user
                    
                    completion(data: profile,responseMessage: nil)
                    
                    
                }else{
                    responseMessage.nsError =  error
                    completion(data: nil,responseMessage: responseMessage)
                }
            })
        }
    }
    
    
         
    
    
    
}
