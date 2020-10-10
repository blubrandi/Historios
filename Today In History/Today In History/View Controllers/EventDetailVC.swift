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
    var event: Event?
    
    @IBOutlet weak var linksTableView: UITableView!
    @IBOutlet weak var eventTextLabel: UILabel!
    
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
        cell?.textLabel?.numberOfLines = 5
//        cell?.textLabel?.textColor = #colorLiteral(red: 0.2127646208, green: 0.1895925999, blue: 0.1618997753, alpha: 1)
        
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
//        eventTextLabel.textColor = #colorLiteral(red: 0.2127646208, green: 0.1895925999, blue: 0.1618997753, alpha: 1)
        
        linksTableView.tableFooterView = UIView()
        linksTableView.backgroundColor = .white
    }
    
}
