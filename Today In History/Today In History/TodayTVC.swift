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

        apiController.getEvents { (error) in
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
        
        cell.textLabel?.text = event.year
        cell.detailTextLabel?.text = event.text

        return cell
    }
    
    func configureTitle() {
        let date = Date()
        let monthString = date.month
        let dayString = date.day
        
        self.title = "\(monthString) \(dayString)"

    }
}

extension Date {
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }
}
