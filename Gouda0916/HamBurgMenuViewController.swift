//
//  HamBurgMenuViewController.swift
//  Gouda0916
//
//  Created by Marie Park on 12/5/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class HamburgerMenuViewController: UIViewController {
    
    var options: [MenuOption] = []
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var logoutView: CustomMenuCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOptions()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(logout))
        logoutView.addGestureRecognizer(tapGR)
    }
    
    func populateOptions() {
        let home = MenuOption(label: "home", image: #imageLiteral(resourceName: "home"))
        let goal = MenuOption(label: "goal", image: #imageLiteral(resourceName: "change what youre saving goal"))
        let velocity = MenuOption(label: "velocity", image: #imageLiteral(resourceName: "velocity icon"))
        
        options = [home, goal, velocity]
    }
}

//MARK: Menu Table View setup
extension HamburgerMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "menuCell") as! MenuCell
        cell.customMenuCell.menuOption = options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return logoutView.frame.height
    }
    
    func logout() {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        NotificationCenter.default.post(name: .closeMainContainerVC, object: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch options[indexPath.row].label {
        case "home":
            NotificationCenter.default.post(name: .openMainVC, object: nil)
        case "goal":
            NotificationCenter.default.post(name: .openGoalVC, object: nil)
        case "velocity":
            print("Going to VELOCITY OH SHIT")
            NotificationCenter.default.post(name: .openVelocityVC, object: nil)
        default:
            break
        }
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

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var customMenuCell: CustomMenuCell!
    
}

struct MenuOption {
    let label: String
    let image: UIImage
}
