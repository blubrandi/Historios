//
//  StartingVC.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/8/20.
//

import UIKit

class StartingVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    
    let todaysDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        
    }
    
    func configureViews() {
        
        dateLabel.text = todaysDate.dateText
        
    }



}
