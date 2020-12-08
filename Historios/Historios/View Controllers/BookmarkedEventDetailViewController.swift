//
//  BookmarkedEventDetailViewController.swift
//  Today In History
//
//  Created by Brandi Taylor on 12/2/20.
//

import UIKit
import SafariServices
import LinkPresentation

class BookmarkedEventDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    

    @IBOutlet weak var bookmarkEventTableView: UITableView!
    @IBOutlet weak var bookmarkTextView: UITextView!
    @IBOutlet weak var removeBookmarkButton: UIButton!
    
    var persistenceController: PersistenceController?
    var bookmark: BookmarkedEvent?
//    var urlOfImageToShare: URL?
    
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
        
//        let img = UIImage(named: "shareIcon")!

        let shareText = "Historios: \nOn \(bookmarkDate), \(bookmarkYear) \n\(bookmarkText)"
        let sharedEvent = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        sharedEvent.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
        present(sharedEvent, animated: true, completion: nil)
        
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
        bookmarkEventTableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        removeBookmarkButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        removeBookmarkButton.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        removeBookmarkButton.layer.shadowOpacity = 0.4
        removeBookmarkButton.layer.shadowRadius = 8
        removeBookmarkButton.layer.masksToBounds = false
    }
}

//extension BookmarksTableViewController: UIActivityItemSource {
//
//    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
//        return UIImage()
//    }
//
//    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
//        return urlOfImageToShare
//    }
//
//    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
//        let metadata = LPLinkMetadata()
//
//        metadata.title = "Historios"
//        metadata.originalURL = urlOfImageToShare
//        metadata.url = urlOfImageToShare
//        metadata.imageProvider = NSItemProvider.init(contentsOf: urlOfImageToShare)
//        metadata.iconProvider = NSItemProvider.init(contentsOf: urlOfImageToShare)
//    }
//}

