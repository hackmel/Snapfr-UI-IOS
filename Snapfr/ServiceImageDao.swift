//
//  ServiceImageDao.swift
//  Snapfr
//
//  Created by Rommel Suarez on 16/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation

class ServiceImageDao : IServiceImageDao {
    
    
    /**
     This deletes service uploaded image via REST API
     - parameter serviceGroup: The serviceGroup object to update.
     - parameter call back : returns the response message.
     - returns:  Nothing
     */
    func deleteServicePhoto (id : String,completion: (data:String!, responseMessage:ResponseMessage!) -> ()){
        
        let responseMessage = ResponseMessage()
        let httpUtil = HttpUtil()
        
        let serviceImageDict = ["id" : id]
        
        httpUtil.sendRequest(serviceImageDict, method: "POST", url: "http://localhost:3000/deleteServicePhoto/",
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
     This uploads a service  image via REST API
     - parameter service: The service object to create.
     - parameter call back : returns the service and response message.
     - returns:  Nothing
     */
    
    func addServicePhoto (service : Service,imageData:NSData,completion: (data:Service!, responseMessage:ResponseMessage!) -> ()){
        
        let responseMessage = ResponseMessage()
        let httpUtil = HttpUtil()
        
        let serviceDict = ["service_id":service.id]
        
        httpUtil.sendUploadRequest(serviceDict,imageData:imageData,imageKey:"service_image",method:"POST",url: "http://localhost:3000/addServicePhoto/",
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
     This returns all the service  image via REST API
     - parameter serviceId: The serviceId to search.
     - parameter call back : returns array of service images and response message.
     - returns:  Nothing
     */
    func getAllPhotosByServie (serviceId:String,completion: (data:Array<ServiceImage>!, responseMessage:ResponseMessage!) -> ()){
        
        let responseMessage = ResponseMessage()
        let httpUtil = HttpUtil()
        
        
        let serviceGroupDict = ["service_id" : serviceId]
        
        httpUtil.sendRequest(serviceGroupDict, method: "POST", url: "http://localhost:3000/getServicePhotosByService/",
            completion: {(data:NSData!, error:NSError!) in
                
                
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    
                }
                
                
                let retVal = ResponseBuilder.populateServiceImageCollection(data, httpUtil: httpUtil)
                completion (data: retVal.data,responseMessage: retVal.responseMessage)
                
                
        })
        
        
    }
    

}
