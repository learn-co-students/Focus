//
//  CustomGoalTableViewCell.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/19/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class CustomGoalCell: UITableViewCell {
    
    @IBOutlet weak var floatingView: GoalTableViewCellView!
//    weak var delegate: GoalViewController?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

//    
//    func buttonTapped(_ sender: UIButton) {
//        delegate?.editIconTapped(<#T##sender: UITapGestureRecognizer##UITapGestureRecognizer#>)
//    }

}

