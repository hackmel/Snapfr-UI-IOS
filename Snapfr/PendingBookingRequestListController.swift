//
//  PendingBookingRequestListController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 10/11/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class PendingBookingRequestListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    let bookingService = BookingService(newBookingDao: BookingDao())
    var bookingServiceList = Array<Booking>()
    var selectedBooking = Booking()
    
    
    @IBOutlet weak var openMenu: UIBarButtonItem!
    override func viewDidLoad() {
        
        openMenu.target=self.revealViewController()
        openMenu.action=Selector("revealToggle:")
        
        
        
    }

    
    @IBAction func segmentControllerOnChange(sender: AnyObject) {
        
        if segmentController.selectedSegmentIndex == 0 {
            
            bookingService.getPendingBookingRequestsFromCustomers(Constants.ProfileID, completion: { (data, responseMessage) -> () in
                dispatch_async(dispatch_get_main_queue()) {
                    self.getRespsonse(data, responseMessage: responseMessage)
                }
                
            })

            
          
            
            
        }else if segmentController.selectedSegmentIndex == 1 {
            
            bookingService.getPendingBookingRequestsAsCustomer(Constants.ProfileID, completion: { (data, responseMessage) -> () in
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
            (cell.contentView.viewWithTag(2) as! UILabel).text = "YYY"


        }else {
            cell.textLabel?.text = booking.service.name
            cell.detailTextLabel?.text = booking.photographer.name
        }

        if booking.status == BookingStatus.Pending {
            (cell.contentView.viewWithTag(2) as! UILabel).text = "Pending"
        }else if booking.status == BookingStatus.Rejected {
            (cell.contentView.viewWithTag(2) as! UILabel).text = "Rejected"
        }else if booking.status == BookingStatus.CancelledRequest {
            (cell.contentView.viewWithTag(2) as! UILabel).text = "Cancelled"
        }

        
        return cell
        
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedBooking = self.bookingServiceList[indexPath.row]
        
        
        if selectedBooking.status == BookingStatus.CancelledRequest {
            performSegueWithIdentifier("cancelledBookingSegue", sender: nil)
            
        }else if selectedBooking.status == BookingStatus.Rejected {
                performSegueWithIdentifier("rejectedBookingSegue", sender: nil)
            
        }else{
            
            if segmentController.selectedSegmentIndex == 0 {
                performSegueWithIdentifier("ViewPendingCustomerRequestSegue", sender: nil)
                
            }else {
                performSegueWithIdentifier("ViewMyPendingRequestSegue", sender: nil)
                
            }
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ViewPendingCustomerRequestSegue" {
            
            let viewPendingRequest = segue.destinationViewController as! ViewPendingCustomerRequestController
            
            viewPendingRequest.selectedBooking = self.selectedBooking
        }else if segue.identifier == "ViewMyPendingRequestSegue" {
            
            let viewPendingRequest = segue.destinationViewController as! ViewMyPendingRequestController
            
            viewPendingRequest.selectedBooking = self.selectedBooking
            viewPendingRequest.selectedBooking = self.selectedBooking
        }else if segue.identifier == "cancelledBookingSegue" {
            
            let cancelledBookingController = segue.destinationViewController as! CancelledBookingController
            
            cancelledBookingController.selectedBooking = self.selectedBooking
        }else if segue.identifier == "rejectedBookingSegue" {
            
            let rejectedBookingController = segue.destinationViewController as! RejectedBookingController
            
            rejectedBookingController.selectedBooking = self.selectedBooking
        }
        


    }
    
    
    @IBAction func unwindSeguePendingBookingRequestList(segue: UIStoryboardSegue) {
        if segmentController.selectedSegmentIndex == 0 {
             bookingService.getPendingBookingRequestsFromCustomers(Constants.ProfileID, completion: { (data, responseMessage) -> () in
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.getRespsonse(data, responseMessage: responseMessage)
                }
                
            })

            
        }else if segmentController.selectedSegmentIndex == 1 {
             bookingService.getPendingBookingRequestsAsCustomer(Constants.ProfileID, completion: { (data, responseMessage) -> () in
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.getRespsonse(data, responseMessage: responseMessage)
                }
                
            })

        
        }

    }
    
    private func getRespsonse (data:Array<Booking>,responseMessage:ResponseMessage ) -> Void {
        CommonUtil.processErrorUIResponseMsg("Pending Booking Request", responseMessage: responseMessage)
    
        if responseMessage.code == ResponseStatus.Success {
            if data.count > 0 {
                self.bookingServiceList = data
                self.tableView.reloadData()
            }
        }

    
    }
    
}
