//
//  CustomGoalTableViewCell.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/19/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class CustomGoalCell: UITableViewCell {
    
    weak var customView: GoalTableViewCellView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initCustomViewWithFrame() {
        let x = self.contentView.bounds.origin.x
        let y = self.contentView.bounds.origin.y
        let width = self.contentView.bounds.width
        print(self.bounds.maxX)
        print(width)
        let height = self.contentView.bounds.height * 2
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let view = GoalTableViewCellView(frame: frame)
        
        self.customView = view
        if let customView = customView {
            self.contentView.addSubview(customView)
        }
        
//        customView.translatesAutoresizingMaskIntoConstraints = false
//        
//        customView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
//        customView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
//        customView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        customView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    
    
}

