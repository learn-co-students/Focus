//
//  LogViewController.swift
//  Gouda0916
//
//  Created by Michael Young on 11/14/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {
    
    let store = DataStore.sharedInstance
    
    // TODO: Fix Caplitalization
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var WeeklyView: WeeklyGraphView!
    @IBOutlet weak var MonthlyView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var maskView: UIView!
    
    @IBOutlet weak var velocityScoreView: VelocityScoreView!
    
    
    let weeklyGraphView = WeeklyGraphView()
    
    let itemsPerRow: CGFloat = 7
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
    
    var isWeeklyViewShowing = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViewShadow()
        navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func MenuButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: .unhideBar, object: nil)
    }
    
    func updateViewShadow() {
        headerView.layer.masksToBounds = false
        headerView.layer.shadowColor = UIColor.themeBlackColor.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        headerView.layer.shadowRadius = 3
        headerView.layer.shadowOpacity = 0.5
        
        WeeklyView.layer.masksToBounds = false
        WeeklyView.layer.shadowColor = UIColor.themeBlackColor.cgColor
        WeeklyView.layer.shadowOffset = CGSize(width: 0, height: -3)
        WeeklyView.layer.shadowRadius = 3
        WeeklyView.layer.shadowOpacity = 0.5
    }
    
    
    // Change sender tag from access to title
    @IBAction func dailyScoreButtonTouched(_ sender: UIButton) {
        
        self.WeeklyView.setNeedsDisplay()
        self.store.graphPoints = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        let buttonTapped = sender.accessibilityLabel
        if let unwrappedButtonTapped = buttonTapped {
            velocityScoreViewTransition(with: unwrappedButtonTapped)
            
        }
    }
    
    @IBAction func weekOneScoreTouched(_ sender: Any) {
        print("week one touched")
        
        self.WeeklyView.setNeedsDisplay()
        // Test Data
        
        self.store.graphPoints = [0, 10, 5, 8, 10, 10, 8, 2, 0]
    }
    
    @IBAction func weekTwoScoreTouched(_ sender: Any) {
        print("week two touched")
        
        self.WeeklyView.setNeedsDisplay()
        // Test Data
        self.store.graphPoints = [0, 2, 10, 8, 2, 10, 9, 10, 0]
    }
    
    
    
    func velocityScoreViewTransition(with labeltext: String) {
        
        UIView.animateKeyframes(withDuration: 0.7, delay: 0.0, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3, animations: {
                self.velocityScoreView.layer.opacity = 0
                self.velocityScoreView.center.x += self.view.bounds.width
            })
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.1, animations: {
                self.velocityScoreView.center.x -= self.view.bounds.width * 2
            })
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.3, animations: {
                self.velocityScoreView.layer.opacity = 1
                self.velocityScoreView.center.x = self.view.center.x
                self.velocityScoreView.velocityScoreLabel.text = ""
            })
        }, completion: { success in
            self.velocityScoreView.velocityScoreLabel.text = "\(labeltext)'s Velocity Score"
        })
    }
    
    // Test: Redraw Graph
    func setupGraphDisplay() {
    }
    
}
