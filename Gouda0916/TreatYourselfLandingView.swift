//
//  TreatYourselfLandingView.swift
//  Gouda0916
//
//  Created by Victoria Melendez on 12/1/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

@IBDesignable

class TreatYourselfLandingView: UIView {
    

    
    override func draw(_ rect: CGRect) {
        
        TreatYourselfLanding.drawCanvas1()
       
    }
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        self.clipsToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
