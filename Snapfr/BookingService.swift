//
//  BookingService.swift
//  Snapfr
//
//  Created by Rommel Suarez on 27/10/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

/**
 This class implements the service layer of Booking object
 */
class BookingService {
    
    var bookingDao : IBookingDao
    
    
    init(newBookingDao: IBookingDao){
        self.bookingDao = newBookingDao
    }
    
    /**
     This creates a booking
     - parameter booking: The booking object to create.
     - parameter call back : returns Booking and response message.
     - returns:  Nothing
     */
    
    func createBooking(booking : Booking ,completion: (data:Booking!, responseMessage:ResponseMessage!) -> ()){
        
        bookingDao.createBooking(booking) { (data, responseMessage) -> () in
            completion(data: data, responseMessage: responseMessage)
        }
                
        
    }
    
    
    /**
     This updates a booking
     - parameter booking: The booking object to update.
     - parameter call back : returns Booking and response message.
     - returns:  Nothing
     */
    func updateBooking(booking : Booking ,completion: (data:Booking!, responseMessage:ResponseMessage!) -> ()){
        bookingDao.updateBooking(booking) { (data, responseMessage) -> () in
            completion(data: data, responseMessage: responseMessage)
        }
        
        
    }
    
    /**
     This returns pending booking request as a customer
     - parameter profileId: The profileId to search.
     - parameter call back : returns array of Booking and response message.
     - returns:  Nothing
     */
    func getPendingBookingRequestsAsCustomer(profileId : String ,completion: (data:Array<Booking>!, responseMessage:ResponseMessage!) -> ()){
        
        bookingDao.getPendingBookingRequestsAsCustomer(profileId) { (data, responseMessage) -> () in
            completion(data: data, responseMessage: responseMessage)
        }
    }
    
    /**
     This returns pending booking request from customers
     - parameter profileId: The profileId to search.
     - parameter call back : returns array of Booking and response message.
     - returns:  Nothing
     */
    func getPendingBookingRequestsFromCustomers(profileId : String ,completion: (data:Array<Booking>!, responseMessage:ResponseMessage!) -> ()){
        
        bookingDao.getPendingBookingRequestsFromCustomers(profileId) { (data, responseMessage) -> () in
            completion(data: data, responseMessage: responseMessage)
        }
        
        
    }
    /**
     This returns a booking request as a customer
     - parameter profileId: The profileId to search.
     - parameter call back : returns array of Booking and response message.
     - returns:  Nothing
     */
    
    func getBookingsAsCustomer(profileId : String ,completion: (data:Array<Booking>!, responseMessage:ResponseMessage!) -> ()){
        bookingDao.getBookingsAsCustomer(profileId) { (data, responseMessage) -> () in
            completion(data: data, responseMessage: responseMessage)
        }
    }
    
    
    /**
     This returns a booking request from customers
     - parameter profileId: The profileId to search.
     - parameter call back : returns array of Booking and response message.
     - returns:  Nothing
     */
    func getBookingsFromCustomers(profileId : String ,completion: (data:Array<Booking>!, responseMessage:ResponseMessage!) -> ()){
        bookingDao.getBookingsFromCustomers(profileId) { (data, responseMessage) -> () in
            completion(data: data, responseMessage: responseMessage)
        }
     
    }
    
    
    

    
    
        

}
