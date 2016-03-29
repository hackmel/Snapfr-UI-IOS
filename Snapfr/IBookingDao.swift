//
//  IBookingDao.swift
//  Snapfr
//
//  Created by Rommel Suarez on 18/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation

protocol IBookingDao {
    
    /**
     This creates a booking
     - parameter booking: The booking object to create.
     - parameter call back : returns Booking and response message.
     - returns:  Nothing
     */
    func createBooking(booking : Booking ,completion: (data:Booking!, responseMessage:ResponseMessage!) -> ())
    
    /**
     This updates a booking
     - parameter booking: The booking object to update.
     - parameter call back : returns Booking and response message.
     - returns:  Nothing
     */
    func updateBooking(booking : Booking ,completion: (data:Booking!, responseMessage:ResponseMessage!) -> ())
    /**
     This returns pending booking request as a customer
     - parameter profileId: The profileId to search.
     - parameter call back : returns array of Booking and response message.
     - returns:  Nothing
     */
    func getPendingBookingRequestsAsCustomer(profileId : String ,completion: (data:Array<Booking>!, responseMessage:ResponseMessage!) -> ())
    /**
     This returns pending booking request from customers
     - parameter profileId: The profileId to search.
     - parameter call back : returns array of Booking and response message.
     - returns:  Nothing
     */
    func getPendingBookingRequestsFromCustomers(profileId : String ,completion: (data:Array<Booking>!, responseMessage:ResponseMessage!) -> ())
    
    /**
     This returns a booking request as a customer
     - parameter profileId: The profileId to search.
     - parameter call back : returns array of Booking and response message.
     - returns:  Nothing
     */

    func getBookingsAsCustomer(profileId : String ,completion: (data:Array<Booking>!, responseMessage:ResponseMessage!) -> ())
    
    /**
     This returns a booking request from customers
     - parameter profileId: The profileId to search.
     - parameter call back : returns array of Booking and response message.
     - returns:  Nothing
     */
    func getBookingsFromCustomers(profileId : String ,completion: (data:Array<Booking>!, responseMessage:ResponseMessage!) -> ())
}