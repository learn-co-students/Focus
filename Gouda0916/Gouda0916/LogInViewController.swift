//
//  LogInViewController.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/14/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // Mark: Buttons
    //        @IBAction func loginButtonTouched(_ sender: UIButton) {
    //
    //
    //
    //        //        FIRAuth.auth()!.signIn(withEmail: textFieldLoginEmail.text!,
    //        //                               password: textFieldLoginPassword.text!)
    
    
    //        if let email = self.emailTextField.text {
    //            if let password = self.passwordTextField.text {
    //
    //                FIRAuth.auth()!.addStateDidChangeListener({ (auth, user) in
    //                    if user != nil {
    //                        self.performSegue(withIdentifier: self., sender: nil)
    //                    }
    //                })
    //            }
    //        }
    //    }
    
    //    @IBAction func forgotPasswordButtonTouched(_ sender: UIButton) {
    //    }
    
    @IBAction func newUseButtonTouched(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
                                        
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
                                        
                                        
            FIRAuth.auth()!.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                
                if error == nil {
                    FIRAuth.auth()!.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!)
                }
            })
        }
 
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}





