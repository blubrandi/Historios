//
//  SelectDateVC.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/9/20.
//

import UIKit

class SelectDateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var datePicker: UIPickerView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var getEventsButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var monthNumAsString: String?
    var persistenceController: PersistenceController?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
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
        
        configureViews()
        
        datePicker.dataSource = self
        datePicker.delegate = self
        
        warningLabel.isHidden = true
        
        monthLabel.text = "Select Month"
        dayLabel.text = "Select Day"
        
//        getEventsButton.isEnabled = false
        getEventsButton.isHidden = true
        
        monthLabel.isHidden = true
        dayLabel.isHidden = true
        
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
            warningLabel.text = "⚠️ \n\(selectedMonth) only has 29 days.  \nPlease select a different day."
//            getEventsButton.isEnabled = false
            getEventsButton.isHidden = true
        } else if monthsWithThirtyDaysNotAllowed.contains(selectedDay) && monthsWithThirtyDays.contains(selectedMonth) {
            warningLabel.isHidden = false
            warningLabel.text = "⚠️ \n\(selectedMonth) only has 30 days.  \nPlease select a different day."
//            getEventsButton.isEnabled = false
            getEventsButton.isHidden = true
        } else if monthLabel.text == "Select Month" {
//            getEventsButton.isEnabled = false
            getEventsButton.isHidden = true
        } else if dayLabel.text == "Select Day" {
//            getEventsButton.isEnabled = false
            getEventsButton.isHidden = true
        } else {
            warningLabel.isHidden = true
//            getEventsButton.isEnabled = true
            getEventsButton.isHidden = false
        }
        
        switch selectedMonth {
        case "January":
            monthNumAsString = "1"
        case "February":
            monthNumAsString = "2"
        case "March":
            monthNumAsString = "3"
        case "April":
            monthNumAsString = "4"
        case "May":
            monthNumAsString = "5"
        case "June":
            monthNumAsString = "6"
        case "July":
            monthNumAsString = "7"
        case "August":
            monthNumAsString = "8"
        case "September":
            monthNumAsString = "9"
        case "October":
            monthNumAsString = "10"
        case "November":
            monthNumAsString = "11"
        case "December":
            monthNumAsString = "12"
        default:
            return
        }
    }
    
    func configureViews() {
        let randomNum = Int.random(in: 1...53)
        
        backgroundImage.image = UIImage(named: "image-\(randomNum)")
        
        getEventsButton.layer.cornerRadius = 40
        getEventsButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        getEventsButton.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        getEventsButton.layer.shadowOpacity = 0.4
        getEventsButton.layer.shadowRadius = 8
        getEventsButton.layer.masksToBounds = false
        
        let datePickerTextColor = #colorLiteral(red: 0.02352941176, green: 0.07843137255, blue: 0.1921568627, alpha: 1)
        datePicker.setValue(datePickerTextColor, forKey: "textColor")
        
    }
    
    @IBAction func getEventsTapped(_ sender: Any) {
        print(selectedMonth)
        print(selectedDay)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToGetSelectedTVC" {
            if let destinationVC = segue.destination as? EventsResultsTableViewController {
                destinationVC.setMonth = monthNumAsString
                destinationVC.setDay = selectedDay
                destinationVC.monthForTitle = monthLabel.text
                
                destinationVC.persistenceController = persistenceController
            }
        }
    }
    
}


