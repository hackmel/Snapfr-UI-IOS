//
//  IServiceImageDao.swift
//  Snapfr
//
//  Created by Rommel Suarez on 16/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation

protocol IServiceImageDao {
    
    
    /**
     This deletes service uploaded image
     - parameter serviceGroup: The serviceGroup object to update.
     - parameter call back : returns the response message.
     - returns:  Nothing
     */
    func deleteServicePhoto (id : String,completion: (data:String!,responseMessage:ResponseMessage!) -> ())
    /**
     This uploads a service  image
     - parameter service: The service object to create.
     - parameter call back : returns the service and response message.
     - returns:  Nothing
     */
    func addServicePhoto (service : Service,imageData:NSData,completion: (data:Service!, responseMessage:ResponseMessage!) -> ())
    
    /**
     This returns all the service  image
     - parameter serviceId: The serviceId to search.
     - parameter call back : returns array of service images and response message.
     - returns:  Nothing
     */
    func getAllPhotosByServie (serviceId:String,completion: (data:Array<ServiceImage>!, responseMessage:ResponseMessage!) -> ())
    
    
}
