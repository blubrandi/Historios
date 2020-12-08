//
//  StarredEventTVC.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/10/20.
//

import UIKit

class BookmarksTableViewController: UITableViewController {
    
    var persistenceController: PersistenceController?
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        persistenceController?.loadFromPersistence()
        tableView.reloadData()
        
        if persistenceController?.bookmarkedEvents.count == 0 {
            showAlertLabel(message: "Bookmarked events \nwill appear here.")
        } else {
            showAlertLabel(message: "")
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return persistenceController?.bookmarkedEvents.count ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkCell", for: indexPath)
        
        let bookmarkedEvent = persistenceController?.bookmarkedEvents[indexPath.row]
        let eventDate = bookmarkedEvent?.date
        let eventYear = bookmarkedEvent?.year
        
        cell.textLabel?.text = "\(eventDate!), \(eventYear!)"
        cell.detailTextLabel?.text = bookmarkedEvent?.text
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToBookmarkedEventDetailSegue" {
            
            if let indexPath = tableView.indexPathForSelectedRow,
               let destinationVC = segue.destination as? BookmarkedEventDetailViewController {
                destinationVC.bookmark = persistenceController?.bookmarkedEvents[indexPath.row]
                
                destinationVC.persistenceController = persistenceController
            }
        }
    }
    
    func configureViews() {
        
        let randomNumber = Int.random(in: 1...53)
        
        backgroundImage.image = UIImage(named: "image-\(randomNumber)")

        tableView.tableFooterView = UIView()
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}

extension BookmarksTableViewController {

    func showAlertLabel(message:String) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: view.bounds.size.width, height: view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = #colorLiteral(red: 0.02352941176, green: 0.07843137255, blue: 0.1921568627, alpha: 1)
        messageLabel.numberOfLines = 2
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Palatino", size: 24)
        messageLabel.sizeToFit()

        self.tableView.backgroundView = messageLabel
        self.tableView.separatorStyle = .none
    }
}
