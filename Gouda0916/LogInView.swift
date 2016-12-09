//
//  LogInView.swift
//  Gouda0916
//
//  Created by Douglas Galante on 12/9/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class LogInView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var imNewButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("LogInView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName : UIColor.themeDarkGreenColor])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName : UIColor.themeDarkGreenColor])
      
        let startingColorOfGradient = UIColor.themeLightPrimaryBlueColor.cgColor
        let endingColorOFGradient = UIColor.themeDarkGreenColor.cgColor
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = contentView.bounds
        gradient.colors = [startingColorOfGradient , endingColorOFGradient]
        self.contentView.layer.insertSublayer(gradient, at: 0)
    
    }
}
