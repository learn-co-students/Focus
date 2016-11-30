//
//  HamburgerMenuViewController.swift
//  Gouda0916
//
//  Created by Marie Park on 11/30/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class HamburgerMenuViewController: UIViewController {
    @IBAction func velocityPressed(_ sender: Any) {
        NotificationCenter.default.post(name: .openVelocityVC, object: nil)
    }
    
    @IBAction func goalPressed(_ sender: Any) {
        NotificationCenter.default.post(name: .openGoalVC, object: nil)
    }
    
    @IBAction func homePressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: .openMainVC, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
