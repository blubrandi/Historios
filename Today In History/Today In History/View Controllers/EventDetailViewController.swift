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
        let links = event?.links
//        print(links?.count)
        
        return links?.count ?? 0
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
    
    func configureViews() {
        
//        self.navigationController?.set = year
        guard let event = event else { return }
        guard let eventDate = eventDate else { return }
        guard let eventText = event.text else { return }
        guard let eventYear = event.year else { return }
        let yearAndText = "\(eventDate), \(eventYear) \n\n\(eventText)"
        
        bookmarkEventButton.layer.cornerRadius = 40
        selectedEventTextView.text = yearAndText
        
        selectedEventLinksTableView.tableFooterView = UIView()
        selectedEventLinksTableView.backgroundColor = #colorLiteral(red: 0.03256565871, green: 0.07966083964, blue: 0.1629170119, alpha: 1)
    }
    
    @IBAction func bookmarkButtonTapped(_ sender: Any) {
        print("tapped")
        
        guard let event = event else { return }

        persistenceController?.createBookmarkedEvent(withDate: eventDate!, withText: event.text!, withYear: event.year!, withLinks: event.links!, isBookmarked: true)
        
        bookmarkEventButton.setTitle("Bookmark Saved!", for: .normal)
        bookmarkEventButton.setTitleColor(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), for: .normal)
        bookmarkEventButton.isEnabled = false
        
    }
    
}
