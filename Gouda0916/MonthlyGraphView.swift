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
    
    
    let circlePathLayer = CAShapeLayer()
    let circleRadius: CGFloat = 40.0
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
        updateView()
        //configure()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
        updateView()
        //configure()
      
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("MonthlyGraphView", owner: self, options: nil)
    }
    
    func updateView() {
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentView)
        
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        //contentView.backgroundColor = UIColor.themeAccentGoldColor.withAlphaComponent(0.2)
        
    }
    
    func updateVelocityView() {
    }
    
    // Circle Progess bar
    func configure() {
        circlePathLayer.frame = bounds
        circlePathLayer.lineWidth = 2
        circlePathLayer.fillColor = UIColor.clear.cgColor
        circlePathLayer.strokeColor = UIColor.themeAccentGoldColor.cgColor
        
        layer.addSublayer(circlePathLayer)
        backgroundColor = UIColor.white
    }
    
    // Circle Path bounds
    func circleFrame() -> CGRect {
        var circleFrame = CGRect(x: 0, y: 0, width: 2 * circleRadius, height: 2 * circleRadius)
        circleFrame.origin.x = circlePathLayer.bounds.midX - circleFrame.midX
        circleFrame.origin.y = circlePathLayer.bounds.midY - circleFrame.midY
        return circleFrame
    }
    
    // Draw Circle Path
    func circlePath() -> UIBezierPath {
        return UIBezierPath(ovalIn: circleFrame())
    }
    
    // Contraints
    // Calling circlePath() here to recalculate the path of the circle when view size changes
    override func layoutSubviews() {
        super.layoutSubviews()
        circlePathLayer.frame = bounds
        circlePathLayer.path = circlePath().cgPath
    }
    
    
    
}
