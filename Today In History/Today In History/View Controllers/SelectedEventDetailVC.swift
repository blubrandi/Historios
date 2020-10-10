//
//  SelectedEventViewController.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/10/20.
//

import UIKit
import SafariServices

class SelectedEventDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    
    var apiController: APIController?
    var event: Event?
    
    @IBOutlet weak var selectedEventLabel: UILabel!
    @IBOutlet weak var selectedEventLinksTableView: UITableView!
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedEventLinkCell")
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
//        self.title = " in year \(event!.year)"
        
        selectedEventLabel.text = event?.text
        
        selectedEventLinksTableView.tableFooterView = UIView()
        selectedEventLabel.backgroundColor = .white
    }
    
}
