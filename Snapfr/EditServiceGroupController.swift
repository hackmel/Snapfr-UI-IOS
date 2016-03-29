//
//  EditServiceGroupController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 11/10/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class EditServiceGroupController: UIViewController {
   
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var summaryText: UITextView!
    
    var serviceGroupData = ServiceGroup()
    
    override func viewDidAppear(animated: Bool) {
        
        let parent = self.parentViewController as! EditParentServiceGroupController
        
        serviceGroupData = parent.serviceGroup
        
        nameText.text = serviceGroupData.name
        summaryText.text = serviceGroupData.summary
        
    }
    
    @IBAction func saveButtonOnClick(sender: AnyObject) {
        
        let service = ServiceGroupServices(newServiceDao: ServiceDao(), newServiceGroupDao: ServiceGroupDao(), newServiceImageDao: ServiceImageDao())
        
        
        let serviceGroup = ServiceGroup()
        
        
        let trimmedName = self.nameText.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let trimmedSummary = self.summaryText.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if(trimmedSummary.isEmpty || trimmedName.isEmpty ) {
            let alertView = UIAlertView(title: "Validation", message: "Name or summary can't contain blank", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
            
            return
            
        }
        
        serviceGroup.id = self.serviceGroupData.id
        serviceGroup.name = nameText.text
        serviceGroup.summary = summaryText.text
        
        let refreshAlert = UIAlertController(title: "Update Service Group", message: "Are you sure you want to continue ? ", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            
               service.updateServiceGroup(serviceGroup) { (data, responseMessage) -> () in
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    CommonUtil.processErrorUIResponseMsg("Update Service Group", responseMessage: responseMessage)
                    
                    if responseMessage.code == ResponseStatus.Success {
                       let alertView = UIAlertController(title: "Successful", message: "Service category successfully updated", preferredStyle: UIAlertControllerStyle.Alert)
                        alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                             self.performSegueWithIdentifier("unwindSegueReloadMaintainServiceGroupController", sender: self)
                        }));
                        
                        self.presentViewController(alertView, animated: true, completion: nil)
                    }
                    
                }
                
                
            }
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
           refreshAlert .dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(refreshAlert, animated: true, completion: nil)
        

        
    
     
    }
    
    
    @IBAction func closeOnClick(sender: AnyObject) {
       performSegueWithIdentifier("unwindSegueReloadMaintainServiceGroupController", sender: nil)
    }
    
    
}
