//
//  EditGoalViewController.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/30/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation
import UIKit

class EditGoalViewController: UIViewController {
    let store = DataStore.sharedInstance
    var delegate: EditGoalDelegate?
    var goal: Goal!
    var goalIndex: Int!
    var currentEditOpen: Edit?
    var editOptions: [Edit] = []
    
    @IBOutlet weak var saveCancelView: EditGoalView!
    @IBOutlet weak var yesNoView: YesNoView!
    @IBOutlet weak var goalView: GoalTableViewCellView!
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var saveCancelViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var yesNoTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewBlocker: UIView!
    
    //Collection View Cell Size and Spacing
    let screenWidth = UIScreen.main.bounds.width
    var spacing: CGFloat!
    var sectionInsets: UIEdgeInsets!
    var itemSize: CGSize!
    var numberOfCellsPerRow: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateEditOptions()
        configureLayout()
        goalView.goal = self.goal
        goalView.editButton.isHidden = true
        collectionViewBlocker.isHidden = true
        saveCancelView.saveButton.addTarget(self, action: #selector(yesOrSaveButtonTapped), for: .touchUpInside)
        saveCancelView.cancelButton.addTarget(self, action: #selector(noOrCancelButtonTapped), for: .touchUpInside)
        yesNoView.noButton.addTarget(self, action: #selector(noOrCancelButtonTapped), for: .touchUpInside)
        yesNoView.yesButton.addTarget(self, action: #selector(yesOrSaveButtonTapped), for: .touchUpInside)
    }
    
    //MARK: Button Actions
    @IBAction func backButtonTapped(_ sender: Any) {
        delegate?.resetTableView()
        self.dismiss(animated: true, completion: nil)
    }
    
    func noOrCancelButtonTapped(_ sender: UIButton) {
        if let currentEditOpen = currentEditOpen {
            switch currentEditOpen.editChange {
            case .activate, .delete:
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    self.yesNoTrailingConstraint.constant -= self.screenWidth
                    self.collectionViewBlocker.alpha = 0
                    self.view.layoutIfNeeded()
                }, completion: { (success) in
                    self.collectionViewBlocker.isHidden = true
                })
            default:
                view.endEditing(true)
                self.saveCancelView.resignFirstResponder()
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                    self.saveCancelViewTrailingConstraint.constant -= self.screenWidth
                    self.collectionViewBlocker.alpha = 0
                    self.view.layoutIfNeeded()
                }, completion: { success in
                    self.saveCancelView.textField.text = ""
                    self.collectionViewBlocker.isHidden = true
                })
            }
            self.currentEditOpen = nil
        }
    }
    
    func yesOrSaveButtonTapped(_ sender: UIButton) {
       
        if let currentEditOpen = currentEditOpen {
            
            let input = saveCancelView.textField.text!
            
            switch currentEditOpen.editChange {
            case .delete:
                store.goals.remove(at: goalIndex)
                delegate?.resetTableView()
                //delete from core data
                self.dismiss(animated: true, completion: nil)
            case .activate:
                store.goals.remove(at: goalIndex)
                store.goals.insert(goal, at: 0)
                //edit array in core data
            case .changeGoal:
                goal.willChangeValue(forKey: "goalAmount")
                goal.goalAmount = Double(input)!
                goal.didChangeValue(forKey: "goalAmount")
            case .changePurchase:
                goal.willChangeValue(forKey: "purchaseGoal")
                goal.purchasGoal = input
                goal.didChangeValue(forKey: "purchaseGoal")
            case .changeTimeframe:
                goal.willChangeValue(forKey: "timeframe")
                goal.timeframe = Double(input)!
                goal.didChangeValue(forKey: "timeframe")
            case .changeBudget:
                goal.willChangeValue(forKey: "dailyBudget")
                goal.dailyBudget = Double(input)!
                goal.didChangeValue(forKey: "dailyBudget")
            case .changeWayToSave:
                //need to get rid of having multiple ways to save
                break
                
            }
            
            updateGoalView()
            store.saveContext()
            
            //Animate views
            switch currentEditOpen.editChange {
            case .delete:
                break
            case .activate:
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    self.yesNoTrailingConstraint.constant -= self.screenWidth
                    self.collectionViewBlocker.alpha = 0
                    self.view.layoutIfNeeded()
                }, completion: { (success) in
                    self.collectionViewBlocker.isHidden = true
                })
            default:
                view.endEditing(true)
                self.saveCancelView.resignFirstResponder()
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                    self.saveCancelViewTrailingConstraint.constant -= self.screenWidth
                    self.collectionViewBlocker.alpha = 0
                    self.view.layoutIfNeeded()
                }, completion: { success in
                    self.saveCancelView.textField.text = ""
                    self.collectionViewBlocker.isHidden = true
                })
            }
            self.currentEditOpen = nil
        }

    }
    
    func updateGoalView() {
        goalView.titleLabel.text = goal.purchasGoal
        goalView.goalLabel.text = "$\(goal.goalAmount)"
        goalView.savingsProgressLabel.text = "$\(Int(goal.currentAmountSaved))/$\(Int(goal.goalAmount))"
        goalView.allowanceAmountLabel.text = "$\(Int(goal.alloctedDailyBudget!))"
        goalView.daysProgressLabel.text = "\(Int(goal.dayCounter))/\(Int(goal.timeframe))"
    }
    
    func populateEditOptions() {
        
        let editActivateGoal = Edit(editQuestion: "Set this goal as the current active goal", editRequest: "Replace current active goal with this goal?", editType: .yesNo, editChange: .activate)
        let editDeleteGoal = Edit(editQuestion: "Delete Goal", editRequest: "Delete This Goal?", editType: .yesNo, editChange: .delete)
        let editSavingsPurchase = Edit(editQuestion: "Change what you're saving for", editRequest: "Enter a new thing you want to save for", editType: .saveCancel, editChange: .changePurchase)
        let editSavingsGoal = Edit(editQuestion: "Change your total $ goal", editRequest: "Enter a new savings amount", editType: .saveCancel, editChange: .changeGoal)
        let editWayToSave = Edit(editQuestion: "Change what you're saving on", editRequest: "What do you want to save money on?", editType: .saveCancel, editChange: .changeWayToSave)
        let editTimeframe = Edit(editQuestion: "Change Timeframe", editRequest: "How many days do you have to save?", editType: .saveCancel, editChange: .changeTimeframe)
        let editDailyBudget = Edit(editQuestion: " Change Daily Budget", editRequest: "What is your daily budget?", editType: .saveCancel, editChange: .changeBudget)
        
        editOptions = [editActivateGoal, editSavingsGoal, editSavingsPurchase, editWayToSave, editTimeframe, editDailyBudget, editDeleteGoal]
        
    }
    
}

