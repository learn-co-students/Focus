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
    
    //var user1 = DataStore.sharedInstance.userName
    
    let store = DataStore.sharedInstance
    var user1 = store.userName
    
    // Mark: Constants
    let loginToMain = "loginToMain"
    
    // Mark: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var newUserButton: UIButton!

    override func viewDidLoad(){
        super.viewDidLoad()
       
        passwordTextField.isSecureTextEntry = true
        
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                 self.performSegue(withIdentifier: self.loginToMain, sender: nil)
            }
        }
    }
    
    func handleSignIn() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                return
            }
        })
    }
    
    func signInUser(email: String, password: String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print("user couldn't login \(error)")
                return
            }
            print("user signed in")
        })
    }
    
    //Mark: Buttons
    @IBAction func loginButtonTouched(_ sender: AnyObject) {
<<<<<<< HEAD
        
        if let email = self.emailTextField.text {
            self.user1.email = email
            
            print("something obvious, but i dont know what")
            FIRAuth.auth()!.signIn(withEmail: emailTextField.text!,
                                   password: passwordTextField.text!)
            { (user, error) in
                if error != nil {
                    let nserror = error as! NSError
                    let errorvalue = nserror.userInfo["error_name"] as! String
                    if errorvalue == "ERROR_INVALID_EMAIL" || errorvalue == "ERROR_USER_NOT_FOUND" {
                        self.indicateError(fieldName: self.emailTextField)
                    } else if errorvalue == "ERROR_WRONG_PASSWORD" {
                        self.indicateError(fieldName: self.passwordTextField)
                    } else {
                        print("onClickSignIn: Another thype of error was returned: \(errorvalue). This error needs to be handled.")
                        
                        
                    }
                }
            }
        }
    }
    
    
    
                
                @IBAction func forgotPasswordButtonTouched(_ sender: UIButton) {
                }
                
                @IBAction func newUseButtonTouched(_ sender: UIButton) {
                    let alert = UIAlertController(title: "Register",
                                                  message: "Register",
                                                  preferredStyle: .alert)
                    
                    let saveAction = UIAlertAction(title: "Save",
                                                   style: .default) { action in
                                                    
                                                    guard let emailField = alert.textFields![0].text else { return }
                                                    guard let passwordField = alert.textFields![1].text else { return }
                                                    
                                                    print(emailField, passwordField)
                                                    
                                                    
                                                    FIRAuth.auth()!.createUser(withEmail: emailField, password: passwordField, completion: { (user, error) in
                                                        
                                                        if error == nil {
                                                            FIRAuth.auth()!.signIn(withEmail: emailField, password: passwordField)
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
                
                
                //Victoria Email enable
                
                var emailPopulated = false
                var passwordPopulated = false
                
                
                
                func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                    switch textField.tag {
                    case 100:   // check to see if email has a value
                        if self.emailTextField.text!.utf16.count > 0 {
                            self.emailPopulated = true
                        } else {
                            self.emailPopulated = false
                        }
                        self.enableDisableSignIn()
                    case 101: // verify password >= 6 characters
                        if self.passwordTextField.text!.utf16.count > 0 {
                            self.passwordPopulated = true
                        } else {
                            self.passwordPopulated = false
                        }
                        self.enableDisableSignIn()
                    default: break
                    }
                    return true
                }
                
                
                func enableDisableSignIn(){
                    if self.emailPopulated && self.passwordPopulated {
                        self.loginButton.isEnabled = true
                        self.loginButton.becomeFirstResponder()
                        self.loginButton.alpha = 1.0
                    } else {
                        self.loginButton.isEnabled = false
                        self.loginButton.alpha = 0.3
                    }
                }
                
                
                func indicateError(fieldName textFieldWithError: UITextField){
                    UIView.animate(withDuration: 1, animations: {
                        textFieldWithError.backgroundColor = UIColor.red
                        textFieldWithError.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                    }, completion: { success in
                        UIView.animate(withDuration: 1, animations: {  // reset control to original state
                            textFieldWithError.backgroundColor = UIColor.white
                            textFieldWithError.transform = CGAffineTransform(scaleX: 1.0, y:1.0)
                        })
                    })
                    self.loginButton.isEnabled = false
                    self.loginButton.alpha = 0.3
                    
                }
            }
            
            
            extension LogInViewController: UITextFieldDelegate {
                
                func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                    if textField == emailTextField {
                        passwordTextField.becomeFirstResponder()
                    }
                    if textField == passwordTextField {
                        textField.resignFirstResponder()
                    }
                    return true
                }
=======
        print("something obvious, but i dont know what")
        FIRAuth.auth()!.signIn(withEmail: emailTextField.text!,
                               password: passwordTextField.text!)
    }
    
    @IBAction func forgotPasswordButtonTouched(_ sender: UIButton) {
    }
    
    @IBAction func newUseButtonTouched(_ sender: UIButton) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            
            guard let email = alert.textFields![0].text else { return }
            guard let password = alert.textFields![1].text else { return }
            
            print(email, password)
            
            FIRAuth.auth()!.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    FIRAuth.auth()!.signIn(withEmail: email, password: password)
                }
                
                guard let uid = user?.uid else {
                    return
                }
                
                let ref = FIRDatabase.database().reference(withPath: "User")
                let user = ref.child(uid)
                let value = ["email": email]
                user.updateChildValues(value, withCompletionBlock: { (error, ref) in
                    if error != nil {
                        return
                    }
                    self.signInUser(email: email, password: password)
                    OperationQueue.main.addOperation {
                        self.performSegue(withIdentifier: "createAccount", sender: self)
                    }
                })
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
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


extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
>>>>>>> master
}






