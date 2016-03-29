//
//  MakeReviewController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 16/11/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class MakeReviewController: UIViewController {
    
    var selectedBooking = Booking()
   
    @IBOutlet weak var rateText: UILabel!
    @IBOutlet weak var oneStart: UIButton!
    @IBOutlet weak var twoStar: UIButton!
    @IBOutlet weak var threeStar: UIButton!
    @IBOutlet weak var fourStar: UIButton!
    @IBOutlet weak var fiveStar: UIButton!
    
    
    @IBOutlet weak var commentsText: UITextView!
    
    let reviewService = ReviewService(newReviewDao: ReviewDao())
    var currentReview = Review()
    
    var isCustomer :Bool = false
    
    var rateSelected: Int = 0
    var rateOptionImg: [String] = ["star_none.png","star_none.png","star_none.png","star_none.png","star_none.png"]
    
    override func viewDidLoad() {
       let reviews = selectedBooking.review
        
        for  review in reviews {
            if self.isCustomer &&  review.ratingFor.id == selectedBooking.photographer.id {
               currentReview = review
               break
            }else if !self.isCustomer &&  review.ratingFor.id == selectedBooking.customer.id{
               currentReview = review
               break
            }

        }
        
        
        rateSelected = currentReview.rating
        
        commentsText.text = currentReview.comments
        
        rateOptionImg = displayRate (currentReview.rating)
        rateText.text = getRate(currentReview.rating)
        
        oneStart.setImage(UIImage(named: rateOptionImg[0]), forState: UIControlState.Normal)
        twoStar.setImage(UIImage(named: rateOptionImg[1]), forState: UIControlState.Normal)
        threeStar.setImage(UIImage(named: rateOptionImg[2]), forState: UIControlState.Normal)
        fourStar.setImage(UIImage(named: rateOptionImg[3]), forState: UIControlState.Normal)
        fiveStar.setImage(UIImage(named: rateOptionImg[4]), forState: UIControlState.Normal)
    }
    
    
    @IBAction func oneStarOnClick(sender: AnyObject) {
        var image = rateOptionImg[0]
      
        print (image)
        
        if rateOptionImg[0] == "star_selected.png" &&  rateOptionImg[1] == "star_none.png" {
            image = "star_none.png"
            rateSelected = 0
        }else if rateOptionImg[0] == "star_none.png" &&  rateOptionImg[1] == "star_none.png" {
            image = "star_selected.png"
            ++rateSelected
        }else if rateOptionImg[0] == "star_selected.png" &&  rateOptionImg[1] == "star_selected.png" {
            image = "star_selected.png"
            rateSelected = 1
            twoStar.setImage(UIImage(named: "star_none.png"), forState: UIControlState.Normal)
            threeStar.setImage(UIImage(named: "star_none.png"), forState: UIControlState.Normal)
            fourStar.setImage(UIImage(named: "star_none.png"), forState: UIControlState.Normal)
            fiveStar.setImage(UIImage(named: "star_none.png"), forState: UIControlState.Normal)
            rateOptionImg[1] = "star_none.png"
            rateOptionImg[2] = "star_none.png"
            rateOptionImg[3] = "star_none.png"
            rateOptionImg[4] = "star_none.png"
        }
        
            
        oneStart.setImage(UIImage(named: image), forState: UIControlState.Normal)
            
        rateOptionImg[0] = image
       
        self.rateText.text = getRate(self.rateSelected)
       
    }
    
    @IBAction func twoStarOnClick(sender: AnyObject) {
        
        var image = rateOptionImg[1]
        
        
        
        if rateOptionImg[1] == "star_selected.png" &&  rateOptionImg[2] == "star_none.png" {
            image = "star_none.png"
             --rateSelected
        }else if rateOptionImg[1] == "star_none.png" &&  rateOptionImg[0] == "star_selected.png" &&  rateOptionImg[2] == "star_none.png" {
          image = "star_selected.png"
             ++rateSelected
        }else if rateOptionImg[1] == "star_selected.png" &&  rateOptionImg[2] == "star_selected.png" {
            image = "star_selected.png"
            rateSelected = 2
            threeStar.setImage(UIImage(named: "star_none.png"), forState: UIControlState.Normal)
            fourStar.setImage(UIImage(named: "star_none.png"), forState: UIControlState.Normal)
            fiveStar.setImage(UIImage(named: "star_none.png"), forState: UIControlState.Normal)
            rateOptionImg[2] = "star_none.png"
            rateOptionImg[3] = "star_none.png"
            rateOptionImg[4] = "star_none.png"


        }else if rateOptionImg[1] == "star_none.png" &&  rateOptionImg[0] == "star_none.png" {
            image = "star_selected.png"
            rateSelected = 2
            oneStart.setImage(UIImage(named: image), forState: UIControlState.Normal)
            rateOptionImg[0] = image
         }

        
        twoStar.setImage(UIImage(named: image), forState: UIControlState.Normal)
        
        rateOptionImg[1] = image
        self.rateText.text = getRate(self.rateSelected)
        
    }
    
   
    @IBAction func threeStarOnClick(sender: AnyObject) {
        var image = rateOptionImg[2]
        
        
        
        if rateOptionImg[2] == "star_selected.png" &&  rateOptionImg[3] == "star_none.png" {
            image = "star_none.png"
             --rateSelected
        }else if rateOptionImg[2] == "star_none.png" &&  rateOptionImg[1] == "star_selected.png" &&  rateOptionImg[3] == "star_none.png"{
            image = "star_selected.png"
             ++rateSelected
        }else if rateOptionImg[2] == "star_selected.png" &&  rateOptionImg[3] == "star_selected.png" {
            image = "star_selected.png"
            rateSelected = 3
            fourStar.setImage(UIImage(named: "star_none.png"), forState: UIControlState.Normal)
            fiveStar.setImage(UIImage(named: "star_none.png"), forState: UIControlState.Normal)
            rateOptionImg[3] = "star_none.png"
            rateOptionImg[4] = "star_none.png"
        }else if rateOptionImg[2] == "star_none.png" &&  rateOptionImg[1] == "star_none.png" {
            image = "star_selected.png"
            rateSelected = 3
            oneStart.setImage(UIImage(named: image), forState: UIControlState.Normal)
            twoStar.setImage(UIImage(named: image), forState: UIControlState.Normal)
            rateOptionImg[0] = image
            rateOptionImg[1] = image
        }
        
        threeStar.setImage(UIImage(named: image), forState: UIControlState.Normal)
        
        rateOptionImg[2] = image
        self.rateText.text = getRate(self.rateSelected)
        
    }
    
    
    @IBAction func fourStarOnClick(sender: AnyObject) {
        var image = rateOptionImg[3]
        
        
        
        if rateOptionImg[3] == "star_selected.png" &&  rateOptionImg[4] == "star_none.png" {
            image = "star_none.png"
             --rateSelected
        }else if rateOptionImg[3] == "star_none.png" &&  rateOptionImg[2] == "star_selected.png" &&  rateOptionImg[4] == "star_none.png"{
            image = "star_selected.png"
            ++rateSelected
        }else if rateOptionImg[3] == "star_selected.png" &&  rateOptionImg[4] == "star_selected.png" {
            image = "star_selected.png"
            rateSelected = 4
            
            fiveStar.setImage(UIImage(named: "star_none.png"), forState: UIControlState.Normal)
            rateOptionImg[4] = "star_none.png"
        }else if rateOptionImg[3] == "star_none.png" &&  rateOptionImg[2] == "star_none.png" {
            image = "star_selected.png"
            rateSelected = 4
            oneStart.setImage(UIImage(named: image), forState: UIControlState.Normal)
            twoStar.setImage(UIImage(named: image), forState: UIControlState.Normal)
            threeStar.setImage(UIImage(named: image), forState: UIControlState.Normal)
           
            rateOptionImg[0] = image
            rateOptionImg[1] = image
            rateOptionImg[2] = image
        }

        
        fourStar.setImage(UIImage(named: image), forState: UIControlState.Normal)
        
        rateOptionImg[3] = image
        self.rateText.text = getRate(self.rateSelected)
        

    }
    
    
    @IBAction func fiveStarOnClick(sender: AnyObject) {
        var image = rateOptionImg[4]
        
        
        
        if rateOptionImg[4] == "star_selected.png" {
            image = "star_none.png"
             --rateSelected
        }else if rateOptionImg[4] == "star_none.png" &&  rateOptionImg[3] == "star_selected.png" {
            image = "star_selected.png"
             rateSelected = 5
        }else if rateOptionImg[4] == "star_none.png" &&  rateOptionImg[3] == "star_none.png" {
            image = "star_selected.png"
            rateSelected = 5
            oneStart.setImage(UIImage(named: image), forState: UIControlState.Normal)
            twoStar.setImage(UIImage(named: image), forState: UIControlState.Normal)
            threeStar.setImage(UIImage(named: image), forState: UIControlState.Normal)
            fourStar.setImage(UIImage(named: image), forState: UIControlState.Normal)
            
            rateOptionImg[0] = image
            rateOptionImg[1] = image
            rateOptionImg[2] = image
            rateOptionImg[3] = image
        }
        

        
        fiveStar.setImage(UIImage(named: image), forState: UIControlState.Normal)
        
        rateOptionImg[4] = image
        
        self.rateText.text = getRate(self.rateSelected)
        

    }
    
    
    
    @IBAction func submitOnClick(sender: AnyObject) {
        
    if currentReview.id != "" {
        
        
        currentReview.comments = self.commentsText.text
        currentReview.rating = self.rateSelected
         
        reviewService.updateReview(currentReview, completion: { (data, responseMessage) -> () in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                
                CommonUtil.processErrorUIResponseMsg("Rating and review", responseMessage: responseMessage)
                
                if responseMessage.code == ResponseStatus.Success {
                    let alertView = UIAlertController(title: "Successful", message: "Your rating and review are successfully completed", preferredStyle: UIAlertControllerStyle.Alert)
                    alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                        self.performSegueWithIdentifier("unwindSegueBookingList", sender: nil)
                    }));
                    
                    self.presentViewController(alertView, animated: true, completion: nil)
                    
                }

                
           
            }
            
            
            
        })
        
       
    }else {
        let review = Review()
        review.booking = selectedBooking
        
        review.comments = self.commentsText.text
        review.rating = self.rateSelected
        review.isCustomer = self.isCustomer
        
        if self.isCustomer {
            review.ratingFor = selectedBooking.photographer
            review.ratingFrom = selectedBooking.customer
            
        }else {
            review.ratingFor = selectedBooking.customer
            review.ratingFrom = selectedBooking.photographer
        }
        
        
        
        
        reviewService.createReview(review, completion: { (data, responseMessage) -> () in
            
            dispatch_async(dispatch_get_main_queue()) {
                 
                CommonUtil.processErrorUIResponseMsg("Rating and review", responseMessage: responseMessage)
                
                if responseMessage.code == ResponseStatus.Success {
                    let alertView = UIAlertController(title: "Successful", message: "Your rating and review are successfully completed", preferredStyle: UIAlertControllerStyle.Alert)
                    alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                        self.performSegueWithIdentifier("unwindSegueBookingList", sender: nil)
                    }));
                    
                    self.presentViewController(alertView, animated: true, completion: nil)
                    
                }
                

            }
            
            
            
        })
        
        }
        
       

    }
        
        
    
    func getRate(params:Int ) -> String {
        switch params {
        case 1: return "One Star"
        case 2: return "Two Stars"
        case 3: return "Three Stars"
        case 4: return "Four Stars"
        case 5: return "Five Stars"
        default: return "No Rating"
        }
    }
    
    
    func displayRate(params:Int ) -> [String] {
        
        var dispRate = [String]()
        switch params {
        case 1:
            dispRate.append("star_selected.png")
            dispRate.append("star_none.png")
            dispRate.append("star_none.png")
            dispRate.append("star_none.png")
            dispRate.append("star_none.png")
            
        case 2:
            dispRate.append("star_selected.png")
            dispRate.append("star_selected.png")
            dispRate.append("star_none.png")
            dispRate.append("star_none.png")
            dispRate.append("star_none.png")
        case 3:
            dispRate.append("star_selected.png")
            dispRate.append("star_selected.png")
            dispRate.append("star_selected.png")
            dispRate.append("star_none.png")
            dispRate.append("star_none.png")
        case 4:
            dispRate.append("star_selected.png")
            dispRate.append("star_selected.png")
            dispRate.append("star_selected.png")
            dispRate.append("star_selected.png")
            dispRate.append("star_none.png")
        case 5:
            dispRate.append("star_selected.png")
            dispRate.append("star_selected.png")
            dispRate.append("star_selected.png")
            dispRate.append("star_selected.png")
            dispRate.append("star_selected.png")
        default:
            dispRate.append("star_none.png")
            dispRate.append("star_none.png")
            dispRate.append("star_none.png")
            dispRate.append("star_none.png")
            dispRate.append("star_none.png")
        }
        
        
        return dispRate
    }

    
}
