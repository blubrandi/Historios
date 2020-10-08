//
//  LinkDetailViewController.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/8/20.
//

import UIKit
import SafariServices

class SafariViewController: UIViewController, SFSafariViewControllerDelegate {
    
//    var apiController: APIController?
//    var event: Event?
//    var link: Link?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        safariVC.delegate = self
    }
    
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
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
