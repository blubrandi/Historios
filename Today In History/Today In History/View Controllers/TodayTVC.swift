//
//  TodayTVC.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/7/20.
//

import UIKit

class TodayTVC: UITableViewController {
    
    let apiController = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("View Did Load...")
        
        configureTitle()

        apiController.getEventsForToday { (error) in
            DispatchQueue.main.async {

                self.tableView.reloadData()

            }
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return apiController.events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        
        let event = apiController.events[indexPath.row]
        
        cell.textLabel?.text = "Year: \(event.year)"
//        cell.textLabel?.textColor = #colorLiteral(red: 0.1541212201, green: 0.137329489, blue: 0.1172864512, alpha: 1)
        
        cell.detailTextLabel?.text = event.text
//        cell.detailTextLabel?.textColor = #colorLiteral(red: 0.1541212201, green: 0.137329489, blue: 0.1172864512, alpha: 1)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToEventDetailVC" {
            
            if let indexPath = tableView.indexPathForSelectedRow,
               let destinationVC = segue.destination as? EventDetailVC {
                destinationVC.event = apiController.events[indexPath.row]
                destinationVC.apiController = apiController
                
            }
        }
    }
    
    func configureTitle() {
        let date = Date()
        let monthString = date.month
        let dayString = date.day
        
        self.title = "\(monthString) \(dayString)"

    }
}
