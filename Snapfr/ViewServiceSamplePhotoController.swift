//
//  ViewServiceSamplePhotoController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 3/10/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import Foundation
import UIKit

class ViewServiceSamplePhotoController : UITableViewController, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
 
    let serviceData = Service()
    var serviceImageList = [ServiceImage]()
    var serviceImage = ServiceImage()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        let service = ServiceGroupServices(newServiceDao: ServiceDao(), newServiceGroupDao: ServiceGroupDao(), newServiceImageDao: ServiceImageDao())
        
        service.getAllPhotosByServie(serviceData.id, completion: { (data, responseMessage) -> () in
           
            dispatch_async(dispatch_get_main_queue()) {
                
                CommonUtil.processErrorUIResponseMsg("Display all Photos", responseMessage: responseMessage)
                
                if responseMessage.code == ResponseStatus.Success{
                    if data != nil {
                        self.serviceImageList = data
                        
                        self.collectionView!.reloadData()
                    }
                    
                }
              
                
            }

        })
        
       
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serviceImageList.count
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
         print("insetForSectionAtIndex")
        return UIEdgeInsetsMake(1, 2, 1, 10);
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) 
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        imageView.imageFromUrl(serviceImageList[indexPath.row].serviceImage)
        
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        serviceImage=serviceImageList[indexPath.row]
        
        performSegueWithIdentifier("deleteSamplePhotoSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "deleteSamplePhotoSegue" {
            let deletePhoto = segue.destinationViewController as! DeleteServiceSamplePhotoController
            
            
            deletePhoto.serviceImage = serviceImage
        }
        
    }
    
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        
        let service = ServiceGroupServices(newServiceDao: ServiceDao(), newServiceGroupDao: ServiceGroupDao(), newServiceImageDao: ServiceImageDao())
        
        service.getAllPhotosByServie(serviceData.id, completion: { (data, responseMessage) -> () in
            
            dispatch_async(dispatch_get_main_queue()) {
                CommonUtil.processErrorUIResponseMsg("Display all Photos", responseMessage: responseMessage)
            
                if responseMessage.code == ResponseStatus.Success{
                    if data != nil {
                        self.serviceImageList = data
                        self.collectionView!.reloadData()

                    }
                }
                
            }
            
        })

    }

    
    @IBAction func closeOnClick(sender: AnyObject) {
        
        performSegueWithIdentifier("unwindSegueReloadEditServiceController", sender: nil)
    }
}
