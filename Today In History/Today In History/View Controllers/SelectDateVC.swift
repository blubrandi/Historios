//
//  SelectDateVC.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/8/20.
//

import UIKit

class SelectDateVC: UIViewController {

    @IBOutlet weak var todaysDateLabel: UILabel!
    
    let today = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        todaysDateLabel.text = today.dateText
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
