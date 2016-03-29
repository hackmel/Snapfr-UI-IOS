//
//  CommonUtils.swift
//  Snapfr
//
//  Created by Rommel Suarez on 15/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation

class ResponseBuilder {
    
    
    static func buildProfile(responseDict:NSDictionary) -> Profile {
        
        let profile = Profile()
        
        
        
        if let id = responseDict["id"] as? String {
            profile.id = id
        }
        
        
        if let isCustomer: AnyObject = responseDict["is_customer"] {
            profile.isCustomer = isCustomer as! Bool
        }
        
        if let isPhotographer: AnyObject = responseDict["is_photographer"] {
            profile.isPhotographer = isPhotographer as! Bool
        }
        
        if let name: AnyObject = responseDict["name"] {
            profile.name = name as! String
        }
        
        if let location: AnyObject = responseDict["location"] {
            profile.location = location as! String
        }
        
        if let avatar: AnyObject = responseDict["avatar_file_path"] {
            profile.avatar = "http://localhost:3000/" + (avatar as! String)
            
        }
        
        if let userData = responseDict["users"] as? NSArray {
            profile.user =  self.buildUsers(userData)
            
            
        }
        
        if let reviews = responseDict["reviews"] as? NSArray {
            for review in reviews {
                profile.reviews.append(self.buildReview(review as! NSDictionary))
            }
            
        }
        
        
        return profile
    }
    
    
    
    static func buildUsers(responseDict:NSArray)-> User {
        
        let userData = User()
        
        
        
        for response in responseDict {
            if let data = response as? NSDictionary {
                
                if let id = data["_id"] as? NSDictionary {
                    userData.id = id["$oid"] as! String
                }
                
                
                if let email: AnyObject = data["email"] {
                    userData.email = email as! String
                }
                
                if let password: AnyObject = data["password"] {
                    userData.password = password as! String
                }
                
                
                
            }
        }
        
        
        
        return userData
        
    }
    
    
    static func buildUser(responseDict:NSDictionary)-> User {
        
        print(responseDict)
        
        let userData = User()
        
        
        
        if let id = responseDict["id"] as? String {
            userData.id = id
        }
        
        
        if let email: AnyObject = responseDict["email"] {
            userData.email = email as! String
        }
        
        if let password: AnyObject = responseDict["password"] {
            userData.password = password as! String
        }
        
        if let profileData = responseDict["profile_id"] as? NSDictionary {
            
            userData.profile = self.buildProfile(profileData)
            
            
        }
        
        
        return userData
        
    }
    
    
    
    
    static func buildReview(responseDict:NSDictionary)-> Review {
        
        
        print(responseDict)
        let review = Review()
        
       
        
        if let id = responseDict["id"] as? String {
            review.id = id
        }
        
        
        if let bookingId: AnyObject = responseDict["booking_id"] {
            review.booking.id  = bookingId as! String
            
        }
        
        if let comments: AnyObject = responseDict["comments"] {
            review.comments = comments as! String
        }
        
        
        if let rating: AnyObject = responseDict["rating"] {
            review.rating = rating as! Int
        }
        
        if let ratingFor: AnyObject = responseDict["rating_for_id"] {
            review.ratingFor.id = ratingFor as! String
        }
        
       
        if let ratingFrom: AnyObject = responseDict["rating_from_id"] {
            review.ratingFrom.id = ratingFrom as! String
        }
        
        if let is_customer: AnyObject = responseDict["is_customer"] {
            review.isCustomer = is_customer as! Bool
        }
     
        return review
        
    }
    
    
    
    
    
    static func buildSingleServiceGroup(responseDict:NSDictionary) -> ServiceGroup {
        
        
         print(responseDict)
         let serviceGroup = ServiceGroup()
        
        
         if let id = responseDict["id"] as? String {
             serviceGroup.id = id
         }
                
                
         if let name: AnyObject = responseDict["name"] {
             serviceGroup.name = name as! String
          }
                
                
          if let summary: AnyObject = responseDict["summary"] {
             serviceGroup.summary = summary as! String
          }
                
                
          if let profileData = responseDict["profile_id"] as? NSDictionary {
             print(profileData)
             serviceGroup.profile = self.buildProfile(profileData)
                    
          }
        
        
          if let profileData = responseDict["profile_id"] as? String {
            print(profileData)
            serviceGroup.profile.id = profileData
            
          }
        
        
        
        return serviceGroup
    }
    

    
    static func buildServiceGroup(responseDict:NSArray) -> Array<ServiceGroup> {
        var serviceGroupList =  Array<ServiceGroup>()
        
        
        for response in responseDict {
            if let data = response as? NSDictionary {
                
                let serviceGroup = ServiceGroup()
                
               
                if let id = data["id"] as? String {
                    serviceGroup.id = id
                }
                
                
                if let name: AnyObject = data["name"] {
                    serviceGroup.name = name as! String
                }
                
                
                if let summary: AnyObject = data["summary"] {
                    serviceGroup.summary = summary as! String
                }
                
                
                if let profileData = data["profile"] as? NSDictionary {
                    
                    serviceGroup.profile = self.buildProfile(profileData)
                    
                }
                
                serviceGroupList.append(serviceGroup)
            }
        }
        return serviceGroupList
    }
    
    
    
