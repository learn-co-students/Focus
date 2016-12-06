//
//  HamburgerMenuViewController.swift
//  Gouda0916
//
//  Created by Marie Park on 11/30/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class HamburgerMenuViewController: UIViewController {
    
    let testArray = ["home", "goal", "Velocity", "notificiations", "logout"]
    
    @IBAction func velocityPressed(_ sender: Any) {
        NotificationCenter.default.post(name: .openVelocityVC, object: nil)}
    
    @IBAction func goalPressed(_ sender: Any) {
        NotificationCenter.default.post(name: .openGoalVC, object: nil)}
    
    @IBAction func homePressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: .openMainVC, object: nil)}
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HamburgerMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
}

//Dismiss view controller when option selected
extension HamburgerMenuViewController {
    
    func add(viewController: UIViewController, animated: Bool = false) {
        self.addChildViewController(viewController)
       self.view.alpha = 0.0
        viewController.didMove(toParentViewController: self)
        
        guard animated else { self.view.alpha = 1.0; return }
        
        UIView.transition(with: self.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.view.alpha = 1.0
        }) { _ in }
    }
}
