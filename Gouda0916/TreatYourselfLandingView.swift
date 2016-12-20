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
        TreatYourselfLanding.drawCanvas1(frame: rect, resizing: .aspectFit)
    }
}