    static func buildService(responseDict:NSArray) -> Array<Service> {
        var serviceList = Array<Service>()
        
        print(responseDict)
        for response in responseDict {
            if let data = response as? NSDictionary {
                
                
                let service = Service()
                
                if let id = data["id"] as? String {
                    service.id = id
                }
                
                if let name: AnyObject = data["name"] {
                    service.name = name as! String
                }
                
                if let summary: AnyObject = data["summary"] {
                    service.summary = summary as! String
                }
                
                if let price: AnyObject = data["price"]  {
                    
                    service.price = price as! Float
                    
                }
                
                if let serviceGroup = data["service_group_id"] as? NSDictionary {
                    
                    service.serviceGroup = self.buildSingleServiceGroup(serviceGroup )
                    
                }
                
                
                
                if let serviceImage = data["service_images"] as? NSArray {
                    
                    service.serviceImage = self.buildServiceImages(serviceImage)
                    
                }
                
                serviceList.append(service)
            }
        }
        return serviceList
    }
    
    
    static func buildSingleService(data:NSDictionary) -> Service {
        let service = Service()
        
        
        if let id = data["id"] as? String {
            service.id = id
        }
        
        
        if let name: AnyObject = data["name"] {
            service.name = name as! String
        }
        
        if let summary: AnyObject = data["summary"] {
            service.summary = summary as! String
        }
        
        if let price: AnyObject = data["price"]  {
            
            service.price = price as! Float
            
        }
        
        
        
        if let serviceImage = data["service_images"] as? NSArray {
            
            service.serviceImage = self.buildServiceImages(serviceImage)
            
        }
        
        
        
        
        return service
    }
    
    
    static func buildServiceImages(responseDict:NSArray) -> Array<ServiceImage> {
        var serviceImageList = Array<ServiceImage>()
        
        for response in responseDict {
            if let data = response as? NSDictionary {
                
                
                let serviceImage = ServiceImage()
                
               
                if let id = data["id"] as? String {
                    serviceImage.id = id
                }
                
                
                if let name: AnyObject = data["image_file_path"] {
                    serviceImage.serviceImage = "http://localhost:3000/" + (name as! String)
                }
                
                
                serviceImageList.append(serviceImage)
            }
        }
        return serviceImageList
    }


    
    static func buildBooking(responseDict:NSDictionary)-> Booking {
        
        let bookingData = Booking()
        
        //print(responseDict)
        
        if let id = responseDict["id"] as? String {
            bookingData.id = id
        }
        
        
        if let email: AnyObject = responseDict["remarks"] {
            bookingData.remarks = email as! String
        }
        
        if let status: AnyObject = responseDict["status"] {
            
            if  BookingStatus.Accepted.rawValue == status as! Int{
                bookingData.status = BookingStatus.Accepted
            }else if  BookingStatus.Rejected.rawValue == status as! Int{
                bookingData.status = BookingStatus.Rejected
            }else if  BookingStatus.CancelledRequest.rawValue == status as! Int{
                bookingData.status = BookingStatus.CancelledRequest
            }else if  BookingStatus.CancelledBooking.rawValue == status as! Int{
                bookingData.status = BookingStatus.CancelledBooking
            }else if  BookingStatus.Pending.rawValue == status as! Int{
                bookingData.status = BookingStatus.Pending
            }else if  BookingStatus.Completed.rawValue == status as! Int{
                bookingData.status = BookingStatus.Completed
            }
            
            
        }
        
        
        if let rejectReason: AnyObject = responseDict["reject_reason"] {
            bookingData.rejectReason = rejectReason as! String
        }
        
        
        if let cancelReason: AnyObject = responseDict["cancel_reason"] {
            bookingData.cancelReason = cancelReason as! String
        }
        
        
        if let photographer = responseDict["photographer_id"] as? NSDictionary {
            
            bookingData.photographer = ResponseBuilder.buildProfile(photographer)
            
            
        }
        
        if let customer = responseDict["customer_id"] as? NSDictionary {
            bookingData.customer = ResponseBuilder.buildProfile(customer)
            
        }
        
        if let bookingDate = responseDict["booking_date"] {
            
            let formatter = NSDateFormatter()
            formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
            formatter.dateFormat = "dd-MM-yyyy hh:mm a"
            
            
            bookingData.bookingDate = formatter.dateFromString(bookingDate as! String)
        }
        
        if let service = responseDict["service"] as? NSDictionary  {
            bookingData.service = ResponseBuilder.buildSingleService(service)
        }
        
        
        if let reviews = responseDict["reviews"] as? NSArray {
            
            for review in reviews {
                if let data = review as? NSDictionary {
                    
                    var reviewData = Review()
                    reviewData = ResponseBuilder.buildReview(data)
                    
                    bookingData.review.append(reviewData)
                }
                
            }
            
            
            
            
        }
        
        
        return bookingData
        
    }

    
    
