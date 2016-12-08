//
//  MonthlyGraphView.swift
//  Gouda0916
//
//  Created by Michael Young on 11/28/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class MonthlyGraphView: UIView {

    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
        updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
        updateView()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("MonthlyGraphView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func updateView() {}
    
    func updateVelocityView() {}
}
