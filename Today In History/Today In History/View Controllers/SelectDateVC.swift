//
//  SelectDateVC.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/9/20.
//

import UIKit

class SelectDateVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var datePicker: UIPickerView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var getEventsButton: UIButton!
    
    let months: [String] = ["Select Month", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    let days: [String] = ["Select Day", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]
    
    let monthsWithTwentyNineDays: [String] = ["February"]
    let monthsWithThirtyDays: [String] = ["April", "June", "September", "November"]
    let monthsWithTwentyNineDaysNotAllowed: [String] = ["30", "31"]
    let monthsWithThirtyDaysNotAllowed: [String] = ["31"]
    
    var selectedMonth: String = ""
    var selectedDay: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.dataSource = self
        datePicker.delegate = self
        
        warningLabel.isHidden = true
        
        monthLabel.text = "Select Month"
        dayLabel.text = "Select Day"
        
        getEventsButton.isEnabled = false
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return months.count
        } else {
            return days.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return months[row]
        } else {
            return days[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            selectedMonth = months[row]
            monthLabel.text = selectedMonth
        } else if component == 1 {
            selectedDay = days[row]
            dayLabel.text = selectedDay
        }
        
        if monthsWithTwentyNineDaysNotAllowed.contains(selectedDay) && monthsWithTwentyNineDays.contains(selectedMonth) {
            warningLabel.isHidden = false
            warningLabel.text = "‼️ \(selectedMonth) only has 29 days.  Please select a different day."
            getEventsButton.isEnabled = false
        } else if monthsWithThirtyDaysNotAllowed.contains(selectedDay) && monthsWithThirtyDays.contains(selectedMonth) {
            warningLabel.isHidden = false
            warningLabel.text = "‼️ \(selectedMonth) only has 30 days.  Please select a different day."
            getEventsButton.isEnabled = false
        } else if monthLabel.text == "Select Month" {
            getEventsButton.isEnabled = false
        } else if dayLabel.text == "Select Day" {
            getEventsButton.isEnabled = false
        } else {
            warningLabel.isHidden = true
            getEventsButton.isEnabled = true
        }
    }
    
    @IBAction func getEventsTapped(_ sender: Any) {
        print(selectedMonth)
        print(selectedDay)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToGetSelectedTVC" {
            if let destinationVC = segue.destination as? GetSelectedTVC {
                destinationVC.month = selectedMonth
                destinationVC.day = selectedDay
            }
        }
    }
    
}

