//
//  GoalTableViewCellView.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/23/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class GoalTableViewCellView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var allowanceAmountLabel: UILabel!
    @IBOutlet weak var allowanceDescriptionLabel: UILabel!
    
    @IBOutlet weak var savingGoalView: UIView!
    @IBOutlet weak var daysProgressLabel: UILabel!
    @IBOutlet weak var savingsProgressLabel: UILabel!
    @IBOutlet weak var daysCompleteProgressBarConstraint: NSLayoutConstraint!
    @IBOutlet weak var savingsProgressBarConstraint: NSLayoutConstraint!
    
    var goal: Goal! {
        didSet {
            updateLabels()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        Bundle.main.loadNibNamed("GoalTableViewCellView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
    
    func updateLabels() {
        titleLabel.text = goal.purchasGoal!
        goalLabel.text = "$\(goal.goalAmount)"
        allowanceAmountLabel.text = "$\(goal.alloctedDailyBudget)"
        allowanceDescriptionLabel.text = "daily allowance for \(goal.waysToSaveAsStrings[0])"
        
        daysProgressLabel.text = "\(goal.dayCounter)/\(goal.timeframe)"
        savingsProgressLabel.text = "\(goal.currentAmountSaved)/\(goal.goalAmount)"
        daysCompleteProgressBarConstraint.constant = CGFloat(goal.currentAmountSaved / goal.goalAmount) * savingGoalView.frame.width
        savingsProgressBarConstraint.constant = CGFloat(goal.dayCounter / goal.timeframe) * savingGoalView.frame.width
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
