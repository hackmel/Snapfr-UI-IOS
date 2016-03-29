//
//  AddServiceGroupController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 20/9/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import Foundation

import UIKit

class AddServiceGroupController: UITableViewController {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var nameText: UITextField!
   
    @IBOutlet weak var summaryText: UITextField!
    
    var serviceGroupData = ServiceGroup()
    
    
    var serviceGroupServices = ServiceGroupServices(newServiceDao: ServiceDao(), newServiceGroupDao: ServiceGroupDao(), newServiceImageDao: ServiceImageDao())
    
    
    @IBAction func doneButtonOnClick(sender: AnyObject) {
        
         let serviceGroup = ServiceGroup()
        
        
        
        
        let trimmedName = self.nameText.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let trimmedSummary = self.summaryText.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if(trimmedSummary.isEmpty || trimmedName.isEmpty ) {
            let alertView = UIAlertView(title: "Validation", message: "Name or summary can't contain blank", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
            
            return
            
        }

        
        serviceGroup.name = nameText.text
        serviceGroup.summary =  summaryText.text
        serviceGroup.profile.id = Constants.ProfileID
        
        
        
         serviceGroupServices.createServiceGroup(serviceGroup, completion: { (data, responseMessage) -> () in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                CommonUtil.processErrorUIResponseMsg("Add Service Category", responseMessage: responseMessage)
                
                if responseMessage.code == ResponseStatus.Success {
                    if data != nil {
                        self.serviceGroupData = data
                        
                        let alertView = UIAlertController(title: "Successful", message: "Service category successfully created", preferredStyle: UIAlertControllerStyle.Alert)
                         alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                           self.performSegueWithIdentifier("showServiceGroupMaintenanceSegue", sender: nil)
                        }));

                        self.presentViewController(alertView, animated: true, completion: nil)
                    }
                }
                
                
                
                
                
            }
            
            
            
            
         })
        
       

        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showServiceGroupMaintenanceSegue" {
            let maintainServiceGroupController = segue.destinationViewController as! MaintainServiceGroupController
            maintainServiceGroupController.serviceGroup = self.serviceGroupData
          
        }
        
        
    }
}
