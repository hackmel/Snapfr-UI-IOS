//
//  BookServiceController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 23/10/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class BookServiceController: UITableViewController, DSLCalendarViewDelegate {
    
    var service = Service()
    
    @IBOutlet weak var nameText: UILabel!

    @IBOutlet weak var bookingTimeLabel: UILabel!

    @IBOutlet weak var bookingDateLabel: UILabel!
    
    
    @IBOutlet weak var remarksText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameText.text = service.name
    }
    
    
    
    @IBAction func sendBookingOnClick(sender: AnyObject) {
        let bookingService = BookingService(newBookingDao: BookingDao())
        
        let booking = Booking()
        let bookingDate = "\(bookingDateLabel.text!) \(bookingTimeLabel.text!)"
        
        print(bookingDate)
        
        
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "dd-MM-yyyy hh:mm a"
        
       
        booking.photographer.id = service.serviceGroup.profile.id
        booking.customer.id = Constants.ProfileID
        
        if let  bDate = formatter.dateFromString(bookingDate) {
            
              print(bDate)
            
             booking.bookingDate = bDate
        }
        
       
        booking.remarks = self.remarksText.text
        booking.service = service
        booking.status = BookingStatus.Pending
        booking.cancelReason = ""
        booking.rejectReason = ""
      
        
        bookingService.createBooking(booking) { (data, responseMessage) -> () in
            
                dispatch_async(dispatch_get_main_queue()) {
                    
                    CommonUtil.processErrorUIResponseMsg("Booking", responseMessage: responseMessage)
                    
                    if responseMessage.code == ResponseStatus.Success {
                        
                        let alertView = UIAlertController(title: "Successful", message: "Booking successfully created", preferredStyle: UIAlertControllerStyle.Alert)
                        alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                            //self.performSegueWithIdentifier("unwindSegueReloadMaintainServiceGroupController", sender: self)
                        }));
                        
                        self.presentViewController(alertView, animated: true, completion: nil)

                    }
                    
                    
                    
                    
                }
        }
        
    }
    
    
    
    @IBAction func bookingTimeOnClick(sender: AnyObject) {
         performSegueWithIdentifier("showSetBookingTimeSegue", sender: nil)
    }
    
    @IBAction func bookingDateOnClick(sender: AnyObject) {
        
        performSegueWithIdentifier("showBookingDateSelectSegue", sender: nil)
    }
  
   @IBAction func unwindBookServiceSegue(segue: UIStoryboardSegue) {
      //nameText.text = service.name

    
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showBookingDateSelectSegue" {
            
            let bookingDateSelectionController = segue.destinationViewController as! BookingDateSelectionController
             bookingDateSelectionController.unWindsegueVal = "unwindBookServiceSegue"
            
            bookingDateSelectionController.service = service
        } else if segue.identifier == "showSetBookingTimeSegue" {
            let bookingTimeSelectionController = segue.destinationViewController as! BookingTimeSelectorController
             bookingTimeSelectionController.unWindsegueVal = "unwindBookServiceSegue"

        }
    }
    
    
}
