//
//  EventDetailVC.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/7/20.
//

import UIKit

class EventDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
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
        
        return cell!
    }
    
    func configureViews() {
        eventTextLabel.text = event?.text
        linksTableView.tableFooterView = UIView()
    }
}
