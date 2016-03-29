//
//  ViewPendingRequest.swift
//  Snapfr
//
//  Created by Rommel Suarez on 10/11/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class ViewPendingCustomerRequestController: UITableViewController {
    
    var selectedBooking = Booking()
    let bookingService = BookingService(newBookingDao: BookingDao())
    
    @IBOutlet weak var service: UILabel!
    
    @IBOutlet weak var bookingDate: UILabel!
    
    
    @IBOutlet weak var remarks: UILabel!
    
    @IBOutlet weak var customerName: UILabel!
    
   
    
    override func viewDidLoad() {
        
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        
       
        service.text = selectedBooking.service.name
        bookingDate.text = formatter.stringFromDate(selectedBooking.bookingDate)
        remarks.text = selectedBooking.remarks
        customerName.text = selectedBooking.customer.name
       
    }
    
    @IBAction func reject(sender: AnyObject) {
        
        performSegueWithIdentifier("rejectRequestSegue", sender: nil)
    }
    
    @IBAction func Accept(sender: AnyObject) {
        selectedBooking.status = BookingStatus.Accepted
        
        
        
        let refreshAlert = UIAlertController(title: "Booking rejection", message: "Are You Sure to Accept ? ", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            
            self.bookingService.updateBooking(self.selectedBooking) { (data, responseMessage) -> () in
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    CommonUtil.processErrorUIResponseMsg("Booking update", responseMessage: responseMessage)
                    
                    if responseMessage.code == ResponseStatus.Success {
                       let alertView = UIAlertController(title: "Successful", message: "Booking successfully updated", preferredStyle: UIAlertControllerStyle.Alert)
                        alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                            self.performSegueWithIdentifier("unwindSeguePendingBookingRequestList", sender: nil)
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "rejectRequestSegue"{
        
           let rejectBookingRequestController = segue.destinationViewController as! RejectBookingRequestController
            
            rejectBookingRequestController.selectedBooking = selectedBooking
        
        }else if segue.identifier == "modifyBookingSegue"{
            
            let modifyBookingController = segue.destinationViewController as! ModifyBookingController
            
            modifyBookingController.selectedBooking = selectedBooking
            modifyBookingController.unwindToSegue = "unwindSeguePendingBookingRequestList"
            
        }
        
        
    }
    
    
    @IBAction func unwindSegueViewPendingRequest(segue: UIStoryboardSegue) {
        
    }
    
    
    
    @IBAction func modifyOnClick(sender: AnyObject) {
        
        performSegueWithIdentifier("modifyBookingSegue", sender: nil)
    }
    
    
    
}
