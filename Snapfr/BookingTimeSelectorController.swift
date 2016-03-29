//
//  BookingTimeSelectorController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 26/10/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class BookingTimeSelectorController : UITableViewController {
    
    
 
    var unWindsegueVal = String()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func bookingTimeOnClick(sender: AnyObject) {
        
        performSegueWithIdentifier(unWindsegueVal, sender: nil)
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwindBookServiceSegue" {
            
            let bookingServiceController = segue.destinationViewController as! BookServiceController
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = "hh:mm a"
       
            bookingServiceController.bookingTimeLabel.text =   formatter.stringFromDate(datePicker.date)
        }else if segue.identifier == "unwindModifyBooking" {
            
            let modifyBookingController = segue.destinationViewController as! ModifyBookingController
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = "hh:mm a"
            
            modifyBookingController.BookingTime.text =   formatter.stringFromDate(datePicker.date)
        }

    }

    
    
    
}
