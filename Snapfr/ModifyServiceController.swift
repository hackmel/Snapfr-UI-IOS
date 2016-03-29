//
//  ModifyServiceController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 10/10/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class ModifyServiceController: UIViewController {
    
  
    
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var summaryText: UITextView!
    
    
    let formatter = NSNumberFormatter()
    
    
    @IBAction func saveButtonOnClick(sender: AnyObject) {
        
        let parent = self.parentViewController as! ParentModifyServiceController
        let service = ServiceGroupServices(newServiceDao: ServiceDao(), newServiceGroupDao: ServiceGroupDao(), newServiceImageDao: ServiceImageDao())
        let servceData = Service()
        
        
        
        let trimmedName = self.nameText.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let trimmedSummary = self.summaryText.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if(trimmedSummary.isEmpty || trimmedName.isEmpty ) {
            let alertView = UIAlertView(title: "Validation", message: "Name or summary can't contain blank", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
            
            return
            
        }

        
        servceData.id = parent.serviceData.id
        servceData.name = nameText.text
        servceData.price = formatter.numberFromString(priceText.text!)?.floatValue
        servceData.summary = summaryText.text
        
        
        
        
        
        let refreshAlert = UIAlertController(title: "Update Service", message: "Are You Sure to update ? ", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            
            service.updateService(servceData) { (data, responseMessage) -> () in
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    CommonUtil.processErrorUIResponseMsg("Update Service", responseMessage: responseMessage)
                    
                    if responseMessage.code == ResponseStatus.Success {
                        let alertView = UIAlertController(title: "Successful", message: "Service successfully updated", preferredStyle: UIAlertControllerStyle.Alert)
                        alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                            self.performSegueWithIdentifier("unwindSegueReloadEditServiceController", sender: self)
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
    
    
    override func viewDidAppear(animated: Bool) {
        
        let parent = self.parentViewController as! ParentModifyServiceController
        priceText.text = formatter.stringFromNumber(parent.serviceData.price)
        nameText.text = parent.serviceData.name
        summaryText.text = parent.serviceData.summary
        

    }
    
    
    
    @IBAction func closeOnClick(sender: AnyObject) {
        
        performSegueWithIdentifier("unwindSegueReloadEditServiceController", sender: nil)
    }
}
