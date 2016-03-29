//
//  BookingDao.swift
//  Snapfr
//
//  Created by Rommel Suarez on 18/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation

class BookingDao : IBookingDao {
    
    /**
     This creates a booking via REST API
     - parameter booking: The booking object to create.
     - parameter call back : returns Booking and response message.
     - returns:  Nothing
     */
    func createBooking(booking : Booking ,completion: (data:Booking!, responseMessage:ResponseMessage!) -> ()){
        
        
        let httpUtil = HttpUtil()
        let responseMessage = ResponseMessage()
        
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "dd-MM-yyyy hh:mm a"
        
        
        let bookingDate = formatter.stringFromDate(booking.bookingDate)
        
        
        let bookingDict: Dictionary<String, AnyObject> =
        
        [
            "booking_date":bookingDate,
            "remarks":booking.remarks,
            "photographer":booking.photographer.id,
            "customer":booking.customer.id,
            "service":booking.service.id,
            "status":booking.status.rawValue,
            "reject_reason":booking.rejectReason,
            "cancel_reason":booking.cancelReason
        ]
        
        
        httpUtil.sendRequest(bookingDict,method:"POST",url: "http://localhost:3000/createBooking/",
            completion: {(data:NSData!, error:NSError!) in
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    return
                }
                
                
                let retVal = ResponseBuilder.populateBookingResponse(data, httpUtil: httpUtil)
                
                completion (data: retVal.data,responseMessage: retVal.responseMessage)
                
                
                
                
        })
        
        
    }
    
    /**
     This updates a booking via REST API
     - parameter booking: The booking object to update.
     - parameter call back : returns Booking and response message.
     - returns:  Nothing
     */
    func updateBooking(booking : Booking ,completion: (data:Booking!, responseMessage:ResponseMessage!) -> ()){
        
        
        let httpUtil = HttpUtil()
        let responseMessage = ResponseMessage()
        
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "dd-MM-yyyy hh:mm a"
        
        
        let bookingDate = formatter.stringFromDate(booking.bookingDate)
        
        
        let bookingDict: Dictionary<String, AnyObject> =
        [
            "booking_id":booking.id,
            "booking_date":bookingDate,
            "remarks":booking.remarks,
            "photographer":booking.photographer.id,
            "customer":booking.customer.id,
            "service":booking.service.id,
            "status":booking.status.rawValue,
            "reject_reason":booking.rejectReason,
            "cancel_reason":booking.cancelReason
            
        ]
        
        
        httpUtil.sendRequest(bookingDict,method:"POST",url: "http://localhost:3000/updateBooking/",
            completion: {(data:NSData!, error:NSError!) in
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    return
                }
                
                
                
                let retVal = ResponseBuilder.populateBookingResponse(data, httpUtil: httpUtil)
                
                completion (data: retVal.data,responseMessage: retVal.responseMessage)

                
                
                
                
        })
        
        
    }
    
    /**
     This returns pending booking request as a customer via REST API
     - parameter profileId: The profileId to search.
     - parameter call back : returns array of Booking and response message.
     - returns:  Nothing
     */
    func getPendingBookingRequestsAsCustomer(profileId : String ,completion: (data:Array<Booking>!, responseMessage:ResponseMessage!) -> ()){
        
        
        let httpUtil = HttpUtil()
        let responseMessage = ResponseMessage()
        
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "dd-MM-yyyy hh:mm a"
        
        
        
        let dict: Dictionary<String, AnyObject> =
        [
            "id":profileId
        ]
        
        
        httpUtil.sendRequest(dict,method:"POST",url: "http://localhost:3000/getPendingBookingRequestsAsCustomer/",
            completion: {(data:NSData!, error:NSError!) in
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    return
                }
                
               let retVal = ResponseBuilder.populateBookingResponseCollection(data, httpUtil: httpUtil)
                completion (data: retVal.data,responseMessage: retVal.responseMessage)
                
        })
        
        
    }
    
    /**
     This returns pending booking request from customers via REST API
     - parameter profileId: The profileId to search.
     - parameter call back : returns array of Booking and response message.
     - returns:  Nothing
     */
    func getPendingBookingRequestsFromCustomers(profileId : String ,completion: (data:Array<Booking>!, responseMessage:ResponseMessage!) -> ()){
        
        
        let httpUtil = HttpUtil()
        let responseMessage = ResponseMessage()
        
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "dd-MM-yyyyThh:mm a"
        
        
        
        let dict: Dictionary<String, AnyObject> =
        [
            "id":profileId
        ]
        
        
        httpUtil.sendRequest(dict,method:"POST",url: "http://localhost:3000/getPendingBookingRequestsFromCustomers/",
            completion: {(data:NSData!, error:NSError!) in
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    return
                }
                
                let retVal = ResponseBuilder.populateBookingResponseCollection(data, httpUtil: httpUtil)
                completion (data: retVal.data,responseMessage: retVal.responseMessage)
             
        })
        
        
    }
    
    
    
    /**
     This returns a booking request as a customer via REST API
     - parameter profileId: The profileId to search.
     - parameter call back : returns array of Booking and response message.
     - returns:  Nothing
     */
    func getBookingsAsCustomer(profileId : String ,completion: (data:Array<Booking>!, responseMessage:ResponseMessage!) -> ()){
        
        
        let httpUtil = HttpUtil()
        let responseMessage = ResponseMessage()
        
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "dd-MM-yyyy hh:mm a"
        
        
        
        let dict: Dictionary<String, AnyObject> =
        [
            "id":profileId
        ]
        
        
        httpUtil.sendRequest(dict,method:"POST",url: "http://localhost:3000/getBookingsAsCustomer/",
            completion: {(data:NSData!, error:NSError!) in
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    return
                }
                
                
                let retVal = ResponseBuilder.populateBookingResponseCollection(data, httpUtil: httpUtil)
                completion (data: retVal.data,responseMessage: retVal.responseMessage)
                
                
                
        })
        
        
    }
    
    /**
     This returns a booking request from customers via REST API
     - parameter profileId: The profileId to search.
     - parameter call back : returns array of Booking and response message.
     - returns:  Nothing
     */
    func getBookingsFromCustomers(profileId : String ,completion: (data:Array<Booking>!, responseMessage:ResponseMessage!) -> ()){
        
        
        let httpUtil = HttpUtil()
        let responseMessage = ResponseMessage()
        
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "dd-MM-yyyyThh:mm a"
        
        
        
        let dict: Dictionary<String, AnyObject> =
        [
            "id":profileId
        ]
        
        
        httpUtil.sendRequest(dict,method:"POST",url: "http://localhost:3000/getBookingsFromCustomers/",
            completion: {(data:NSData!, error:NSError!) in
                if error != nil {
                    responseMessage.nsError = error
                    completion (data: nil,responseMessage: responseMessage)
                    return
                }
                
                
                let retVal = ResponseBuilder.populateBookingResponseCollection(data, httpUtil: httpUtil)
                completion (data: retVal.data,responseMessage: retVal.responseMessage)
                
                
                
        })
        
        
    }
    
    
    
    
        

    
}
