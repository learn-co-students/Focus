//
//  LogViewController.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/14/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {
    
    @IBAction func MenuBtnPressed(_ sender: Any) {
        NotificationCenter.default.post(name: .unhideBar, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
  
//    @IBAction func backButtonClicked(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
    
}
