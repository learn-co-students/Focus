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
    var menuShowing = false
    
    @IBOutlet weak var saveCancelView: EditGoalView!
    @IBOutlet weak var yesNoView: YesNoView!
    @IBOutlet weak var goalView: GoalTableViewCellView!
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var saveCancelViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var yesNoTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewBlocker: UIView!
    @IBOutlet weak var footerView: FooterView!
    @IBOutlet weak var collectionViewContainerView: UIView!
    @IBOutlet weak var deleteImageView: UIImageView!
    
    //Collection View Cell Size and Spacing
    let screenWidth = UIScreen.main.bounds.width
    var spacing: CGFloat!
    var sectionInsets: UIEdgeInsets!
    var itemSize: CGSize!
    var numberOfCellsPerRow: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateEditOptions()
        configureLayout()
        goalView.goal = self.goal
        
        //sets bars to zero so they animate to progress in the view did appear
        goalView.savingsTrailingConstraint.constant = 0
        goalView.daysTrailingConstraint.constant = 0
        
        goalView.expandIconImageView.isHidden = true
        goalView.editIconImageView.isHidden = true
        collectionViewBlocker.isHidden = true
        
        //gradient for collection view
        let startingColorOfGradient = UIColor.themeLightPrimaryBlueColor.cgColor
        let endingColorOFGradient = UIColor.themePaleGreenColor.cgColor
        let gradient: CAGradientLayer = CAGradientLayer()
        optionsCollectionView.backgroundColor = .clear
        gradient.frame = collectionViewContainerView.bounds
        gradient.colors = [startingColorOfGradient , endingColorOFGradient]
        self.collectionViewContainerView.layer.insertSublayer(gradient, at: 0)
        
       
        addGestures()
        setUpTextFieldForValidation()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.goalView.updateLabels()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func addGestures() {
        //unhide hamburger when we get rid of segway
//        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(pressedHamburger))
//        footerView.hamburgerMenuImageView.addGestureRecognizer(tapGesture)
//        footerView.hamburgerMenuImageView.isUserInteractionEnabled = true
        footerView.hamburgerMenuImageView.isHidden = true
        
        let deleteTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(deleteImageTapped))
        deleteImageView.addGestureRecognizer(deleteTapGesture)
        deleteImageView.image = #imageLiteral(resourceName: "no X mark copy")
        
        let yesIconGesture = UITapGestureRecognizer.init(target: self, action: #selector(yesOrSaveButtonTapped))
        yesNoView.checkImageView.addGestureRecognizer(yesIconGesture)
        
        let saveIconGesture = UITapGestureRecognizer.init(target: self, action: #selector(yesOrSaveButtonTapped))
        saveCancelView.checkImageView.addGestureRecognizer(saveIconGesture)
        
        let xIconGesture = UITapGestureRecognizer.init(target: self, action: #selector(noOrCancelButtonTapped))
        yesNoView.xImageView.addGestureRecognizer(xIconGesture)
        
        let xIconGesture2 = UITapGestureRecognizer.init(target: self, action: #selector(noOrCancelButtonTapped))
        saveCancelView.xImageView.addGestureRecognizer(xIconGesture2)
    }
    
    //MARK: Button Actions
    //make this re-usable witht he collection view and dont force unwrap
    func deleteImageTapped() {
        let edit = Edit(editQuestion: "Delete Goal", editRequest: "Delete This Goal?", editType: .yesNo, editChange: .delete, editImage: #imageLiteral(resourceName: "no X mark copy"))
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
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        delegate?.resetTableView()
        self.dismiss(animated: true, completion: nil)
    }
    
    func pressedHamburger(sender: UITapGestureRecognizer) {
        if !menuShowing {
            NotificationCenter.default.post(name: .unhideBar, object: nil)
        } else {
            NotificationCenter.default.post(name: .hideBar, object: nil)
        }
    }
    
    func noOrCancelButtonTapped(_ sender: UITapGestureRecognizer) {
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
    
    func yesOrSaveButtonTapped(_ sender: UITapGestureRecognizer) {
       
        if let currentEditOpen = currentEditOpen {
            
            let input = saveCancelView.textField.text!
            
            switch currentEditOpen.editChange {
            case .delete:
                store.goals.remove(at: goalIndex)
                delegate?.resetTableView()
                store.persistentContainer.viewContext.delete(goal)
                self.dismiss(animated: true, completion: nil)
            case .activate:
                store.goals.first?.isActiveGoal = false
                goal.willChangeValue(forKey: "isActiveGoal")
                goal.isActiveGoal = true
                goal.didChangeValue(forKey: "isActiveGoal")
                store.goals.remove(at: goalIndex)
                store.goals.insert(goal, at: 0)
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
                goal.willChangeValue(forKey: "endDate")
                let timeInt = TimeInterval.init(exactly: goal.timeframe*60*60*24)
                if let timeInt = timeInt {
                    goal.endDate = goal.startDate?.addingTimeInterval(timeInt)
                }
                goal.didChangeValue(forKey: "endDate")
            case .changeBudget:
                goal.willChangeValue(forKey: "dailyBudget")
                goal.dailyBudget = Double(input)!
                goal.didChangeValue(forKey: "dailyBudget")
            case .changeWayToSave:
                //need to get rid of having multiple ways to save
                break
                
            }
            
            goalView.updateLabels()
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
                    self.saveCancelView.checkImageView.alpha = 0.2
                    self.saveCancelView.isUserInteractionEnabled = false
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
        goalView.allowanceLabel.text = "$\(Int(goal.alloctedDailyBudget!))"
        goalView.daysProgressLabel.text = "\(Int(goal.dayCounter))/\(Int(goal.timeframe))"
    }
    
    func populateEditOptions() {
        
        let editActivateGoal = Edit(editQuestion: "set as active goal", editRequest: "Replace current active goal with this goal?", editType: .yesNo, editChange: .activate, editImage: #imageLiteral(resourceName: "set as active goal"))
        let editSavingsPurchase = Edit(editQuestion: "change what you're saving for", editRequest: "Enter a new thing you want to save for.", editType: .saveCancel, editChange: .changePurchase, editImage: #imageLiteral(resourceName: "change what youre saving goal"))
        let editSavingsGoal = Edit(editQuestion: "change total savings amount", editRequest: "Enter a new savings amount.", editType: .saveCancel, editChange: .changeGoal, editImage: #imageLiteral(resourceName: "change savings goal"))
        let editWayToSave = Edit(editQuestion: "change what you're saving on", editRequest: "What do you want to save money on?", editType: .saveCancel, editChange: .changeWayToSave, editImage: #imageLiteral(resourceName: "change focus"))
        let editTimeframe = Edit(editQuestion: "adjust timeframe", editRequest: "Enter the total days you have to save?", editType: .saveCancel, editChange: .changeTimeframe, editImage: #imageLiteral(resourceName: "timeframe"))
        let editDailyBudget = Edit(editQuestion: "adjust daily budget", editRequest: "What is your daily budget?", editType: .saveCancel, editChange: .changeBudget, editImage: #imageLiteral(resourceName: "change daily budget"))
        
        editOptions = [editActivateGoal, editSavingsGoal, editSavingsPurchase, editWayToSave, editTimeframe, editDailyBudget]
        
    }
    
}

//MARK: Collection View Delegate and Datasource
extension EditGoalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return editOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = optionsCollectionView.dequeueReusableCell(withReuseIdentifier: "editGoalCell", for: indexPath) as! EditGoalCustomCell
        let index = indexPath.row
        cell.backgroundColor = UIColor.clear
        cell.cellLabel.text = editOptions[index].editQuestion
        cell.iconImageView.image = editOptions[index].editImage
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
        
//      let whiteSpace: CGFloat = numberOfCellsPerRow + 1.0
        let desiredSpacing: CGFloat = 0

        let itemWidth = collectionViewContainerView.frame.width / numberOfCellsPerRow
        let itemHeight = collectionViewContainerView.frame.height / (CGFloat(editOptions.count) / numberOfCellsPerRow)
        
        spacing = desiredSpacing
        sectionInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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

//MARK: Text Field Validation
extension EditGoalViewController {
    
    func setUpTextFieldForValidation() {
        saveCancelView.textField.addTarget(self, action: #selector(checkForTextFieldEdit), for: UIControlEvents.editingChanged)
    }
    
    func checkForTextFieldEdit(_ textField: UITextField) {
        let validInput = checkForValidInputIn(textField: textField)
        
        //changes text field color
        if validInput {
            textField.textColor = UIColor.themeBlackColor
            saveCancelView.checkImageView.isUserInteractionEnabled = true
            saveCancelView.checkImageView.alpha = 1
        } else {
            textField.textColor = .red
            saveCancelView.checkImageView.isUserInteractionEnabled = false
            saveCancelView.checkImageView.alpha = 0.2
        }
    
    }
    
    func checkForValidInputIn(textField: UITextField) -> Bool {
        var isValid = false
        let userInput = textField.text
        
        if let editOpen = currentEditOpen {
            switch editOpen.editChange{
            case .changeGoal, .changeBudget, .changeTimeframe:
                if let userInput = userInput {
                    let inputAsDouble = Double(userInput)
                    if inputAsDouble != nil {
                        if inputAsDouble! > 0.0 {
                            isValid = true
                        }
                    }
                }
            case .changeWayToSave, .changePurchase:
                if userInput != "" {
                    isValid = true
                }
            default:
                break
            }

        }
        return isValid
    }

}

//MARK: Collection View Custom Cell
class EditGoalCustomCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
}

//MARK: Edit and EditType
struct Edit {
    let editQuestion: String
    let editRequest: String
    let editType: EditType
    let editChange: EditChange
    var editImage: UIImage
}

enum EditType {
    case yesNo, saveCancel
}

enum EditChange {
    case activate, delete, changeGoal, changePurchase, changeTimeframe, changeBudget, changeWayToSave
}


