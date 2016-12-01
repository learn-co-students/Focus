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
        NotificationCenter.default.post(name: .openVelocityVC, object: nil)}
    
    @IBAction func goalPressed(_ sender: Any) {
        NotificationCenter.default.post(name: .openGoalVC, object: nil)}
    
    @IBAction func homePressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: .openMainVC, object: nil)}
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

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
