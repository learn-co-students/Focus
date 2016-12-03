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
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("YesNoView", owner: self, options: nil)
        
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        
    }
}
