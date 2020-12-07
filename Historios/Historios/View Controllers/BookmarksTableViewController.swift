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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        persistenceController?.loadFromPersistence()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if persistenceController?.bookmarkedEvents.count == 0 {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.showAlertLabel(message: "Events that you've bookmarked will appear here.")
            }
            return 0
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        persistenceController?.bookmarkedEvents.count ?? 0
        
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
        
        let randomNumber = Int.random(in: 1...50)
        
        backgroundImage.image = UIImage(named: "image-\(randomNumber)")
        
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = #colorLiteral(red: 0.03256565871, green: 0.07966083964, blue: 0.1629170119, alpha: 1)
    }
}

extension BookmarksTableViewController {

    func showAlertLabel(message:String) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: view.bounds.size.width, height: view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 2
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Palatino", size: 24)
        messageLabel.sizeToFit()

        self.tableView.backgroundView = messageLabel
        self.tableView.separatorStyle = .none
    }
}
