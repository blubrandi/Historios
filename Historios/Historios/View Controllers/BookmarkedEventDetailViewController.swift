//
//  BookmarkedEventDetailViewController.swift
//  Today In History
//
//  Created by Brandi Taylor on 12/2/20.
//

import UIKit
import SafariServices

class BookmarkedEventDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    

    @IBOutlet weak var bookmarkEventTableView: UITableView!
    @IBOutlet weak var bookmarkTextView: UITextView!
    @IBOutlet weak var removeBookmarkButton: UIButton!
    
    var persistenceController: PersistenceController?
    var bookmark: BookmarkedEvent?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if bookmark?.isBookmarked == false {
            persistenceController?.removeBookmarkedEvent(bookmarkedEvent: bookmark!)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let links = bookmark?.links
        
        return links?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkEventLinkCell")
        let link = bookmark?.links[indexPath.row]
        
        cell?.textLabel?.text = link?.title
        cell?.textLabel?.lineBreakMode = .byWordWrapping
        cell?.textLabel?.numberOfLines = 15
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = bookmark?.links[indexPath.row]
        
        guard let url = link?.url else { return }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
    @IBAction func removeBookmarkTapped(_ sender: Any) {
        
        if bookmark?.isBookmarked == true {
            removeBookmarkButton.setTitle("Bookmark Removed.  Undo?", for: .normal)
            removeBookmarkButton.setTitleColor(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), for: .normal)
            bookmark?.isBookmarked = false
        } else {
            removeBookmarkButton.setTitle("Remove Bookmark", for: .normal)
            removeBookmarkButton.setTitleColor(#colorLiteral(red: 0.03256565871, green: 0.07966083964, blue: 0.1629170119, alpha: 1), for: .normal)
            bookmark?.isBookmarked = true
        }
        
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        
        guard let bookmarkDate = bookmark?.date,
              let bookmarkYear = bookmark?.year,
              let bookmarkText = bookmark?.text
        else { return }
        
        let shareEventItems: [Any] = ["Today In History", "\nOn This Day: \(bookmarkDate), \(bookmarkYear) \n\(bookmarkText)\n", "https://rb.gy/ciq6si", "\nShared via the This Day In History app on the iOS App Store"]
        
        let sharedEvent = UIActivityViewController(activityItems: shareEventItems, applicationActivities: nil)
        
        sharedEvent.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
        present(sharedEvent, animated: true, completion: nil)
        
            // Anything you want to exclude
        sharedEvent.excludedActivityTypes = [
                UIActivity.ActivityType.postToFacebook,
            ]
    }
    
    func configureViews() {
        
        guard let bookmarkText = bookmark?.text,
              let bookmarkDate = bookmark?.date,
              let bookmarkYear = bookmark?.year
                else { return }
        
        
        bookmarkTextView.text = "\(bookmarkDate), \(bookmarkYear) \n\n\(bookmarkText)"
        removeBookmarkButton.layer.cornerRadius = 40
        
        bookmarkEventTableView.tableFooterView = UIView()
        bookmarkEventTableView.backgroundColor = #colorLiteral(red: 0.03256565871, green: 0.07966083964, blue: 0.1629170119, alpha: 1)
    }
}


//// Setting description
//let firstActivityItem = "On \(bookmark!.date), \(bookmark!.year) \(bookmark!.text) \nShared via This Day In History.\nhttps://google.com/"
//
//    // Setting url
////            let secondActivityItem : NSURL = NSURL(string: "https://google.com/")!
//
//    // If you want to use an image
//    let image : UIImage = UIImage(named: "AppIcon")!
//    let activityViewController : UIActivityViewController = UIActivityViewController(
//        activityItems: [firstActivityItem, image], applicationActivities: nil)
//
//    // This lines is for the popover you need to show in iPad
//    activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
//
//    // This line remove the arrow of the popover to show in iPad
//    activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
//    activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
//
//    // Pre-configuring activity items
//    activityViewController.activityItemsConfiguration = [
//    UIActivity.ActivityType.message
//    ] as? UIActivityItemsConfigurationReading
//

//
//    activityViewController.isModalInPresentation = true
//    self.present(activityViewController, animated: true, completion: nil)
