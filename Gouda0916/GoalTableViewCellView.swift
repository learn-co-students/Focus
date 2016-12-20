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
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var allowanceLabel: UILabel!
    @IBOutlet weak var breakLabel: UILabel!
    @IBOutlet weak var wayToSaveLabel: UILabel!
    @IBOutlet weak var focusOnLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var smallGoalLabel: UILabel!
    @IBOutlet weak var amountSavedLabel: UILabel!
    @IBOutlet weak var daysCompletedLabel: UILabel!
    @IBOutlet weak var daysProgressLabel: UILabel!
    @IBOutlet weak var savingsProgressLabel: UILabel!
    @IBOutlet weak var savingGoalView: UIView!
    @IBOutlet weak var daysBarView: UIView!
    @IBOutlet weak var savingsBarView: UIView!
    @IBOutlet weak var daysCompleteView: UIView!
    @IBOutlet weak var savingsTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var daysTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var editIconImageView: UIImageView!
    @IBOutlet weak var expandIconImageView: UIImageView!
    var goal: Goal! {
        didSet {
            updateLabels()
        }
    }
    var goalSavingsPercentage: CGFloat {
        return CGFloat(goal.currentAmountSaved / goal.goalAmount)
    }
    var goalDayPercentage: CGFloat {
        return CGFloat(goal.dayCounter / goal.timeframe)
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
        contentView.frame = self.bounds
    }
    
    
    func updateLabels() {
        if goal.isActiveGoal == true {
            expandIconImageView.isHidden = true
        }
        
        titleLabel.text = goal.purchasGoal!.capitalized
        wayToSaveLabel.text = "\(goal.wayToSave!.lowercased()) "
        allowanceLabel.text = "$\(Int(goal.alloctedDailyBudget!)) / day"
        goalLabel.text = "$\(Int(goal.goalAmount))"
        daysProgressLabel.text = "\(Int(goal.dayCounter)) "
        daysLabel.text = "/ \(Int(goal.timeframe))"
        savingsProgressLabel.text = "$\(Int(goal.currentAmountSaved)) "
        smallGoalLabel.text = "/ $\(Int(goal.goalAmount))"
        daysTrailingConstraint.constant = daysBarView.bounds.width * goalDayPercentage
        savingsTrailingConstraint.constant = savingsBarView.bounds.width * goalSavingsPercentage
        
        if !goal.isActiveGoal {
            daysCompletedLabel.textColor = UIColor.white
            amountSavedLabel.textColor = UIColor.white
            daysLabel.textColor = UIColor.themeLightPrimaryBlueColor
            smallGoalLabel.textColor = UIColor.themeLightPrimaryBlueColor
            contentView.backgroundColor = UIColor.themePaleGreenColor
            daysBarView.backgroundColor = UIColor.themeLightPrimaryBlueColor
            savingsBarView.backgroundColor = UIColor.themeLightPrimaryBlueColor
            titleLabel.textColor = UIColor.white
            breakLabel.textColor = UIColor.themeLightPrimaryBlueColor
            wayToSaveLabel.textColor = UIColor.themeLightPrimaryBlueColor
            focusOnLabel.textColor = UIColor.themeLightPrimaryBlueColor
            allowanceLabel.textColor = UIColor.themeLightPrimaryBlueColor
        }
    }
}


