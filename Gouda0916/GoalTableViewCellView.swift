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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    var goal: Goal! {
        didSet {
            
        }
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

