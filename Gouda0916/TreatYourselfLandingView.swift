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
        
        if DataStore.sharedInstance.goals.isEmpty{
            print ("nothing to show")
        
        }
        else {
        TreatYourselfLanding.drawCanvas1()
        
            }

}
}
