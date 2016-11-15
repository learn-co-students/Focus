//
//  LogInViewController.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/14/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    // Mark: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var newUserButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Mark: Buttons
    @IBAction func loginButtonTouched(_ sender: UIButton) {
    }
    
    @IBAction func forgotPasswordButtonTouched(_ sender: UIButton) {
    }
    
    @IBAction func newUseButtonTouched(_ sender: UIButton) {
    }
}
