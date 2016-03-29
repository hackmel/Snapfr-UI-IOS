//
//  ServiceGroupDao.swift
//  Snapfr
//
//  Created by Rommel Suarez on 15/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation

class ServiceGroupDao : IServiceGroupDao {
    
    
    
    /**
     This creates service group and return the created object from a call back via REST API
     - parameter serviceGroup: The serviceGroup object to create.
     - parameter call back : returns the service group and response message.
     - returns:  Nothing
     */
    func createServiceGroup (serviceGroup : ServiceGroup,completion: (data:ServiceGroup!, responseMessage:ResponseMessage!) -> ()){
        
        let responseMessage = ResponseMessage()
        
        let httpUtil = HttpUtil()
        
        let serviceGroupDict = ["name" : serviceGroup.name , "summary":serviceGroup.summary, "profile_id":serviceGroup.profile.id]
        
        httpUtil.sendRequest(serviceGroupDict, method: "POST", url: "http://localhost:3000/createServiceGroup/",
            completion: {(data:NSData!, error:NSError!) in
                
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    return
                }
                
                
                let retVal = ResponseBuilder.populateServiceGroupResponse(data, httpUtil: httpUtil)
                completion (data: retVal.data, responseMessage: responseMessage)
                
        })
        
        
    }
    
    /**
     This updates service group and return the updated object from a call back via REST API
     - parameter serviceGroup: The serviceGroup object to update.
     - parameter call back : returns the service group and response message.
     - returns:  Nothing
     */
    func updateServiceGroup (serviceGroup : ServiceGroup,completion: (data:ServiceGroup!, responseMessage:ResponseMessage!) -> ()){
        
        let responseMessage = ResponseMessage()
        let httpUtil = HttpUtil()
        
        let serviceGroupDict = ["name" : serviceGroup.name , "summary":serviceGroup.summary, "id":serviceGroup.id]
        
        httpUtil.sendRequest(serviceGroupDict, method: "POST", url: "http://localhost:3000/updateServiceGroup/",
            completion: {(data:NSData!, error:NSError!) in
                
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    return
                }
                
                
                let retVal = ResponseBuilder.populateServiceGroupResponse(data, httpUtil: httpUtil)
                completion (data: retVal.data, responseMessage: responseMessage)

                
                
        })
        
        
    }

    /**
     This delete a service group via REST API
     - parameter serviceId: The serviceId  to delete.
     - parameter call back : returns response message.
     - returns:  Nothing
     */
    func deleteServiceGroup (serviceId : String,completion: (data:String!, responseMessage:ResponseMessage!) -> ()){
        
        let responseMessage = ResponseMessage()
        let httpUtil = HttpUtil()
        
        let serviceDict = ["service_group_id":serviceId]
        
        httpUtil.sendRequest(serviceDict,method:"POST",url: "http://localhost:3000/deleteServiceGroup/",
            completion: {(data:NSData!, error:NSError!) in
                
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    
                }
              
                completion (data: "Success",responseMessage: nil)
              
        })
        
        
        
    }
    
    
    
    /**
     This returns all service group via REST API
     - parameter profileId: The profileId  to search.
     - parameter call back : returns the array of service group and response message.
     - returns:  Nothing
     */
    func getAllServiceGroup (profileId:String,completion: (data:Array<ServiceGroup>!, responseMessage:ResponseMessage!) -> ()){
        
        let responseMessage = ResponseMessage()
        let httpUtil = HttpUtil()
        let serviceGroupDict = ["profile_id" : profileId]
        
        httpUtil.sendRequest(serviceGroupDict, method: "POST", url: "http://localhost:3000/getServiceGroupsByProfileId/",
            completion: {(data:NSData!, error:NSError!) in
                
            if error != nil {
               responseMessage.nsError = error
               completion (data: nil,responseMessage: responseMessage)
                      
            }

                    
            let retVal = ResponseBuilder.populateServiceGroupCollectionResponse(data, httpUtil: httpUtil)
            completion (data: retVal.data,responseMessage: retVal.responseMessage)
           
        })
        
        
    }
    
    /**
     This returns a service group via REST API
     - parameter serviceGroupId: The serviceGroupId  to search.
     - parameter call back : returns the service group and response message.
     - returns:  Nothing
     */
    func getServiceGroup (serviceGroupId : String,completion: (data:ServiceGroup!, responseMessage:ResponseMessage!) -> ()) {
        
        let responseMessage = ResponseMessage()
        
        let httpUtil = HttpUtil()
        
        let serviceGroupDict = ["service_groupId" : serviceGroupId]
        
        httpUtil.sendRequest(serviceGroupDict, method: "POST", url: "http://localhost:3000/getServiceGroupById/",
            completion: {(data:NSData!, error:NSError!) in
                
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    return
                }
                
                
                let retVal = ResponseBuilder.populateServiceGroupResponse(data, httpUtil: httpUtil)
                completion (data: retVal.data, responseMessage: responseMessage)
                
        })

    }
    
    
    
        
    
        
    
   
    

    
}