//
//  InfoViewController.swift
//  Today In History
//
//  Created by Brandi Taylor on 12/2/20.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var copyrightLabel: UILabel!
    var currentYear = Calendar.current.component(.year, from: Date())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }
    
    func configureViews() {
        copyrightLabel.text = "© \(currentYear) Squee, LLC. All Rights Reserved."
    }

}
