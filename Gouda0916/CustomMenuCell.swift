//
//  CustomMenuCell.swift
//  Gouda0916
//
//  Created by Douglas Galante on 12/9/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class CustomMenuCell: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    var menuOption: MenuOption? {
        didSet{
            label.text = self.menuOption?.label
            iconImageView.image = self.menuOption?.image
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
        Bundle.main.loadNibNamed("CustomMenuCell", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
    }
}
