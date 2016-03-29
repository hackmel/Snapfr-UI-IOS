//
//  DeleteServiceSamplePhotoController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 10/10/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation
import UIKit

class DeleteServiceSamplePhotoController : UITableViewController {
    
    var serviceImage = ServiceImage()
    
    
    @IBOutlet weak var samplePhoto: UIImageView!
    
    @IBAction func deletePhotoButtonOnClick(sender: AnyObject) {
        
        let service = ServiceGroupServices(newServiceDao: ServiceDao(), newServiceGroupDao: ServiceGroupDao(), newServiceImageDao: ServiceImageDao())
        
        
        
        let refreshAlert = UIAlertController(title: "Delete Photo", message: "Are you sure you want to continue? ", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
           
            service.deleteServicePhoto(self.serviceImage.id) { (data, responseMessage) -> () in
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if data != nil {
                       
                            let alertView = UIAlertController(title: "Successful", message: "Photo successfully deleted", preferredStyle: UIAlertControllerStyle.Alert)
                            alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                                self.performSegueWithIdentifier("unwindSegue", sender: self)
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
    
    
    override func viewDidLoad() {
        
        samplePhoto.imageFromUrl(serviceImage.serviceImage)
        
    }
    
    
}
