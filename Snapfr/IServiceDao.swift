//
//  IServiceDao.swift
//  Snapfr
//
//  Created by Rommel Suarez on 15/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation

protocol IServiceDao {
    
    /**
     This creates a service and returns the created object via callback
     - parameter service: The service object to create.
     - parameter call back : returns the service and response message.
     - returns:  Nothing
     */
    func createService (service : Service,completion: (data:Service!, responseMessage:ResponseMessage!) -> ())
    /**
     This updates a service and returns the updated object via callback
     - parameter service: The service object to update.
     - parameter call back : returns the service and response message.
     - returns:  Nothing
     */
    func updateService (service : Service,completion: (data:Service!, responseMessage:ResponseMessage!) -> ())
    /**
     This deleted a service and returns the message status via callback
     - parameter serviceId: The service id to delete.
     - parameter call back : returns the message and response message.
     - returns:  Nothing
     */
    func deleteService (serviceId : String,completion: (data:String!, responseMessage:ResponseMessage!) -> ())
    
    /**
     This returns all the services within a group from a call back
     - parameter groupId: The groupId id to search.
     - parameter call back : returns the array of services and response message.
     - returns:  Nothing
     */
    func getAllServicesByGroup (groupId:String,completion: (data:Array<Service>!, responseMessage:ResponseMessage!) -> ())
    
    /**
     This a services from a call back 
     - parameter serviceId: The serviceId id to search.
     - parameter call back : returns the service and response message.
     - returns:  Nothing
     */
    func getServiceById (serviceId:String,completion: (data:Service!, responseMessage:ResponseMessage!) -> ())
    

}