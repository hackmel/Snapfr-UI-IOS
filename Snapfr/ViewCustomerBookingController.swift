//
//  ViewCustomerBookingController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 14/11/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class ViewCustomerBookingController : UIViewController {
    var selectedBooking = Booking()
    let bookingService = BookingService(newBookingDao: BookingDao())
    
    
    
    @IBOutlet weak var serviceNameText: UILabel!
    
    
    @IBOutlet weak var remarksText: UITextView!
    @IBOutlet weak var customerNameText: UILabel!
    @IBOutlet weak var bookingDateText: UILabel!
    
    
    override func viewDidLoad() {
        
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        
        serviceNameText.text = selectedBooking.service.name
        remarksText.text = selectedBooking.remarks
        bookingDateText.text = formatter.stringFromDate(selectedBooking.bookingDate)

        customerNameText.text = selectedBooking.customer.name
    
    }
    
    
    @IBAction func modifyOnClick(sender: AnyObject) {
        performSegueWithIdentifier("modifyBookingSegue", sender: nil)

    }
    
    
    @IBAction func completeOnClick(sender: AnyObject) {
      

        selectedBooking.status = BookingStatus.Completed
        
        let refreshAlert = UIAlertController(title: "Booking Completed", message: "Are you sure you want to complete? ", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            
            self.bookingService.updateBooking(self.selectedBooking) { (data, responseMessage) -> () in
                
                dispatch_async(dispatch_get_main_queue()) {
                    CommonUtil.processErrorUIResponseMsg("Complete Booking", responseMessage: responseMessage)
                    
                    if responseMessage.code == ResponseStatus.Success {
                        let alertView = UIAlertController(title: "Successful", message: "Service successfully completed", preferredStyle: UIAlertControllerStyle.Alert)
                        alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                             self.performSegueWithIdentifier("unwindSegueBookingList", sender: nil)
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
    
    
    @IBAction func cancelOnClick(sender: AnyObject) {
         performSegueWithIdentifier("cancelBookingSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "cancelBookingSegue" {
            
            let cancelBookingController = segue.destinationViewController as! CancelBookingController
             cancelBookingController.unwindToSegue = "unwindSegueBookingList"
            cancelBookingController.cancelledValue = BookingStatus.CancelledBooking
            
            cancelBookingController.selectedBooking =  selectedBooking
        }else if segue.identifier == "modifyBookingSegue" {
            
            let modifyBookingController = segue.destinationViewController as! ModifyBookingController
            
            modifyBookingController.selectedBooking =  selectedBooking
            modifyBookingController.unwindToSegue = "unwindSegueBookingList"
        }
    }

    
    
}
