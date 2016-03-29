//
//  RejectBookingRequestController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 10/11/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class RejectBookingRequestController : UIViewController {
    
    var selectedBooking = Booking()
    let bookingService = BookingService(newBookingDao: BookingDao())
    
    @IBOutlet weak var rejectReason: UITextView!
    
    
    @IBAction func rejectOnClick(sender: AnyObject) {
        
        
        selectedBooking.rejectReason = rejectReason.text
        selectedBooking.status = BookingStatus.Rejected
        
        
        let trimmedRejectReason = self.rejectReason.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if trimmedRejectReason == "" {
            
            let alertView = UIAlertView(title: "Booking reject failed", message: "Please enter reason", delegate: nil, cancelButtonTitle: "OK")
            
            alertView.show()
            

            
        }else {
            
            
            
            let refreshAlert = UIAlertController(title: "Booking rejection", message: "Are You Sure to Reject ? ", preferredStyle: UIAlertControllerStyle.Alert)
            
            
            refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
                
                self.bookingService.updateBooking(self.selectedBooking) { (data, responseMessage) -> () in
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        CommonUtil.processErrorUIResponseMsg("Booking rejection", responseMessage: responseMessage)
                        
                        if responseMessage.code == ResponseStatus.Success {
                            let alertView = UIAlertController(title: "Successful", message: "Booking successfully rejected", preferredStyle: UIAlertControllerStyle.Alert)
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
        
    }
}