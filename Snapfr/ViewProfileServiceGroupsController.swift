//
//  ViewProfileServiceGroups.swift
//  Snapfr
//
//  Created by Rommel Suarez on 18/10/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class ViewProfileServiceGroupsController: UITableViewController {
    
    
    var serviceGroupList = Array<ServiceGroup>()
    var serviceGroup = ServiceGroup()
    
    override func viewDidAppear(animated: Bool) {
        let serviceGroupService = ServiceGroupServices(newServiceDao: ServiceDao(), newServiceGroupDao: ServiceGroupDao(), newServiceImageDao: ServiceImageDao())
        
        let parent = self.parentViewController as! ViewProfileController
        
        serviceGroupService.getAllServiceGroup(parent.profile.id, completion: { (data, responseMessage) -> () in
            dispatch_async(dispatch_get_main_queue()) {
                
                CommonUtil.processErrorUIResponseMsg("View Service Categories",responseMessage: responseMessage);
                
                if responseMessage.code == ResponseStatus.Success  {
                   
                    if data != nil {
                            self.serviceGroupList = data
                            self.tableView.reloadData()

                    }
                    
                }
            }
        })
   }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceGroupList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let serviceGroup = self.serviceGroupList[indexPath.row]
        
        
        cell.textLabel?.text = serviceGroup.name
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        serviceGroup = self.serviceGroupList[indexPath.row]
        performSegueWithIdentifier("showServices", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showServices" {
            
            let viewServicesController = segue.destinationViewController as! ViewServicesController
            
            viewServicesController.serviceGroup = serviceGroup
        }
    }

    
}
