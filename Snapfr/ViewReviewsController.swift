//
//  ViewReviewsController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 22/11/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class ViewReviewsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var profile = Profile()
    let reviewService = ReviewService(newReviewDao: ReviewDao())
    var reviews = [Review]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    
    
    @IBAction func segmentControllerOnChange(sender: AnyObject) {
        
        if segmentController.selectedSegmentIndex == 0 {
            
            reviewService.getReviews(profile,isCustomer: true) { (response, error) -> () in
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.reviews = response
                    
                    self.tableView.reloadData()
                    
                }
                
            }

            
        }else {
            
            reviewService.getReviews(profile,isCustomer: false) { (response, error) -> () in
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.reviews = response
                    
                    self.tableView.reloadData()
                    
                }
                
            }

            
        }
    }
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return reviews.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ReviewsCustomCell
        
           let review = reviews[indexPath.row]
            
            
            cell.reviewComment.text = review.comments
            cell.reviewerName.text = review.ratingFrom.name
            cell.reviewerAvatar.imageFromUrl(review.ratingFrom.avatar)
            
            
            
            switch  review.rating  {
                
            case 5 :
                cell.oneStarRating.image = UIImage(named: "star-con-selected.png")
                cell.twoStarRating.image = UIImage(named: "star-con-selected.png")
                cell.threeStarRating.image = UIImage(named: "star-con-selected.png")
                cell.fourStarRating.image = UIImage(named: "star-con-selected.png")
                cell.fiveStarRating.image = UIImage(named: "star-con-selected.png")
            case 4 :
                cell.oneStarRating.image = UIImage(named: "star-con-selected.png")
                cell.twoStarRating.image = UIImage(named: "star-con-selected.png")
                cell.threeStarRating.image = UIImage(named: "star-con-selected.png")
                cell.fourStarRating.image = UIImage(named: "star-con-selected.png")
                cell.fiveStarRating.image = UIImage(named: "star_none.png")
            case 3 :
                cell.oneStarRating.image = UIImage(named: "star-con-selected.png")
                cell.twoStarRating.image = UIImage(named: "star-con-selected.png")
                cell.threeStarRating.image = UIImage(named: "star-con-selected.png")
                cell.fourStarRating.image = UIImage(named: "star_none.png")
                cell.fiveStarRating.image = UIImage(named: "star_none.png")
            case 2 :
                cell.oneStarRating.image = UIImage(named: "star-con-selected.png")
                cell.twoStarRating.image = UIImage(named: "star-con-selected.png")
                cell.threeStarRating.image = UIImage(named: "star_none.png")
                cell.fourStarRating.image = UIImage(named: "star_none.png")
                cell.fiveStarRating.image = UIImage(named: "star_none.png")
            case 1:
                cell.oneStarRating.image = UIImage(named: "star-con-selected.png")
                cell.twoStarRating.image = UIImage(named: "star_none.png")
                cell.threeStarRating.image = UIImage(named: "star_none.png")
                cell.fourStarRating.image = UIImage(named: "star_none.png")
                cell.fiveStarRating.image = UIImage(named: "star_none.png")
            default :
                
                cell.oneStarRating.image = UIImage(named: "star_none.png")
                cell.twoStarRating.image = UIImage(named: "star_none.png")
                cell.threeStarRating.image = UIImage(named: "star_none.png")
                cell.fourStarRating.image = UIImage(named: "star_none.png")
                cell.fiveStarRating.image = UIImage(named: "star_none.png")
                
            }

            
        
        
        
       
        
        
       /*
        
        cell.oneStarRating.image = resizeImage(cell.oneStarRating.image!,newHeight:1, newWidth: 20)
        cell.twoStarRating.image = resizeImage(cell.twoStarRating.image!,newHeight:1, newWidth: 20)
        cell.threeStarRating.image = resizeImage(cell.threeStarRating.image!,newHeight:1, newWidth: 20)
        cell.fourStarRating.image = resizeImage(cell.fourStarRating.image!,newHeight:1, newWidth: 20)
        cell.fiveStarRating.image = resizeImage(cell.fiveStarRating.image!,newHeight:11, newWidth: 20)*/
        
        return cell
        
    }
    
    
    func resizeImage(image: UIImage,newHeight: CGFloat, newWidth: CGFloat) -> UIImage {
        
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

    

}
