//
//  ViewServicesController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 18/10/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class ViewServicesController: UITableViewController, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    var serviceGroup = ServiceGroup()
    let serviceGroupServices = ServiceGroupServices(newServiceDao: ServiceDao(), newServiceGroupDao: ServiceGroupDao(), newServiceImageDao: ServiceImageDao())
    var serviceList = Array<Service>()
    var service = Service()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        
        serviceGroupServices.getAllServicesByGroup(serviceGroup.id, completion: { (data, responseMessage) -> () in
            
            dispatch_async(dispatch_get_main_queue()) {
               CommonUtil.processErrorUIResponseMsg("View Services",responseMessage: responseMessage);
                
               if responseMessage.code == ResponseStatus.Success {
                    
                    if data != nil {
                        self.serviceList = data
                        self.collectionView.reloadData()
                    }

                }
            }
            
            
        })

        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serviceList.count
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        print("insetForSectionAtIndex")
        return UIEdgeInsetsMake(1, 2, 1, 240);
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        print("cell")
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        let labelName = cell.viewWithTag(2) as! UILabel
        
        imageView.imageFromUrl(serviceList[indexPath.row].serviceImage[0].serviceImage)
        labelName.text = serviceList[indexPath.row].name
        
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        service=serviceList[indexPath.row]
        
        performSegueWithIdentifier("bookingSegue", sender: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "bookingSegue" {
            let  bookServiceController = segue.destinationViewController as! BookServiceController
            
            bookServiceController.service = self.service
            
        }
    }

    
    
    
}
