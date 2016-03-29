//
//  AddServiceImageController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 3/10/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import Foundation
import UIKit

class AddServiceImageController : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    var serviceData = Service()
    var sourceWindow = ""
    
    @IBOutlet weak var sampleImageView: UIImageView!
    override func viewDidLoad() {
        self.imagePicker.delegate = self
        
       
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            sampleImageView.contentMode = .ScaleAspectFit
            sampleImageView.image = pickedImage
            
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }


    @IBAction func imagePickerButtonOnClick(sender: AnyObject) {
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)

    }
    
    @IBAction func addImageButtonOnClick(sender: AnyObject) {
        
        let service = ServiceGroupServices(newServiceDao: ServiceDao(), newServiceGroupDao: ServiceGroupDao(), newServiceImageDao: ServiceImageDao())
        
        
        
            
            let imgData : NSData = UIImagePNGRepresentation(self.sampleImageView.image!)!
            
            service.addServicePhoto(serviceData, imageData: imgData, completion: { (data, responseMessage) -> () in
             
                CommonUtil.processErrorUIResponseMsg("Add Image", responseMessage: responseMessage)
                
                if responseMessage.code == ResponseStatus.Success{
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        let alertView = UIAlertController(title: "Successful", message: "Image successfully updloaded", preferredStyle: UIAlertControllerStyle.Alert)
                        alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                            if self.sourceWindow == "editService" {
                                self.performSegueWithIdentifier("unwindSegueReloadEditServiceController", sender: nil)
                            }else if self.sourceWindow == "addService" {
                                self.performSegueWithIdentifier("unwindSegueReloadMaintainServiceGroupController", sender: nil)
                            }

                            
                        }));
                        
                        
                        self.presentViewController(alertView, animated: true, completion: nil)
                        
                       
                    }
                    
                }
            })
        
        
    }
    
    
    @IBAction func closeOnClick(sender: AnyObject)
    {
        
        if self.sourceWindow == "editService" {
            self.performSegueWithIdentifier("unwindSegueReloadEditServiceController", sender: nil)
        }else if self.sourceWindow == "addService" {
            self.performSegueWithIdentifier("unwindSegueReloadMaintainServiceGroupController", sender: nil)
        }
        
        
    }
    
    
}

