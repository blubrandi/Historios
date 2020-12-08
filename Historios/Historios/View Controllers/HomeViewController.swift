//
//  HomeVC.swift
//  Today In History
//
//  Created by Brandi Taylor on 12/1/20.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var todaysEventsButton: UIButton!
    @IBOutlet weak var selectDateButton: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    let persistenceController = PersistenceController()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        configureBackgroundImg()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
//    func configureBackgroundImg() {
//
//        let randomNumber = Int.random(in: 1...50)
//
//        homeBackgroundImage.image = UIImage(named: "image-\(randomNumber)")
//    }
    
    func configureButtons() {
        todaysEventsButton.layer.cornerRadius = 40
        selectDateButton.layer.cornerRadius = 40
        bookmarkButton.layer.cornerRadius = 40
        
        todaysEventsButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        todaysEventsButton.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        todaysEventsButton.layer.shadowOpacity = 0.4
        todaysEventsButton.layer.shadowRadius = 8
        todaysEventsButton.layer.masksToBounds = false
        
        selectDateButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        selectDateButton.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        selectDateButton.layer.shadowOpacity = 0.4
        selectDateButton.layer.shadowRadius = 8
        selectDateButton.layer.masksToBounds = false
        
        bookmarkButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        bookmarkButton.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        bookmarkButton.layer.shadowOpacity = 0.4
        bookmarkButton.layer.shadowRadius = 8
        bookmarkButton.layer.masksToBounds = false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GetTodaysEventsSegue" {
            if let destinationVC = segue.destination as? EventsResultsTableViewController {
                
                let date = Date()
                let monthString = date.monthNumberAsString
                let dayString = date.day
                
                destinationVC.setMonth = monthString
                destinationVC.setDay = dayString
                
                destinationVC.persistenceController = persistenceController
                destinationVC.monthForTitle = date.month
                
            }
        }
        if segue.identifier == "ToSelectDateSegue" {
            if let destinationVC = segue.destination as? SelectDateViewController {
                destinationVC.persistenceController = persistenceController
            }
        }
        if segue.identifier == "ToBookmarksSegue" {
            if let destinationVC = segue.destination as? BookmarksTableViewController {
                destinationVC.persistenceController = persistenceController
            }
        }
    }
}


