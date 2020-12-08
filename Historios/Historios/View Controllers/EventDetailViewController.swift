//
//  SelectedEventViewController.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/10/20.
//

import UIKit
import SafariServices

class EventDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    
    var apiController: APIController?
    var event: Event?
    var eventDate: String?
    var yearAndText: String?
    
    @IBOutlet weak var bookmarkEventButton: UIButton!
    @IBOutlet weak var selectedEventTextView: UITextView!
    @IBOutlet weak var selectedEventLinksTableView: UITableView!
    
    var persistenceController: PersistenceController?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let links = event?.links else { return 0 }

        return links.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedEventLinkCell")
            let link = event?.links![indexPath.row]
            
            cell?.textLabel?.text = link?.title
            cell?.textLabel?.lineBreakMode = .byWordWrapping
            cell?.textLabel?.numberOfLines = 15
            
            return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = event?.links![indexPath.row]
        
        guard let url = link?.url else { return }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
    @IBAction func bookmarkButtonTapped(_ sender: Any) {
        print("tapped")
        
        guard let event = event else { return }
        
        persistenceController?.createBookmarkedEvent(withDate: eventDate!,
                                                     withText: event.text!,
                                                     withYear: event.year!,
                                                     withLinks: event.links!,
                                                     isBookmarked: true)
        
        bookmarkEventButton.setTitle("Bookmark Saved!", for: .normal)
        bookmarkEventButton.setTitleColor(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), for: .normal)
        bookmarkEventButton.isEnabled = false
        
    }
    
    func configureViews() {
        
        guard let event = event else { return }
        guard let eventDate = eventDate else { return }
        guard let eventText = event.text else { return }
        guard let eventYear = event.year else { return }
        yearAndText = "\(eventDate), \(eventYear) \n\n\(eventText)"
        
        bookmarkEventButton.layer.cornerRadius = 40
        selectedEventTextView.text = yearAndText!
        
        selectedEventLinksTableView.tableFooterView = UIView()
        selectedEventLinksTableView.backgroundColor = .white
        
        bookmarkEventButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        bookmarkEventButton.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        bookmarkEventButton.layer.shadowOpacity = 0.4
        bookmarkEventButton.layer.shadowRadius = 8
        bookmarkEventButton.layer.masksToBounds = false
        
    }
    
}
