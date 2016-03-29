//
//  SearchPhotographerController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 5/9/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import Foundation

import  UIKit

class SearchPhotographerController: UITableViewController, UISearchBarDelegate {
    
   
    @IBOutlet weak var seachBar: UISearchBar!
    
    
    @IBOutlet weak var openMenu: UIBarButtonItem!
    var searchResults = [Profile()]
    var profile = Profile()
    

    
    override func viewDidLoad() {
        
        openMenu.target=self.revealViewController()
        openMenu.action=Selector("revealToggle:")
        

        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        profile=searchResults[indexPath.row]
        
        performSegueWithIdentifier("showProfileSegue", sender: self)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.searchResults.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        
        
        let searchCell = tableView.dequeueReusableCellWithIdentifier("searchCell", forIndexPath: indexPath) 
        
        
       
            
       let photographer = self.searchResults[indexPath.row]
        searchCell.textLabel?.text = photographer.name
        
        print(photographer.name)
    
        
        return searchCell;
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)  {
        
        let userService = UserService(newProfileDao: ProfileDao(),newUserDao: UserDao())
        
        
        userService.getProfileByName(searchText) { (data, responseMessage) -> () in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                CommonUtil.processErrorUIResponseMsg("Search services", responseMessage: responseMessage)
                
                if responseMessage.code == ResponseStatus.Success {
                    if data != nil {
                        self.searchResults = data
                        self.tableView.reloadData()
                    }
                }
                
               
            }

           
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showProfileSegue" {
           let viewProfileController = segue.destinationViewController as! ViewProfileController
            
            viewProfileController.profile = self.profile
        }
    }
    
}