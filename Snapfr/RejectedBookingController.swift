//
//  RejectedBookingController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 15/11/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class RejectedBookingController: UIViewController {
    
    
    var selectedBooking = Booking()
    
    
    @IBOutlet weak var bookingDateText: UILabel!
    @IBOutlet weak var serviceNameText: UILabel!
    
    
    @IBOutlet weak var photographerNameText: UILabel!
    
    
    @IBOutlet weak var customerNameText: UILabel!
    
    @IBOutlet weak var reasonText: UITextView!
    
    
    override func viewDidLoad() {
        
        
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        
        serviceNameText.text = selectedBooking.service.name
        reasonText.text = selectedBooking.rejectReason
        bookingDateText.text = formatter.stringFromDate(selectedBooking.bookingDate)
        
        customerNameText.text = selectedBooking.customer.name
        photographerNameText.text = selectedBooking.photographer.name
        
        
    }

}
