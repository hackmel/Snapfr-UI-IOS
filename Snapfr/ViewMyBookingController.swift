//
//  ViewMyBookingController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 14/11/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class ViewMyBookingController: UIViewController {
    var selectedBooking = Booking()
    let bookingService = BookingService(newBookingDao: BookingDao())
    
    @IBOutlet weak var serviceNameText: UILabel!
    
    @IBOutlet weak var remarksText: UITextView!
    
    @IBOutlet weak var bookingDateText: UILabel!
    @IBOutlet weak var photographerNameText: UILabel!
    
    
    override func viewDidLoad() {
        
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        
        serviceNameText.text = selectedBooking.service.name
        
        remarksText.text = selectedBooking.remarks
        
        photographerNameText.text = selectedBooking.photographer.name
        
        
        bookingDateText.text = formatter.stringFromDate(selectedBooking.bookingDate)
        
        
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
        }
    }

}
