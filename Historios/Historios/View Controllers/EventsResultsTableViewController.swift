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
    var errorEvent: Event?
    var filteredEvents: [Event]?

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
        cell.detailTextLabel?.text = "\(event.text ?? "Info Unknown")"

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
        
        self.tableView.backgroundView = UIView()
        self.tableView.backgroundView!.backgroundColor = .white
        
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    }
    
    func configureBackgroundImage() {
        let randomNum = Int.random(in: 1...53)
        imageBackground.image = UIImage(named: "image-\(randomNum)") 
    }
    
}
