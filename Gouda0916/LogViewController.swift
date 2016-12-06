//
//  LogViewController.swift
//  Gouda0916
//
//  Created by Michael Young on 11/14/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {


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

        // Temp
        headerView.backgroundColor = UIColor.white
        WeeklyView.backgroundColor = UIColor.white
        maskView.backgroundColor = UIColor.white
        print("maskView height:\(maskView.bounds.height)")
        print("maskView width:\(maskView.bounds.width)")

        updateViewShadow()

                navigationController?.navigationBar.isHidden = true

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @IBAction func MenuButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: .unhideBar, object: nil)
    }
//    @IBAction func backButtonClicked(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }

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


    @IBAction func dailyScoreButtonTouched(_ sender: UIButton) {
        setupGraphDisplay()

        let buttonTapped = sender.accessibilityLabel
        if let unwrappedButtonTapped = buttonTapped {
            velocityScoreViewTransition(with: unwrappedButtonTapped)
        }
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

    func setupGraphDisplay() {

        weeklyGraphView.graphPoints = [0, 2, 10, 2, 3, 8, 5, 10, 0]
        print(weeklyGraphView.graphPoints)
        weeklyGraphView.setNeedsDisplay()
        WeeklyView.setNeedsDisplay()
        WeeklyView.setNeedsLayout()

    }
}
