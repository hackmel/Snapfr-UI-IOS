//
//  ServicesController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 20/9/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import Foundation
import UIKit

class ServicesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var serviceGroupList = [ServiceGroup]()
    var serviceGroup = ServiceGroup()
    
    
    
    override func viewDidLoad() {
     print("Loaded")
        
          let serviceGroupService = ServiceGroupServices(newServiceDao: ServiceDao(), newServiceGroupDao: ServiceGroupDao(), newServiceImageDao: ServiceImageDao())
        
          serviceGroupService.getAllServiceGroup(Constants.ProfileID, completion: { (data, responseMessage) -> () in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                CommonUtil.processErrorUIResponseMsg("Profile Maintenance",responseMessage: responseMessage);
                
                if responseMessage.code == ResponseStatus.Success {
                    if (data != nil ) {
                        self.serviceGroupList = data
                        self.tableView.reloadData()
                    }
                }
                
            }
           })
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let serviceGroupService = ServiceGroupServices(newServiceDao: ServiceDao(), newServiceGroupDao: ServiceGroupDao(), newServiceImageDao: ServiceImageDao())
       
        
        serviceGroupService.getAllServiceGroup(Constants.ProfileID, completion: { (data, responseMessage) -> () in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                CommonUtil.processErrorUIResponseMsg("Profile Maintenance",responseMessage: responseMessage);
                
                if responseMessage.code == ResponseStatus.Success {
                    if (data != nil ) {
                        self.serviceGroupList = data
                        self.tableView.reloadData()
                    }
                }
                
            }
         })

    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let searchCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 
        let serviceGroup = self.serviceGroupList[indexPath.row]
        searchCell.textLabel?.text = serviceGroup.name
        
        return searchCell;

    }
    
    

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        serviceGroup = self.serviceGroupList[indexPath.row]
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MaintainServiceGroupController") as! MaintainServiceGroupController
        controller.serviceGroup.id = serviceGroup.id
        controller.serviceGroup.name = serviceGroup.name
        controller.serviceGroup.summary = serviceGroup.summary
        Constants.ServiceGroupId = serviceGroup.id

        self.navigationController!.pushViewController(controller, animated: true)
        
        
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return serviceGroupList.count ;
    }
    
    
    

    
      
}


