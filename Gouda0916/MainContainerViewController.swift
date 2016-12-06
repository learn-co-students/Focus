//
//  AppController.swift
//
//
//  Created by Marie Park on 11/17/16.
//  Copyright © 2016 Marie Park. All rights reserved.
//

import UIKit
import Firebase


final class MainContainerViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    var actingVC: UIViewController!
    
    @IBOutlet weak var menu: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotificationObservers()
        loadInitialViewController()
        menu.alpha = 0.0
    }
    
    
    
    // MARK: - Notficiation Observers
    func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .openMainVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .openGoalVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .openVelocityVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(unhideMenu), name: .unhideBar, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideMenu), name: .hideBar, object: nil)
    }
    
    //// MARK: - Loading VC's
    func loadInitialViewController() {
        let id: StoryboardID = .mainVC
        self.actingVC = self.loadViewController(withID: id)
        self.add(viewController: self.actingVC, animated: true)
    }
    
    func loadViewController(withID id: StoryboardID) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id.rawValue)
    }
}

// MARK: - Displaying VC's
extension MainContainerViewController {
    func add(viewController: UIViewController, animated: Bool = false) {
        self.addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        containerView.alpha = 0.0
    
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
        
        guard animated else { containerView.alpha = 1.0; return }
        
        UIView.transition(with: containerView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.containerView.alpha = 1.0
        }) { _ in }
    }
    
    func unhideMenu() {
        UIView.animate(withDuration: 0.3) {
            self.menu.alpha = 1.0
        }
    }
    
    func hideMenu() {
        UIView.animate(withDuration: 0.3) {
            self.menu.alpha = 0.0
        }

    }
    
    func switchViewController(with notification: Notification) {
        
        switch notification.name {
            
        case Notification.Name.openMainVC:
            switchToViewController(with: .mainVC)
            
        case Notification.Name.openGoalVC:
            switchToViewController(with: .goalVC)
            
            
        case Notification.Name.openVelocityVC:
            switchToViewController(with: .velocityVC)
            
        default:
            fatalError("\(#function) - Unable to match notficiation name.")
        }
    }
    
    private func switchToViewController(with id: StoryboardID) {
        let existingVC = actingVC
        existingVC?.willMove(toParentViewController: nil)
        actingVC = loadViewController(withID: id)
        addChildViewController(actingVC)
        add(viewController: actingVC)
        actingVC.view.alpha = 0.0
        menu.alpha = 0.0
        
        UIView.animate(withDuration: 0.8, animations: {
            self.actingVC.view.alpha = 1.0
            existingVC?.view.alpha = 0.0
        }) { success in
            existingVC?.view.removeFromSuperview()
            existingVC?.removeFromParentViewController()
            self.actingVC.didMove(toParentViewController: self)
        }
        
    }
}

