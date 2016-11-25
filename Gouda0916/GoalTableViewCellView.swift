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
    
    
    
    
    func updateLabels() {
        titleLabel.text = goal.purchasGoal!
        goalLabel.text = "$\(goal.goalAmount)"
        allowanceAmountLabel.text = "$\(goal.alloctedDailyBudget)"
        allowanceDescriptionLabel.text = "daily allowance for \(goal.waysToSaveAsStrings[0])"
        
        daysProgressLabel.text = "\(goal.dayCounter)/\(goal.timeframe)"
        savingsProgressLabel.text = "\(goal.currentAmountSaved)/\(goal.goalAmount)"
        
        
    }
    
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
        contentView.topAnchor.constraint(equalTo: self.topAnchor)
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor)
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor)
    }
    
    

}

