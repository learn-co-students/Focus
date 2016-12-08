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

    let weeklyGraphView = WeeklyGraphView()
    let velocity = Velocity()
	
    var menuIsShowing = false


    // TODO: Fix Caplitalization
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var WeeklyView: WeeklyGraphView!
    @IBOutlet weak var MonthlyView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var maskView: UIView!

    @IBOutlet weak var velocityScoreView: VelocityScoreView!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViewShadow()
        navigationController?.navigationBar.isHidden = true

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func MenuButtonPressed(_ sender: Any) {
        if !menuIsShowing {
            NotificationCenter.default.post(name: .unhideBar, object: nil)
            menuIsShowing = true
        } else {
            NotificationCenter.default.post(name: .hideBar, object: nil)
            menuIsShowing = false
        }

    }

    @IBAction func dailyScoreButtonTouched(_ sender: UIButton) {

        switch sender.tag {
        case 1:
            velocityScoreViewTransition(with: "Sunday")
        case 2:
            velocityScoreViewTransition(with: "Monday")
        case 3:
            velocityScoreViewTransition(with: "Tuesday")
        case 4:
            velocityScoreViewTransition(with: "Wednesday")
        case 5:
            velocityScoreViewTransition(with: "Thursday")
        case 6:
            velocityScoreViewTransition(with: "Friday")
        case 7:
            velocity.updateVelocity(success: true)
            velocityScoreViewTransition(with: "Saturday")
        default:
            print("Failed during sender tag collection")
        }
    }

    @IBAction func weeklyScoreTouched(_ sender: UIButton) {

        if let week = sender.currentTitle {
            print("Week Sender title: \(week)")
            self.WeeklyView.setNeedsDisplay()
            velocity.updateGraph(for: week)
        }
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
                self.velocityScoreView.velocityDayLabel.text = ""
            })
        }, completion: { success in
            self.velocityScoreView.velocityDayLabel.text = "\(labeltext)'s Velocity Score"

        })
    }
}
