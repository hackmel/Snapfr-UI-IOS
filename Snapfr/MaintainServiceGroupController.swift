//
//  File.swift
//  Snapfr
//
//  Created by Rommel Suarez on 26/9/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import Foundation
import UIKit

class MaintainServiceGroupController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
   
    @IBOutlet weak var serviceGroupSummaryText: UILabel!
    
    @IBOutlet weak var serviceGroupNameText: UILabel!
    
    @IBOutlet weak var serviceCollections: UICollectionView!
    var serviceGroup = ServiceGroup()
    
    let serviceGroupServices = ServiceGroupServices(newServiceDao: ServiceDao(), newServiceGroupDao: ServiceGroupDao(), newServiceImageDao: ServiceImageDao())
    var serviceList = [Service]()
    var service = Service()
    
    
    override func viewDidLoad() {
        self.serviceGroupSummaryText.text = self.serviceGroup.summary
        self.serviceGroupNameText.text = self.serviceGroup.name
        
        
        serviceGroupServices.getAllServicesByGroup(serviceGroup.id, completion: { (data, responseMessage) -> () in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                CommonUtil.processErrorUIResponseMsg("Maintain service category", responseMessage: responseMessage)
                if responseMessage.code == ResponseStatus.Success {
                    if data != nil {
                        self.serviceList = data
                        self.serviceCollections.reloadData()
                    }
                }
                
            }
           
            
        })
    }
    
    
    
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serviceList.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath)
        let imageView = cell.viewWithTag(1) as! UIImageView
        let serviceName = cell.viewWithTag(2) as! UILabel
        serviceName.text = self.serviceList[indexPath.row].name
       if self.serviceList[indexPath.row].serviceImage.count > 0 {
              imageView.imageFromUrl(self.serviceList[indexPath.row].serviceImage[0].serviceImage )
        }
        
       return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        service = self.serviceList[indexPath.row]
        self.performSegueWithIdentifier("editServiceSegue", sender: nil)
    }
    
    
    @IBAction func deleteServiceGroupButtonOnClick(sender: AnyObject) {
        
        
        let refreshAlert = UIAlertController(title: "Delete Service Group", message: "Are you sure you want to continue? ", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            
            self.serviceGroupServices.deleteServiceGroup(self.serviceGroup.id) { (data, responseMessage) -> () in
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    
                    if data != nil {
                        
                        let alertView = UIAlertController(title: "Successful", message: "Service category successfully deleted", preferredStyle: UIAlertControllerStyle.Alert)
                        alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                           self.performSegueWithIdentifier("unwindSegueReloadProfileMaintenance", sender: self)
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
    
    
    @IBAction func editButtonOnClick(sender: AnyObject) {
        self.performSegueWithIdentifier("editServiceGroupSegue", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "editServiceSegue") {
            let editServiceController = segue.destinationViewController as! EditServiceParentViewController
            editServiceController.serviceData = service
                     
            
        }else if (segue.identifier == "editServiceGroupSegue") {
            let editServiceGroupController = segue.destinationViewController as! EditParentServiceGroupController
            editServiceGroupController.serviceGroup = serviceGroup
          
            
        }else if (segue.identifier == "addServiceControllerSegue") {
            let addServiceGroupController = segue.destinationViewController as! AddServiceController
            addServiceGroupController.serviceDataInfo.serviceGroup = self.serviceGroup
       
            
            
            
        }


        
        
    }
    
    
    @IBAction func closeOnClick(sender: AnyObject) {
        
        self.performSegueWithIdentifier("unwindSegueReloadProfileMaintenance", sender: nil)
    }
    
    
    @IBAction func unwindSegueReloadMaintainServiceGroupController (segue: UIStoryboardSegue)  {
        
        
        
        serviceGroupServices.getServiceGroup(serviceGroup.id) { (data, responseMessage) -> () in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                CommonUtil.processErrorUIResponseMsg("Maintain service category", responseMessage: responseMessage)
                
                if responseMessage.code == ResponseStatus.Success {
                    if data != nil {
                        self.serviceGroupSummaryText.text = data.summary
                        self.serviceGroupNameText.text = data.name
                        
                        self.serviceGroup = data
                        
                        
                        self.serviceGroupServices.getAllServicesByGroup(self.serviceGroup.id, completion: { (data, responseMessage) -> () in
                            
                            dispatch_async(dispatch_get_main_queue()) {
                                
                                CommonUtil.processErrorUIResponseMsg("Maintain service category", responseMessage: responseMessage)
                                if responseMessage.code == ResponseStatus.Success {
                                    if data != nil {
                                        self.serviceList = data
                                        self.serviceCollections.reloadData()

                                    }
                                }
                                
                            }
                            
                            
                        })

                    }
                }
                
            }
        }
        
    }
    
    @IBAction func addServiceOnClick(sender: AnyObject) {
        
     
        
        performSegueWithIdentifier("addServiceControllerSegue", sender: nil)
    }
   }
