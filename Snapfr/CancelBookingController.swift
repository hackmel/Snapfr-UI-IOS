//
//  CancelBookingController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 14/11/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class CancelBookingController: UIViewController {
    
     var selectedBooking = Booking()
     let bookingService = BookingService(newBookingDao: BookingDao())
     var unwindToSegue = String()
     var cancelledValue = BookingStatus.CancelledRequest
    
    
    @IBOutlet weak var reasonText: UITextView!
    
    @IBAction func cancelOnClick(sender: AnyObject) {
        
        
        selectedBooking.cancelReason = reasonText.text
        selectedBooking.status = cancelledValue
        
        
        
        let trimmedRejectReason = self.reasonText.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if trimmedRejectReason == "" {
            
            let alertView = UIAlertView(title: "Booking cancellation failed", message: "Please enter reason", delegate: nil, cancelButtonTitle: "OK")
            
            alertView.show()
            
            
            
        }else {
            
            
            
            let refreshAlert = UIAlertController(title: "Booking cancellation", message: "Are You Sure to cancel ? ", preferredStyle: UIAlertControllerStyle.Alert)
            
            
            refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
                
                self.bookingService.updateBooking(self.selectedBooking) { (data, responseMessage) -> () in
                    
                    dispatch_async(dispatch_get_main_queue()) {
                    
                        CommonUtil.processErrorUIResponseMsg("Booking cancellation", responseMessage: responseMessage)
                        
                        if responseMessage.code == ResponseStatus.Success {
                            let alertView = UIAlertController(title: "Successful", message: "Booking successfully cancelled", preferredStyle: UIAlertControllerStyle.Alert)
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

        
    }
}
