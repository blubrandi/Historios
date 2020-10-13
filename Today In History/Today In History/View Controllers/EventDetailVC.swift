//
//  EventDetailVC.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/7/20.
//

import UIKit
import SafariServices

class EventDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    
    var apiController: APIController?
    var persistenceController: PersistenceController?
    var event: Event?
    
    @IBOutlet weak var linksTableView: UITableView!
    @IBOutlet weak var eventTextLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let links = event?.links
        print(links?.count)
        
        return links?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LinkCell")
        let link = event?.links[indexPath.row]
        
        cell?.textLabel?.text = link?.title
        cell?.textLabel?.lineBreakMode = .byWordWrapping
        cell?.textLabel?.numberOfLines = 15
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = event?.links[indexPath.row]
        
        guard let url = link?.url else { return }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
    func configureViews() {
        self.title = "Today in year \(event!.year)"
        
        eventTextLabel.text = event?.text
        
        linksTableView.tableFooterView = UIView()
        linksTableView.backgroundColor = .white
        
//        guard let bookmarkedEventsToCheck = persistenceController?.bookmarkedEvents else { return }
        
//        for bookmarkedEvent in bookmarkedEventsToCheck {
//            if bookmarkedEvent.text == event?.text {
//                bookmarkButton.image(for: .normal) = ✓
//
//            }
//        }
    }
    
    @IBAction func bookmarkButtonTapped(_ sender: Any) {
        
        guard let event = event else { return }
        guard let bookmarkLinks = event.links as? [BookmarkedEventLink] else { return }
        
        persistenceController?.createBookmarkedEvent(withText: event.text, withYear: event.year, withLinks: bookmarkLinks, isBookmarked: true)
        
        print(persistenceController?.bookmarkedEvents.count)
    }
    
}
