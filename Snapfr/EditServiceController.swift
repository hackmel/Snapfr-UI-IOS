//
//  EditServiceController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 3/10/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import Foundation
import UIKit


class EditServiceController : UIViewController {
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var summaryText: UITextView!
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var priceText: UITextField!
    
    var serviceData = Service()
    
    let formatter = NSNumberFormatter()
    
    override func viewDidLoad() {
        
        
      
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        formatter.numberStyle = .DecimalStyle
        formatter.locale = NSLocale.currentLocale()
        

        let parent = self.parentViewController as! EditServiceParentViewController
        self.nameText.text = parent.serviceData.name
        self.summaryText.text = parent.serviceData.summary
        self.priceText.text =  formatter.stringFromNumber(parent.serviceData.price)
        
        
        serviceData.id = parent.serviceData.id
        serviceData.name = parent.serviceData.name
        serviceData.price = parent.serviceData.price
        serviceData.summary = parent.serviceData.summary

    }
    
    
    @IBAction func deleteButtonOnClick(sender: AnyObject) {
        
        
        
        let service = ServiceGroupServices (newServiceDao: ServiceDao(), newServiceGroupDao: ServiceGroupDao(), newServiceImageDao: ServiceImageDao())
        
        
        let refreshAlert = UIAlertController(title: "Delete Service", message: "Are you sure you want to continue? ", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            
            service.deleteService(self.serviceData.id) { (data, responseMessage) -> () in
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    
                    
                    if data != nil {
                        let alertView = UIAlertController(title: "Successful", message: "Service successfully deleted", preferredStyle: UIAlertControllerStyle.Alert)
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
    
    
    @IBAction func modifyButtonOnClick(sender: AnyObject) {
        performSegueWithIdentifier("modifyServiceSegue", sender: self)
    }
    
    
    @IBAction func viewSamplePhotoButtonOnClick(sender: AnyObject) {
        self.performSegueWithIdentifier( "showSamplePhotosSegue", sender: self)
    }
    
    @IBAction func addNewPhotoButtonOnClick(sender: AnyObject) {
        
        self.performSegueWithIdentifier( "addServiceImageSegue", sender: self)
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "addServiceImageSegue") {
            let addServiceImageController = segue.destinationViewController as! AddServiceImageController
            addServiceImageController.serviceData.id = serviceData.id
            addServiceImageController.sourceWindow = "editService"
            
            
        }else if (segue.identifier == "showSamplePhotosSegue") {
            let viewServiceSamplePhotoController = segue.destinationViewController as! ViewServiceSamplePhotoController
            viewServiceSamplePhotoController.serviceData.id = serviceData.id
        }else if (segue.identifier == "modifyServiceSegue") {
            let modifyServiceController = segue.destinationViewController as! ParentModifyServiceController
            modifyServiceController.serviceData = serviceData
           
            
        }


    }
    
    
    @IBAction func unwindSegueReloadEditServiceController (segue: UIStoryboardSegue){
        let service = ServiceGroupServices (newServiceDao: ServiceDao(), newServiceGroupDao: ServiceGroupDao(), newServiceImageDao: ServiceImageDao())
        
        
        service.getService(serviceData.id) { (data, responseMessage) -> () in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                CommonUtil.processErrorUIResponseMsg("Update Service", responseMessage: responseMessage)
                
                if responseMessage.code == ResponseStatus.Success {
                    if data != nil {
                        
                        self.formatter.numberStyle = .DecimalStyle
                        self.formatter.locale = NSLocale.currentLocale()

                        self.nameText.text = data.name
                        self.summaryText.text = data.summary
                        self.priceText.text =  self.formatter.stringFromNumber(data.price)
                        
                        self.serviceData = data
                        
                        let parent = self.parentViewController as! EditServiceParentViewController
                        
                        parent.serviceData = data

                    }
                }
                
                
            }
            
           
            
        }
        

        
    }
    
    
    @IBAction func closeOnClick(sender: AnyObject) {
        performSegueWithIdentifier("unwindSegueReloadMaintainServiceGroupController", sender: nil)
    }
        
}
