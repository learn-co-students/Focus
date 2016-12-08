//
//  yesNoView.swift
//  Gouda0916
//
//  Created by Douglas Galante on 12/3/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class YesNoView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var xImageView: UIImageView!
    @IBOutlet weak var checkImageView: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("YesNoView", owner: self, options: nil)
        
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        
    }
}
