//
//  Booking.swift
//  Snapfr
//
//  Created by Rommel Suarez on 27/10/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation


class Booking {
    
    var id: String! = ""
    var bookingDate : NSDate!
    var photographer : Profile = Profile()
    var customer : Profile = Profile()
    var remarks : String! = ""
    var service : Service = Service()
    var status : BookingStatus = BookingStatus.Pending
    var rejectReason : String = ""
    var cancelReason : String = ""
    var review = Array<Review>()
}
