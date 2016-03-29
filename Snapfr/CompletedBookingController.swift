//
//  CompletedBookingController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 15/11/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class CompletedBookingController : UIViewController {
    
    var selectedBooking = Booking()
    var isCustomer : Bool = false
    
    @IBOutlet weak var bookingDateText: UILabel!
    @IBOutlet weak var serviceNameText: UILabel!
    
    
    @IBOutlet weak var photographerNameText: UILabel!
    
    
    @IBOutlet weak var customerNameText: UILabel!
    
    @IBOutlet weak var remarksText: UITextView!
    
    
    override func viewDidLoad() {
        
        
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        
        serviceNameText.text = selectedBooking.service.name
        remarksText.text = selectedBooking.remarks
        bookingDateText.text = formatter.stringFromDate(selectedBooking.bookingDate)
        
        customerNameText.text = selectedBooking.customer.name
        photographerNameText.text = selectedBooking.photographer.name
        
        
    }

    
    @IBAction func makeReviewOnClick(sender: AnyObject) {
        
        performSegueWithIdentifier("makeReviewSegue", sender: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "makeReviewSegue" {
            let makeReviewController = segue.destinationViewController as! MakeReviewController
            
            makeReviewController.selectedBooking = selectedBooking
            makeReviewController.isCustomer = isCustomer
        }
    }
}
