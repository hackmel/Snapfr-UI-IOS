//
//  BookingListController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 14/11/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class BookingListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var openMenu: UIBarButtonItem!
    
    
    let bookingService = BookingService(newBookingDao: BookingDao())
    var bookingServiceList = Array<Booking>()
    var selectedBooking = Booking()
    override func viewDidLoad() {
        
        openMenu.target=self.revealViewController()
        openMenu.action=Selector("revealToggle:")
        
        
        
    }
    
    
    @IBAction func segmentControllerOnChange(sender: AnyObject) {
        
        if segmentController.selectedSegmentIndex == 0 {
            
            bookingService.getBookingsFromCustomers(Constants.ProfileID, completion: { (data, responseMessage) -> () in
                dispatch_async(dispatch_get_main_queue()) {
                   self.getRespsonse(data, responseMessage: responseMessage)
                }
                
            })
            
            
            
            
            
        }else if segmentController.selectedSegmentIndex == 1 {
            
            bookingService.getBookingsAsCustomer(Constants.ProfileID, completion: { (data, responseMessage) -> () in
                dispatch_async(dispatch_get_main_queue()) {
                   self.getRespsonse(data, responseMessage: responseMessage)
                }
                
            })
            
            
        }

        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return bookingServiceList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let booking = self.bookingServiceList[indexPath.row]
        
        
        if segmentController.selectedSegmentIndex == 0 {
            cell.textLabel?.text = booking.service.name
            cell.detailTextLabel?.text = booking.customer.name
            
        }else {
            cell.textLabel?.text = booking.service.name
            cell.detailTextLabel?.text = booking.photographer.name
            
        }
        
        if booking.status == BookingStatus.Accepted {
            (cell.contentView.viewWithTag(2) as! UILabel).text = "Pending"
        }else if booking.status == BookingStatus.Completed {
            (cell.contentView.viewWithTag(2) as! UILabel).text = "Completed"
        }else if booking.status == BookingStatus.CancelledBooking {
            (cell.contentView.viewWithTag(2) as! UILabel).text = "Cancelled"
        }

        
        return cell
        
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedBooking = self.bookingServiceList[indexPath.row]
        
        
        if selectedBooking.status == BookingStatus.CancelledBooking {
             performSegueWithIdentifier("cancelledBookingSegue", sender: nil)
            
        }else   if selectedBooking.status == BookingStatus.Completed {
            performSegueWithIdentifier("completedBookingSegue", sender: nil)
            
        }else{
            if segmentController.selectedSegmentIndex == 0 {
                performSegueWithIdentifier("viewCustomerBookingSegue", sender: nil)
                
            }else {
                performSegueWithIdentifier("viewMyBookingsSegue", sender: nil)
                
            }

        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewCustomerBookingSegue" {
            
            let viewCustomerBookingController = segue.destinationViewController as! ViewCustomerBookingController
            
            viewCustomerBookingController.selectedBooking = selectedBooking
        }else if segue.identifier == "viewMyBookingsSegue" {
            
            let viewMyBookingController = segue.destinationViewController as! ViewMyBookingController
            
            viewMyBookingController.selectedBooking = selectedBooking
        }else if segue.identifier == "cancelledBookingSegue" {
            
            let cancelledBookingController = segue.destinationViewController as! CancelledBookingController
            
            cancelledBookingController.selectedBooking = selectedBooking
        }else if segue.identifier == "completedBookingSegue" {
            
            let completedBookingController = segue.destinationViewController as! CompletedBookingController
            
            completedBookingController.selectedBooking = selectedBooking
            
            
            if segmentController.selectedSegmentIndex == 0 {
                completedBookingController.isCustomer = false
                
            }else if segmentController.selectedSegmentIndex == 1 {
                completedBookingController.isCustomer = true

            }

        }
    }
    
    
    @IBAction func unwindSegueBookingList(segue: UIStoryboardSegue) {
        if segmentController.selectedSegmentIndex == 0 {
            
            bookingService.getBookingsFromCustomers(Constants.ProfileID, completion: { (data, responseMessage) -> () in
                dispatch_async(dispatch_get_main_queue()) {
                    self.getRespsonse(data, responseMessage: responseMessage)
                }
                
            })
            
            
            
            
            
        }else if segmentController.selectedSegmentIndex == 1 {
            
            bookingService.getBookingsAsCustomer(Constants.ProfileID, completion: { (data, responseMessage) -> () in
                dispatch_async(dispatch_get_main_queue()) {
                   self.getRespsonse(data, responseMessage: responseMessage)
               }
                
            })
            
            
        }
        
    }

    
    
    private func getRespsonse (data:Array<Booking>,responseMessage:ResponseMessage ) -> Void {
        CommonUtil.processErrorUIResponseMsg("Booking List", responseMessage: responseMessage)
        
        if responseMessage.code == ResponseStatus.Success {
            if data.count > 0 {
                self.bookingServiceList = data
                self.tableView.reloadData()
            }
        }
        
        
    }

    
}
