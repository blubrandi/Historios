//
//  TodayTVC.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/7/20.
//

import UIKit

class EventsResultsTableViewController: UITableViewController {
    
    var apiController = APIController()
    @IBOutlet weak var imageBackground: UIImageView!
    
    var setMonth: String?
    var setDay: String?
    var persistenceController: PersistenceController?
    var monthForTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackgroundImage()
        
        apiController.getSelectedEvents(month: setMonth!, day: setDay!) {[weak self] (error) in
            DispatchQueue.main.async {

                self?.tableView.reloadData()
            }
        }
        configureViews()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return apiController.events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        
        let event = apiController.events[indexPath.row]
        
        cell.textLabel?.text = "\(event.year ?? "Year Unknown")"
        cell.detailTextLabel?.text = event.text

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToEventDetailVC" {
            
            if let indexPath = tableView.indexPathForSelectedRow,
               let destinationVC = segue.destination as? EventDetailViewController {
                destinationVC.event = apiController.events[indexPath.row]
                destinationVC.eventDate = apiController.date
                destinationVC.persistenceController = persistenceController
                
            }
        }
    }
    
    func configureViews() {
        self.title = "\(monthForTitle!) \(setDay!)"
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = #colorLiteral(red: 0.03256565871, green: 0.07966083964, blue: 0.1629170119, alpha: 1)
    }
    
    func configureBackgroundImage() {
        let randomNum = Int.random(in: 1...50)
        imageBackground.image = UIImage(named: "image-\(randomNum)") 
    }
    
}
