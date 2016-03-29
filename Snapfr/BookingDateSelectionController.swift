//
//  File.swift
//  Snapfr
//
//  Created by Rommel Suarez on 26/10/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation
class BookingDateSelectionController: UITableViewController,CVCalendarViewDelegate , CVCalendarMenuViewDelegate{
   
    
   
    
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    
    @IBOutlet weak var calendarView: CVCalendarView!
    
    var service = Service()
    var unWindsegueVal = String()
    
    
    
    override func viewDidLoad() {
        monthLabel.text = calendarView.presentedDate.monthYearDescription
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
        monthLabel.text = calendarView.presentedDate.monthYearDescription
        
        
        
        
    }
    


    @IBAction func nextMonthOnClick(sender: AnyObject) {
      self.calendarView.loadNextView()
      monthLabel.text = calendarView.presentedDate.monthYearDescription
        
        
    }
    
    
    
    @IBAction func previousMonthOnClick(sender: AnyObject) {
        self.calendarView.loadPreviousView()
        
    
    }
    @IBAction func setBookingDateOnClick(sender: AnyObject) {
        
        performSegueWithIdentifier(unWindsegueVal, sender: nil)
        
        
    }
    /// Required method to implement!
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
        
    func shouldAnimateResizing() -> Bool {
        return true // Default value is true
    }
    
    
    func didSelectDayView(dayView: DayView) {
        print("\(calendarView.presentedDate.commonDescription) is selected!")
        
    }
    
    
    func presentedDateUpdated(date: Date) {
       monthLabel.text = calendarView.presentedDate.monthYearDescription
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwindBookServiceSegue" {
            
              let bookingServiceController = segue.destinationViewController as! BookServiceController
              bookingServiceController.bookingDateLabel.text = calendarView.presentedDate.monthDayYearDescription
        }else if segue.identifier == "unwindModifyBooking" {
            
            let modifyBookingController = segue.destinationViewController as! ModifyBookingController
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = "hh:mm a"
            
            modifyBookingController.bookingDate.text =  calendarView.presentedDate.monthDayYearDescription

        }

    }



}
