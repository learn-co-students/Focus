//
//  MainViewController.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/14/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class MainViewController: UIViewController {
    
    let store = DataStore.sharedInstance
    
    let rootRef = "https://gouda0916-4bb79.firebaseio.com/"
//    var masterController: SWRevealViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     navigationController?.navigationBar.isHidden = true
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        masterController = revealViewController()
        
//        guard let mcVC = masterController else { return }
//        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        //view.addGestureRecognizer(mcVC.panGestureRecognizer())
    }
}


