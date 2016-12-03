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
    
    
    @IBOutlet weak var goalView: GoalTableViewCellView!
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var goalViewCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var editViewLeadingConstraint: NSLayoutConstraint!
    
    
    
    var textForOptions: [String] = ["Set this goal as the current active goal", "Change your savings goal", "Change what you're savings for", "Change what you're saving on", "Change Timeframe", " Change Daily Budget", "Delete Goal"]
    
    
    //Collection View Cell Size and Spacing
    var spacing: CGFloat!
    var sectionInsets: UIEdgeInsets!
    var itemSize: CGSize!
    var numberOfCellsPerRow: CGFloat = 2
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureLayout()
        goalView.goal = self.goal
        goalView.editButton.isHidden = true
        
    }

    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func populateTextForOptions() {
        
    }
    
}

//MARK: View Controller Delegate and Datasource
extension EditGoalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textForOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = optionsCollectionView.dequeueReusableCell(withReuseIdentifier: "editGoalCell", for: indexPath) as! EditGoalCustomCell
        cell.backgroundColor = UIColor.themeLightGreenColor
        cell.cellLabel.text = textForOptions[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        
        
        
        UIView.animate(withDuration: 0.1, animations: {
            self.editViewLeadingConstraint.constant -= UIScreen.main.bounds.width
            self.view.layoutIfNeeded()
        })
        
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
        if indexPath.row == textForOptions.count - 1 {
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


class EditGoalCustomCell: UICollectionViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
}
