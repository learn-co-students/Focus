//
//  VelocityScoreView.swift
//  Gouda0916
//
//  Created by Michael Young on 11/22/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class VelocityScoreView: UIView {
    
    let store = DataStore.sharedInstance
    let velocity = Velocity()
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var velocityScoreLabel: UILabel!
    @IBOutlet weak var velocityDayLabel: UILabel!
    @IBOutlet weak var velocityScoreView: UIView!
    @IBOutlet weak var velocityScoreBGView: UIView!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        Bundle.main.loadNibNamed("VelocityScoreView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    
    func updateVelocityView() {
        velocityScoreView.layer.masksToBounds = true
        velocityScoreView.layer.cornerRadius = 5.0
        velocityScoreBGView.layer.cornerRadius = 5
        velocityScoreBGView.layer.shadowColor = UIColor.themeBlackColor.cgColor
        velocityScoreBGView.layer.shadowOpacity = 0.8
        velocityScoreBGView.layer.shadowOffset = CGSize(width: 0, height: 0)
        velocityScoreBGView.layer.shadowRadius = 3
        velocityScoreLabel.text = "\(store.velocity)"
    }
}
