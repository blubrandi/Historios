//
//  GetSelectedTVC.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/10/20.
//

import UIKit

class GetSelectedTVC: UITableViewController {
    
    let apiController = APIController()
    var month: String = ""
    var day: String = ""
    var monthAsNumString: String = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "\(month) \(day)"
        print(month)
        print(day)
            
            switch month {
            case "January":
                monthAsNumString = "1"
            case "February":
                monthAsNumString = "2"
            case "March":
                monthAsNumString = "3"
            case "April":
                monthAsNumString = "4"
            case "May":
                monthAsNumString = "5"
            case "June":
                monthAsNumString = "6"
            case "July":
                monthAsNumString = "7"
            case "August":
                monthAsNumString = "8"
            case "September":
                monthAsNumString = "9"
            case "October":
                monthAsNumString = "10"
            case "November":
                monthAsNumString = "11"
            case "December":
                monthAsNumString = "12"
            default:
                print("ERRRRRRROR")
            }
        
        print("From VDL: ", monthAsNumString)
        apiController.getSelectedEvents(month: monthAsNumString, day: day) { (error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiController.events.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedEventCell", for: indexPath)

        let event = apiController.events[indexPath.row]
        
        cell.textLabel?.text = "Year: \(event.year)"
        cell.detailTextLabel?.text = event.text

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSelectedEventDetailVC" {
            
            if let indexPath = tableView.indexPathForSelectedRow,
               let destinationVC = segue.destination as? SelectedEventDetailVC {
                destinationVC.event = apiController.events[indexPath.row]
                destinationVC.apiController = apiController
                
            }
        }
    }
    
}
