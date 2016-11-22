//
//  VelocityScore.swift
//  Gouda0916
//
//  Created by Michael Young on 11/22/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class VelocityScore: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var velocityScore: UILabel!
    @IBOutlet weak var backGroundCircleView: UIView!
    @IBOutlet weak var shadowBackGroundCircleView: UIView!

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
        Bundle.main.loadNibNamed("VelocityScore", owner: self, options: nil)
    }
    
    func updateView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentView)
        
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        backGroundCircleView.layer.masksToBounds = true
        backGroundCircleView.layer.cornerRadius = 70
        
        shadowBackGroundCircleView.layer.masksToBounds = false
        shadowBackGroundCircleView.layer.cornerRadius = 70
        shadowBackGroundCircleView.layer.shadowColor = UIColor.black.cgColor
        shadowBackGroundCircleView.layer.shadowOpacity = 1
        shadowBackGroundCircleView.layer.shadowRadius = CGFloat(5)
        shadowBackGroundCircleView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    
    
    
    
}
