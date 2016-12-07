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
    
    @IBOutlet weak var savingGoalView: UIView!
    @IBOutlet weak var daysProgressLabel: UILabel!
    @IBOutlet weak var savingsProgressLabel: UILabel!
    @IBOutlet weak var daysCompleteProgressBarConstraint: NSLayoutConstraint!
    @IBOutlet weak var savingsProgressBarConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var editButton: UIButton!
    let gradientLayer = CAGradientLayer()
    
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
        titleLabel.text = goal.purchasGoal!.capitalized
        allowanceLabel.text = "$\(goal.goalAmount)/day"
        goalLabel.text = "$\(Int(goal.alloctedDailyBudget!))"
        daysProgressLabel.text = "\(Int(goal.dayCounter)) "
        daysLabel.text = "/ \(Int(goal.timeframe))"
        savingsProgressLabel.text = "$\(Int(goal.currentAmountSaved)) "
        smallGoalLabel.text = "/ $\(Int(goal.goalAmount))"
        daysCompleteProgressBarConstraint.constant = CGFloat(goal.currentAmountSaved / goal.goalAmount) * savingGoalView.frame.width
        savingsProgressBarConstraint.constant = CGFloat(goal.dayCounter / goal.timeframe) * savingGoalView.frame.width
        
        if !goal.isActiveGoal {
            gradientLayer.frame = contentView.bounds
            gradientLayer.colors = [UIColor.themeDarkGreenColor, UIColor.themeLightGreenColor]
            gradientLayer.locations = [0.5, 0.0]
            contentView.layer.addSublayer(gradientLayer)
            
            contentView.backgroundColor = UIColor.themeLightPrimaryBlueColor
            titleLabel.textColor = UIColor.white
            breakLabel.textColor = UIColor.themeLightGrayColor
            wayToSaveLabel.textColor = UIColor.themeLightGrayColor
            focusOnLabel.textColor = UIColor.themeLightGrayColor
            allowanceLabel.textColor = UIColor.themeLightGrayColor
        }
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
