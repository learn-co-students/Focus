//
//  LogViewController.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/14/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {
//    var masterController: SWRevealViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        masterController = revealViewController()
        
//        guard let mcVC = masterController else { return }
        //view.addGestureRecognizer(mcVC.panGestureRecognizer())
//        view.addGestureRecognizer(mcVC.panGestureRecognizer())
    }
    
    
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
