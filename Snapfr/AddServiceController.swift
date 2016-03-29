//
//  AddServiceController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 26/9/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import Foundation
import UIKit


class AddServiceController: UITableViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var summaryText: UITextField!
    @IBOutlet weak var importImageButton: UIButton!
    
  
    
    @IBOutlet weak var button: UIButton!
    
    
    var serviceDataInfo = Service()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        self.imagePicker.delegate = self
      
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
   
    
    
    @IBAction func saveOnClick(sender: AnyObject) {
        
        let serviceGroupService = ServiceGroupServices(newServiceDao: ServiceDao(), newServiceGroupDao: ServiceGroupDao(), newServiceImageDao: ServiceImageDao())
        let service = Service()
        
        
        
        let trimmedName = self.nameText.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let trimmedSummary = self.summaryText.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let price = NSNumberFormatter().numberFromString(self.priceText.text!)?.floatValue
        
        if(trimmedSummary.isEmpty || trimmedName.isEmpty ) {
            let alertView = UIAlertView(title: "Validation", message: "Name or summary can't contain blank", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
            
            return
            
        }
        
        if price == nil {
            let alertView = UIAlertView(title: "Validation", message: "Please enter a valid price", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
            
            return
            
        }
        
        
        service.name = self.nameText.text
        service.summary = self.summaryText.text
        service.price =  NSNumberFormatter().numberFromString(self.priceText.text!)?.floatValue
        service.serviceGroup.id = serviceDataInfo.serviceGroup.id
        
        
        
        serviceGroupService.createService(service,completion: { (data, responseMessage) -> () in
            if data != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    
                    CommonUtil.processErrorUIResponseMsg("Add service photo", responseMessage: responseMessage)
                    if responseMessage.code == ResponseStatus.Success {
                        if data != nil {
                            self.serviceDataInfo = data
                            
                            let alertView = UIAlertController(title: "Successful", message: "Service successfully created", preferredStyle: UIAlertControllerStyle.Alert)
                            alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                                self.performSegueWithIdentifier("addServiceImageSegue", sender: self)
                            }));
                            self.presentViewController(alertView, animated: true, completion: nil)
                        }
                    }
                    
                }
                
            }
        })

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addServiceImageSegue" {
            
            let addServiceImageController = segue.destinationViewController as! AddServiceImageController
            addServiceImageController.serviceData = self.serviceDataInfo
            addServiceImageController.sourceWindow = "addService"
        }
    }
    
    @IBAction func closeOnClick(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindSegueReloadMaintainServiceGroupController", sender: self)
     
    }
}