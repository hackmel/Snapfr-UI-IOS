//
//  IServiceGroupDao.swift
//  Snapfr
//
//  Created by Rommel Suarez on 15/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation

protocol IServiceGroupDao {
    
    /**
     This updates service group and return the updated object from a call back 
     - parameter serviceGroup: The serviceGroup object to update.
     - parameter call back : returns the service group and response message.
     - returns:  Nothing
     */
    func updateServiceGroup (serviceGroup : ServiceGroup,completion: (data:ServiceGroup!, responseMessage:ResponseMessage!) -> ())
    /**
     This creates service group and return the created object from a call back 
     - parameter serviceGroup: The serviceGroup object to create.
     - parameter call back : returns the service group and response message.
     - returns:  Nothing
     */
    func createServiceGroup (serviceGroup : ServiceGroup,completion: (data:ServiceGroup!, responseMessage:ResponseMessage!) -> ())
    
    /**
     This delete a service group 
     - parameter serviceId: The serviceId  to delete.
     - parameter call back : returns response message.
     - returns:  Nothing
     */
    func deleteServiceGroup (serviceGroupId : String,completion: (data:String!, responseMessage:ResponseMessage!) -> ())
    /**
     This returns all service group 
     - parameter profileId: The profileId  to search.
     - parameter call back : returns the array of service group and response message.
     - returns:  Nothing
     */
    func getAllServiceGroup (profileId:String,completion: (data:Array<ServiceGroup>!, responseMessage:ResponseMessage!) -> ())
    
    /**
     This returns a service group
     - parameter serviceGroupId: The serviceGroupId  to search.
     - parameter call back : returns the service group and response message.
     - returns:  Nothing
     */
    func getServiceGroup (serviceGroupId : String,completion: (data:ServiceGroup!, responseMessage:ResponseMessage!) -> ())
   
    
}
