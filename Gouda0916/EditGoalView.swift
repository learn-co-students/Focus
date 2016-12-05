//
//  EditGoalView.swift
//  Gouda0916
//
//  Created by Douglas Galante on 12/2/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation

class EditGoalView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("EditGoalView", owner: self, options: nil)
        
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
    
    }
    
}
