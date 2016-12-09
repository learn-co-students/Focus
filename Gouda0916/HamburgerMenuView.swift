//
//  HamburgerMenuView.swift
//  Gouda0916
//
//  Created by Douglas Galante on 12/9/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class HamburgerMenuView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var logoutFooter: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        
        Bundle.main.loadNibNamed("HamburgerMenuView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        
    }
    
}