    static func populateServiceGroupResponse (data:NSData!, httpUtil:HttpUtil) -> (data:ServiceGroup!,responseMessage:ResponseMessage!){
        
        var responseMessage = ResponseMessage()
        
        do {
            
            
            let responseDict = (try NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
            
            var serviceGroup = ServiceGroup()
            
            responseMessage = httpUtil.jsonReposnseParser(responseDict);
            
            if (responseMessage.code == ResponseStatus.Failed ) {
                return (data: nil,responseMessage: responseMessage)
            }else if (responseMessage.code == ResponseStatus.Record_Not_Found) {
                return (data: nil,responseMessage: responseMessage)
            }else {
                
                serviceGroup = ResponseBuilder.buildSingleServiceGroup(responseMessage.data)
                return (data: serviceGroup,responseMessage: responseMessage)
            }
            
            
            
        } catch let caught  {
            responseMessage.errorType = caught
            return (data: nil,responseMessage: responseMessage)
        }
        
        
    }

    
    static func populateServiceGroupCollectionResponse (data:NSData!, httpUtil:HttpUtil) -> (data:Array<ServiceGroup>!,responseMessage:ResponseMessage!){
        
        var responseMessage = ResponseMessage()
        
        do {
            
            
            let responseDict = (try NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
            
            var serviceGroupList = Array<ServiceGroup>()
            
            responseMessage = httpUtil.jsonReposnseParser(responseDict);
            
            if (responseMessage.code == ResponseStatus.Failed ) {
                return (data: nil,responseMessage: responseMessage)
            }else if (responseMessage.code == ResponseStatus.Record_Not_Found) {
                return (data: nil,responseMessage: responseMessage)
            }else {
                
                serviceGroupList = ResponseBuilder.buildServiceGroup(responseMessage.dataCollection)
                return (data: serviceGroupList,responseMessage: responseMessage)
            }
            
            
            
        } catch let caught  {
            responseMessage.errorType = caught
            return (data: nil,responseMessage: responseMessage)
        }
        
        
    }
    
    
    
    static func populateProfileResponse (data:NSData!, httpUtil:HttpUtil) -> (data:Profile!,responseMessage:ResponseMessage!){
        
        var responseMessage = ResponseMessage()
        
        do {
            
            
            let responseDict = (try NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
            
            var profile = Profile()
            
            responseMessage = httpUtil.jsonReposnseParser(responseDict);
            
            print(responseMessage)
            
            if (responseMessage.code == ResponseStatus.Failed ) {
                return (data: nil,responseMessage: responseMessage)
            }else if (responseMessage.code == ResponseStatus.Record_Not_Found) {
                return (data: nil,responseMessage: responseMessage)
            }else {
                
                profile = ResponseBuilder.buildProfile(responseMessage.data)
                return (data: profile,responseMessage: responseMessage)
            }
            
            
            
        } catch let caught  {
            responseMessage.errorType = caught
            return (data: nil,responseMessage: responseMessage)
        }
        
        
    }

    
    static func populateProfileCollectionResponse (data:NSData!, httpUtil:HttpUtil) -> (data:Array<Profile>!,responseMessage:ResponseMessage!){
        
        var responseMessage = ResponseMessage()
        var profileList = Array<Profile>()
        
        do {
            
            
            let responseDict = (try NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
            
            
            responseMessage = httpUtil.jsonReposnseParser(responseDict);
            if (responseMessage.code == ResponseStatus.Failed ) {
                return (data: nil,responseMessage: responseMessage)
            }else if (responseMessage.code == ResponseStatus.Record_Not_Found) {
                return (data: nil,responseMessage: responseMessage)
            }else {
                
                if let response = responseMessage.dataCollection {
                    for resp in  response {
                        if let data = resp as? NSDictionary {
                            var profile = Profile()
                            profile = ResponseBuilder.buildProfile(data)
                            
                            profileList.append(profile)
                            
                            
                        }
                    }
                    
                    
                    
                    
                }
                
                
                
                
            }
            
            
        } catch let caught  {
            responseMessage.errorType = caught
            return (data: nil,responseMessage: responseMessage)
        }
        
        return (data: profileList,responseMessage: responseMessage)
    }

    
    
    
    static func populateUserResponse(emailDict: Dictionary<String, AnyObject>,url:String,
        completion: (data:User!, responseMessage:ResponseMessage!)  -> ()){
            
            let httpUtil = HttpUtil()
            let responseMessage = ResponseMessage()
            
            
            httpUtil.sendRequest(emailDict,method:"POST" ,url: url,
                completion: {(data:NSData!, error:NSError!) in
                    
                    if error != nil {
                        responseMessage.nsError = error
                        completion (data: nil,responseMessage: responseMessage)
                        return
                    }
                    
                    do {
                        
                        
                        if let responseDict = try NSJSONSerialization.JSONObjectWithData(data,
                            options: NSJSONReadingOptions.AllowFragments) as? NSDictionary {
                                
                                
                                
                                let responseMessage = httpUtil.jsonReposnseParser(responseDict);
                                
                                if (responseMessage.code == ResponseStatus.Failed ) {
                                    completion (data: nil,responseMessage: responseMessage)
                                }else if (responseMessage.code == ResponseStatus.Record_Not_Found) {
                                    completion (data: nil,responseMessage: responseMessage)
                                }else {
                                    var userData = User()
                                    userData = ResponseBuilder.buildUser(responseMessage.data)
                                    completion (data: userData,responseMessage: responseMessage)
                                }
                                
                                
                                
                                
                        }else{
                            completion (data: nil,responseMessage: nil)
                        }
                        
                        
                    } catch let caught {
                        responseMessage.errorType = caught
                        completion (data: nil,responseMessage: responseMessage)
                    }
                    
                    
                    
                    
            })
            
    }

    
    
    static func populateServiceImageCollection (data:NSData!, httpUtil:HttpUtil) -> (data:Array<ServiceImage>!,responseMessage:ResponseMessage!){
        
        var responseMessage = ResponseMessage()
        var serviceList = Array<ServiceImage>()
        
        do {
         
            let responseDict = (try NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
            
            
            responseMessage = httpUtil.jsonReposnseParser(responseDict);
            
            if (responseMessage.code == ResponseStatus.Failed ) {
                return (data: nil,responseMessage: responseMessage)
            }else if (responseMessage.code == ResponseStatus.Record_Not_Found) {
                return (data: nil,responseMessage: responseMessage)
            }else {
                
                serviceList = ResponseBuilder.buildServiceImages(responseMessage.dataCollection)
                return (data: serviceList,responseMessage: responseMessage)
            }
            
        } catch let caught  {
            responseMessage.errorType = caught
            return (data: nil,responseMessage: responseMessage)
        }
        
        
        
    }


    
    static func populateServiceCollection (data:NSData!, httpUtil:HttpUtil) -> (data:Array<Service>!,responseMessage:ResponseMessage!){
        
        var responseMessage = ResponseMessage()
        
        
        do {
            
            
            var serviceList = Array<Service>()
            
            let responseDict = (try NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
            
            
            responseMessage = httpUtil.jsonReposnseParser(responseDict);
            
            if (responseMessage.code == ResponseStatus.Failed ) {
                return (data: nil,responseMessage: responseMessage)
            }else if (responseMessage.code == ResponseStatus.Record_Not_Found) {
                return (data: nil,responseMessage: responseMessage)
            }else {
                
                serviceList = ResponseBuilder.buildService(responseMessage.dataCollection)
                return (data: serviceList,responseMessage: responseMessage)
            }
            
            
            
            
            
            
            
        } catch let caught  {
            responseMessage.errorType = caught
            return (data: nil,responseMessage: responseMessage)
        }
        
        
        
    }
    

    
    static func populateServiceResponse (data:NSData!, httpUtil:HttpUtil) -> (data:Service!,responseMessage:ResponseMessage!){
        
        var responseMessage = ResponseMessage()
        
        
        do {
            
                       
            var service = Service()
            
            let responseDict = (try NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
            
            
            responseMessage = httpUtil.jsonReposnseParser(responseDict);
            
            if (responseMessage.code == ResponseStatus.Failed ) {
                return (data: nil,responseMessage: responseMessage)
            }else if (responseMessage.code == ResponseStatus.Record_Not_Found) {
                return (data: nil,responseMessage: responseMessage)
            }else {
                
                service = ResponseBuilder.buildSingleService(responseMessage.data)
                return (data: service,responseMessage: responseMessage)
            }
            
            
            
            
            
            
            
        } catch let caught  {
            responseMessage.errorType = caught
            return (data: nil,responseMessage: responseMessage)
        }
        
        
        
    }
    
    
    
    
    static func populateBookingResponse (data:NSData!, httpUtil:HttpUtil) -> (data:Booking!,responseMessage:ResponseMessage!){
        
        var responseMessage = ResponseMessage()
        
        do {
            
            
            let responseDict = (try NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
            
            
            var booking = Booking()
            
            responseMessage = httpUtil.jsonReposnseParser(responseDict);
            
            if (responseMessage.code == ResponseStatus.Failed ) {
                return (data: nil,responseMessage: responseMessage)
            }else if (responseMessage.code == ResponseStatus.Record_Not_Found) {
                return (data: nil,responseMessage: responseMessage)
            }else {
                
                 booking = ResponseBuilder.buildBooking(responseMessage.data)
                return (data: booking,responseMessage: responseMessage)
            }
            
            
            
        } catch let caught  {
            responseMessage.errorType = caught
            return (data: nil,responseMessage: responseMessage)
        }
        
        
    }
    

    static func populateBookingResponseCollection (data:NSData!, httpUtil:HttpUtil) -> (data:Array<Booking>!,responseMessage:ResponseMessage!){
        
        var responseMessage = ResponseMessage()
        
        
        do {
            
            
            let responseDict = (try NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
            
            
            responseMessage = httpUtil.jsonReposnseParser(responseDict);
            if (responseMessage.code == ResponseStatus.Failed ) {
                return (data: nil,responseMessage: responseMessage)
            }else if (responseMessage.code == ResponseStatus.Record_Not_Found) {
                return (data: nil,responseMessage: responseMessage)
            }else {
                
                var bookingList = Array<Booking>()
                for response in responseMessage.dataCollection {
                    if let data = response as? NSDictionary {
                        
                        var booking = Booking()
                        booking = ResponseBuilder.buildBooking(data)
                        
                        bookingList.append(booking)
                    }
                    
                }
                

                return (data: bookingList,responseMessage: responseMessage)
            }
            
            
            
            
            
            
            
            
            
        } catch let caught  {
            responseMessage.errorType = caught
            return (data: nil,responseMessage: responseMessage)
        }
        
        
        
    }

    
    
    static func populateReviewResponse (data:NSData!, httpUtil:HttpUtil) -> (data:Review!,responseMessage:ResponseMessage!){
        
        var responseMessage = ResponseMessage()
        
        do {
            
            
            let responseDict = (try NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
            
            
            var review = Review()
            
            responseMessage = httpUtil.jsonReposnseParser(responseDict);
            
            if (responseMessage.code == ResponseStatus.Failed ) {
                return (data: nil,responseMessage: responseMessage)
            }else if (responseMessage.code == ResponseStatus.Record_Not_Found) {
                return (data: nil,responseMessage: responseMessage)
            }else {
                
                review = ResponseBuilder.buildReview(responseMessage.data)
                return (data: review,responseMessage: responseMessage)
            }
            
            
            
            
           
            
        } catch let caught  {
            responseMessage.errorType = caught
            return (data: nil,responseMessage: responseMessage)
        }
        
        
    }
    
    
    static func populateReviewResponseCollection (data:NSData!, httpUtil:HttpUtil) -> (data:Array<Review>!,responseMessage:ResponseMessage!){
        
        var responseMessage = ResponseMessage()
        
        
        do {
            
            
            let responseDict = (try NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
            
            
            responseMessage = httpUtil.jsonReposnseParser(responseDict);
            
            if (responseMessage.code == ResponseStatus.Failed ) {
                return (data: nil,responseMessage: responseMessage)
            }else if (responseMessage.code == ResponseStatus.Record_Not_Found) {
                return (data: nil,responseMessage: responseMessage)
            }else {
                
                var reviewList = Array<Review>()
                
                for review in responseMessage.dataCollection {
                    if let data = review as? NSDictionary {
                        
                        var reviewData = Review()
                        reviewData = ResponseBuilder.buildReview(data)
                        
                        reviewList.append(reviewData)
                    }
                    
                }
                
                
                
                return (data: reviewList,responseMessage: responseMessage)
            }
            
            
            
            
            
            
            
            
            
        } catch let caught  {
            responseMessage.errorType = caught
            return (data: nil,responseMessage: responseMessage)
        }
        
        
        
    }
    


}