//MARK: View Controller Delegate and Datasource
extension EditGoalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return editOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = optionsCollectionView.dequeueReusableCell(withReuseIdentifier: "editGoalCell", for: indexPath) as! EditGoalCustomCell
        cell.backgroundColor = UIColor.themeLightGreenColor
        cell.cellLabel.text = editOptions[indexPath.row].editQuestion
        return cell
    }
    
    //MARK: Animation to show selected option
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let edit = editOptions[indexPath.item]
        
        if edit.editType == .yesNo {
            yesNoView.label.text = edit.editRequest
            if currentEditOpen == nil {
                collectionViewBlocker.isHidden = false
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    self.yesNoTrailingConstraint.constant += self.screenWidth
                    self.collectionViewBlocker.alpha = 0.9
                    self.view.layoutIfNeeded()
                }, completion: { success in self.currentEditOpen = edit })
            }
        }
        
        
        if edit.editType == .saveCancel {
            saveCancelView.label.text = edit.editRequest
            saveCancelView.textField.becomeFirstResponder()
            if currentEditOpen == nil {
                collectionViewBlocker.isHidden = false
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                    self.saveCancelViewTrailingConstraint.constant += self.screenWidth
                    self.collectionViewBlocker.alpha = 0.9
                    self.view.layoutIfNeeded()
                }, completion: { success in self.currentEditOpen = edit })
            }
        }
    }
}

//MARK: Collection view flow Layout
extension EditGoalViewController: UICollectionViewDelegateFlowLayout {
    
    func configureLayout () {
        
        let desiredSpacing: CGFloat = 2
        let whiteSpace: CGFloat = numberOfCellsPerRow + 1.0
        let itemWidth = (screenWidth - (whiteSpace * desiredSpacing)) / numberOfCellsPerRow
        let itemHeight = ((UIScreen.main.bounds.height * 0.6) - ((4 + 1) * desiredSpacing)) / 4
        
        spacing = desiredSpacing
        sectionInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == editOptions.count - 1 {
            itemSize.width = (itemSize.width * 2) + spacing
            return itemSize
        }
        return itemSize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}

//MARK: Collection View Custom Cell
class EditGoalCustomCell: UICollectionViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
}

//MARK: Edit and EditType
struct Edit {
    let editQuestion: String
    let editRequest: String
    let editType: EditType
    let editChange: EditChange
}

enum EditType {
    case yesNo, saveCancel
}

enum EditChange {
    case activate, delete, changeGoal, changePurchase, changeTimeframe, changeBudget, changeWayToSave
}
