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
    var goal: Goal!
    var editIsActive = false
    
    
    @IBOutlet weak var goalView: GoalTableViewCellView!
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var saveCancelViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var goalViewCenterXConstraint: NSLayoutConstraint!
    
    
    
    var editOptions: [Edit] = []
    
    
    //Collection View Cell Size and Spacing
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
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func populateEditOptions() {
        let editActivateGoal = Edit(editQuestion: "Set this goal as the current active goal", editRequest: "Replace current active goal with this goal?", editType: .yesNo)
        let editDeleteGoal = Edit(editQuestion: "Delete Goal", editRequest: "Delete This Goal?", editType: .yesNo)
        let editSavingsPurchase = Edit(editQuestion: "Change what you're saving for", editRequest: "Enter a new thing you want to save for", editType: .saveCancel)
        let editSavingsGoal = Edit(editQuestion: "Change what you're savings for", editRequest: "Enter a new savings amount", editType: .saveCancel)
        let editWayToSave = Edit(editQuestion: "Change what you're saving on", editRequest: "What do you want to save money on?", editType: .saveCancel)
        let editTimeframe = Edit(editQuestion: "Change Timeframe", editRequest: "How many days do you have to save?", editType: .saveCancel)
        let editDailyBudget = Edit(editQuestion: " Change Daily Budget", editRequest: "What is your daily budget?", editType: .saveCancel)
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let type = editOptions[indexPath.item].editType
        
        if type == .yesNo {
            
        }
        
        
        if type == .saveCancel {
            UIView.animate(withDuration: 0.1, animations: {
                self.saveCancelViewLeadingConstraint.constant -= UIScreen.main.bounds.width
                self.view.layoutIfNeeded()
            })
        }
        
    }
    
}

//MARK: Collection view flow Layout
extension EditGoalViewController: UICollectionViewDelegateFlowLayout {
    
    func configureLayout () {
        
        let screenWidth = UIScreen.main.bounds.width
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
}

enum EditType {
    case yesNo, saveCancel
}
