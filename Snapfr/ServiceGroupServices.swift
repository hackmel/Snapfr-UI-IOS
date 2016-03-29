//
//  ServiceGroupServices.swift
//  Snapfr
//
//  Created by Rommel Suarez on 20/9/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import Foundation

/**
 This class implements the service layer of ServiceGroup, 
 Service and Service Image object
 */
class ServiceGroupServices {
    
    
    var serviceDao : IServiceDao
    var serviceGroupDao : IServiceGroupDao
    var serviceImageDao : IServiceImageDao
    
    
    init(newServiceDao:IServiceDao, newServiceGroupDao:IServiceGroupDao, newServiceImageDao: IServiceImageDao){
        self.serviceDao = newServiceDao
        self.serviceGroupDao = newServiceGroupDao
        self.serviceImageDao = newServiceImageDao
        
    }

   
    
    /**
     This creates service group and return the created object from a call back
     - parameter serviceGroup: The serviceGroup object to create.
     - parameter call back : returns the service group and response message.
     - returns:  Nothing
     */
    func createServiceGroup (serviceGroup : ServiceGroup,completion: (data:ServiceGroup!, responseMessage:ResponseMessage!) -> ()) {
        serviceGroupDao.createServiceGroup(serviceGroup) { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
            
        }
        
    }
    
    
    /**
     This updates service group and return the updated object from a call back
     - parameter serviceGroup: The serviceGroup object to update.
     - parameter call back : returns the service group and response message.
     - returns:  Nothing
     */
    func updateServiceGroup (serviceGroup : ServiceGroup,completion: (data:ServiceGroup!, responseMessage:ResponseMessage!) -> ()) {
        
        serviceGroupDao.updateServiceGroup(serviceGroup) { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
            
        }
        
    }
    
    /**
     This delete a service group
     - parameter serviceId: The serviceId  to delete.
     - parameter call back : returns response message.
     - returns:  Nothing
     */
    
    func deleteServiceGroup (serviceId : String,completion: (data:String!, responseMessage:ResponseMessage!) -> ()) {
        
        serviceGroupDao.deleteServiceGroup(serviceId) { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
            
        }
    }
    

    /**
     This returns all service group
     - parameter profileId: The profileId  to search.
     - parameter call back : returns the array of service group and response message.
     - returns:  Nothing
     */

    
    func getAllServiceGroup (profileId:String,completion: (data:[ServiceGroup]!, responseMessage:ResponseMessage!) -> ()) {

        serviceGroupDao.getAllServiceGroup(profileId) { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
        }
        
    }
    
    /**
     This returns a service group
     - parameter serviceGroupId: The serviceGroupId  to search.
     - parameter call back : returns the service group and response message.
     - returns:  Nothing
     */
    func getServiceGroup (serviceGroupId : String,completion: (data:ServiceGroup!, responseMessage:ResponseMessage!) -> ()){
        
        serviceGroupDao.getServiceGroup(serviceGroupId) { (data, responseMessage) -> () in
             completion (data:data, responseMessage:responseMessage);
        }
        
    }
    
    /**
     This returns all the services within a group from a call back
     - parameter groupId: The groupId id to search.
     - parameter call back : returns the array of services and response message.
     - returns:  Nothing
     */
    func getAllServicesByGroup (groupId:String,completion: (data:Array<Service>!, responseMessage:ResponseMessage!) -> ()) {
        serviceDao.getAllServicesByGroup(groupId) { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
        }

        
        
    }

    
    /**
     This creates a service and returns the created object via callback
     - parameter service: The service object to create.
     - parameter call back : returns the service and response message.
     - returns:  Nothing
     */
    
    func createService (service : Service,completion: (data:Service!, responseMessage:ResponseMessage!) -> ()) {
        serviceDao.createService(service) { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
        }
        
        
        
    }
    
    
    
    /**
     This updates a service and returns the updated object via callback
     - parameter service: The service object to update.
     - parameter call back : returns the service and response message.
     - returns:  Nothing
     */
    
    func updateService (service : Service,completion: (data:Service!, responseMessage:ResponseMessage!) -> ()) {
        
        serviceDao.updateService(service) { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
        }
        
        
        
    }
    
    /**
     This a services from a call back
     - parameter serviceId: The serviceId id to search.
     - parameter call back : returns the service and response message.
     - returns:  Nothing
     */
    func getService (serviceId : String,completion: (data:Service!, responseMessage:ResponseMessage!) -> ()) {
        
        serviceDao.getServiceById(serviceId) { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
        }
        
        
    }
    
    /**
     This deleted a service and returns the message status via callback
     - parameter serviceId: The service id to delete.
     - parameter call back : returns the message and response message.
     - returns:  Nothing
     */
    
    func deleteService (serviceId : String,completion: (data:String!, responseMessage:ResponseMessage!) -> ()) {
        
        serviceDao.deleteService(serviceId) { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
        }
        
        
    }
    
    

    /**
     This returns all the service  image
     - parameter serviceId: The serviceId to search.
     - parameter call back : returns array of service images and response message.
     - returns:  Nothing
     */
    func getAllPhotosByServie (serviceId:String,completion: (data:Array<ServiceImage>!, responseMessage:ResponseMessage!) -> ()) {
        serviceImageDao.getAllPhotosByServie(serviceId) { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
        }

        
    }
    
    
    
    /**
     This deletes service uploaded image
     - parameter serviceGroup: The serviceGroup object to update.
     - parameter call back : returns the response message.
     - returns:  Nothing
     */
    func deleteServicePhoto (id : String,completion: (data:String!, responseMessage:ResponseMessage!) -> ()) {
        
        serviceImageDao.deleteServicePhoto(id) { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
        }
        
        
    }
    
    
    /**
     This uploads a service  image
     - parameter service: The service object to create.
     - parameter call back : returns the service and response message.
     - returns:  Nothing
     */
    
    func addServicePhoto (service : Service,imageData:NSData,completion: (data:Service!, responseMessage:ResponseMessage!) -> ()) {
        
        serviceImageDao.addServicePhoto(service, imageData: imageData) { (data, responseMessage) -> () in
            completion (data:data, responseMessage:responseMessage);
        }
        
    }

    

    
    
    
}
