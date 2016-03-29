//
//  ServiceDao.swift
//  Snapfr
//
//  Created by Rommel Suarez on 15/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation


class ServiceDao : IServiceDao {
    
    /**
     This creates a service via REST API and returns the created object via callback
     - parameter service: The service object to create.
     - parameter call back : returns the service and response message.
     - returns:  Nothing
     */
    func createService (service : Service,completion: (data:Service!, responseMessage:ResponseMessage!) -> ()){
        
        let responseMessage = ResponseMessage()
        let httpUtil = HttpUtil()
        
        let serviceDict = ["name" : service.name , "summary":service.summary,"price" : service.price,"service_group_id":service.serviceGroup.id]
        
        httpUtil.sendRequest(serviceDict as! Dictionary<String, AnyObject>,method:"POST",url: "http://localhost:3000/createService/",
            completion: {(data:NSData!, error:NSError!) in
                
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    return
                }
                
                let retVal = ResponseBuilder.populateServiceResponse(data, httpUtil: httpUtil)
                completion (data: retVal.data,responseMessage: retVal.responseMessage)
         })
        
        
        
    }
    
    
       
    
    
    /**
     This updates a service via REST API and returns the updated object via callback
     - parameter service: The service object to update.
     - parameter call back : returns the service and response message.
     - returns:  Nothing
     */
    func updateService (service : Service,completion: (data:Service!, responseMessage:ResponseMessage!) -> ()){

        let responseMessage = ResponseMessage()
        let httpUtil = HttpUtil()
        
        let serviceDict = ["name" : service.name , "summary":service.summary,"price" : service.price, "service_id":service.id]
        
        httpUtil.sendRequest(serviceDict as! Dictionary<String, AnyObject>,method:"POST",url: "http://localhost:3000/updateService/",
            completion: {(data:NSData!, error:NSError!) in
                
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    return
                }
                
                
                let retVal = ResponseBuilder.populateServiceResponse(data, httpUtil: httpUtil)
                completion (data: retVal.data,responseMessage: retVal.responseMessage)
                
                
        })
        
        
        
    }
    
    /**
     This deleted a service via REST API and returns the message status via callback
     - parameter serviceId: The service id to delete.
     - parameter call back : returns the message and response message.
     - returns:  Nothing
     */
    func deleteService (serviceId : String,completion:  (data:String!, responseMessage:ResponseMessage!) -> ()){
        
        let responseMessage = ResponseMessage()
        let httpUtil = HttpUtil()
        
        let serviceDict = ["service_id":serviceId]
        
        httpUtil.sendRequest(serviceDict,method:"POST",url: "http://localhost:3000/deleteService/",
            completion: {(data:NSData!, error:NSError!) in
                
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    return
                }
                
                
                completion (data: "Success",responseMessage: nil)
                
                
        })
        
        
        
    }
    
    /**
     This returns all the services within a group from a call back 
      via REST API
     - parameter groupId: The groupId id to search.
     - parameter call back : returns the array of services and response message.
     - returns:  Nothing
     */
    func getAllServicesByGroup (groupId:String,completion: (data:Array<Service>!, responseMessage:ResponseMessage!) -> ()){
        
        let responseMessage = ResponseMessage()
        let httpUtil = HttpUtil()
        
        
        let serviceGroupDict = ["service_group_id" : groupId]
        
        httpUtil.sendRequest(serviceGroupDict, method: "POST", url: "http://localhost:3000/getServicesByGroupId/",
            completion: {(data:NSData!, error:NSError!) in
                
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    
                }
                
                                
                let retVal = ResponseBuilder.populateServiceCollection(data, httpUtil: httpUtil)
                completion (data: retVal.data,responseMessage: retVal.responseMessage)

                
                
        })
        
        
    }

    /**
     This a services from a call back via REST API
     - parameter serviceId: The serviceId id to search.
     - parameter call back : returns the service and response message.
     - returns:  Nothing
     */
    func getServiceById (serviceId:String,completion: (data:Service!, responseMessage:ResponseMessage!) -> ()){
        
        let responseMessage = ResponseMessage()
        let httpUtil = HttpUtil()
        
        
        let serviceGroupDict = ["service_id" : serviceId]
        
        httpUtil.sendRequest(serviceGroupDict, method: "POST", url: "http://localhost:3000/getServiceById/",
            completion: {(data:NSData!, error:NSError!) in
                
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    
                }
                
                
                let retVal = ResponseBuilder.populateServiceResponse(data, httpUtil: httpUtil)
                completion (data: retVal.data,responseMessage: retVal.responseMessage)
                
                
                
        })
        
        
    }

    
    
        
}