//
//  Review.swift
//  Snapfr
//
//  Created by Rommel Suarez on 22/11/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation


class Review {
    
    var id: String! = ""
    var booking : Booking! = Booking()
    var rating : Int = 0
    var comments : String = ""
    var ratingFor : Profile! = Profile()
    var ratingFrom : Profile! = Profile()
    var isCustomer: Bool! = false
}