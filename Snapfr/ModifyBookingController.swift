//
//  ModifyBookingController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 11/11/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class ModifyBookingController: UIViewController {
    
    var selectedBooking = Booking()
    var bookingService = BookingService(newBookingDao: BookingDao())
    
    @IBOutlet weak var serviceName: UILabel!
    
  
    @IBOutlet weak var bookingDate: UILabel!
    
    @IBOutlet weak var BookingTime: UILabel!
    
    @IBOutlet weak var remarks: UITextView!
    
    var unwindToSegue = String()
    
    override func viewDidLoad() {
        serviceName.text = selectedBooking.service.name
        remarks.text = selectedBooking.remarks
        
        let formatter = NSDateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy"
        
        bookingDate.text = formatter.stringFromDate(selectedBooking.bookingDate)
        
        formatter.dateFormat = "hh:mm a"
        BookingTime.text = formatter.stringFromDate(selectedBooking.bookingDate)
    }
    
    
    @IBAction func saveButtonOnClick(sender: AnyObject) {
        
        let bookingDateVal = "\(bookingDate.text!) \(BookingTime.text!)"
        
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "dd-MM-yyyy hh:mm a"
        
        if let  bDate = formatter.dateFromString(bookingDateVal) {
           selectedBooking.bookingDate = bDate
        }
        

       
        selectedBooking.remarks =  remarks.text
        
        
        let refreshAlert = UIAlertController(title: "Booking update", message: "Are You Sure to update ? ", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            
            self.bookingService.updateBooking(self.selectedBooking) { (data, responseMessage) -> () in
                
                dispatch_async(dispatch_get_main_queue()) {
                   
                    CommonUtil.processErrorUIResponseMsg("Booking update", responseMessage: responseMessage)
                    
                    if responseMessage.code == ResponseStatus.Success {
                        let alertView = UIAlertController(title: "Successful", message: "Booking successfully updated", preferredStyle: UIAlertControllerStyle.Alert)
                        alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                             self.performSegueWithIdentifier(self.unwindToSegue, sender: nil)
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
 
    @IBAction func setDateOnClick(sender: AnyObject) {
        performSegueWithIdentifier("showBookingDateSelectSegue", sender: nil)
    }
    
    
    
    @IBAction func setTimeOnClick(sender: AnyObject) {
        performSegueWithIdentifier("showSetBookingTimeSegue", sender: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showBookingDateSelectSegue" {
            let bookingDateSelectionController = segue.destinationViewController as! BookingDateSelectionController
            bookingDateSelectionController.unWindsegueVal = "unwindModifyBooking"
            
        }else if segue.identifier == "showSetBookingTimeSegue" {
            let bookingTimeSelectorController = segue.destinationViewController as! BookingTimeSelectorController
            bookingTimeSelectorController.unWindsegueVal = "unwindModifyBooking"
        }
    }
    
    @IBAction func unwindModifyBooking(segue: UIStoryboardSegue) {
        
    }
    
}
