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
    
    // Mark: Constants
    let store = DataStore.sharedInstance
    var user1 = DataStore.sharedInstance.userName
    var emailPopulated = false
    var passwordPopulated = false
    
    // Mark: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var newUserButton: UIButton!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //set tags
        
        self.emailTextField.tag = 100
        self.passwordTextField.tag = 101
        
        //set delegates
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        //add layout constraint function
        self.emailPopulated = false
        self.passwordPopulated = false
        
        applyGradient()
        
        passwordTextField.isSecureTextEntry = true
        
        FIRAuth.auth()!.addStateDidChangeListener() { auth, authenticatedEmail in
            if authenticatedEmail != nil {
                //not needed?
                //guard let uid = authenticatedEmail?.uid else {return}
            }
            else if self.emailPopulated || self.passwordPopulated {
                print("*** else if self.emailPopulated || self.passwordPopulated in FIRAuth.auth()!.addStateDidChangeListener(), authenticatedEmail = \(authenticatedEmail) ***")
            }
            else {  // enters here when authenticatedEmail = nil
                print("*** else in FIRAuth.auth()!.addStateDidChangeListener(), authenticatedEmail = \(authenticatedEmail) ***")
            }
        }
    } // end of view did load
    
    func applyGradient() {
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName : UIColor.themeDarkGreenColor])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName : UIColor.themeDarkGreenColor])
        
        let startingColorOfGradient = UIColor.themeLightPrimaryBlueColor.cgColor
        let endingColorOFGradient = UIColor.themeDarkGreenColor.cgColor
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [startingColorOfGradient , endingColorOFGradient]
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        /// to check if email & password are longer than however many characters
        switch emailTextField.tag {
        case 100, 101:   // check to see if email has a value
            if self.emailTextField.text!.utf16.count > 0 && self.passwordTextField.text!.utf16.count > 0 {
                self.emailPopulated = true
                self.passwordPopulated = true
                print ("HELLLLLLLLLLLLLOOOOOOOO")
            }
            else {
                self.emailPopulated = false
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
    
    func signInUser(email: String, password: String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                }
                return
            }
            print("user signed in")
        })
    }
    
    //Mark: Buttons
    @IBAction func loginButtonTouched(_ sender: AnyObject) {
        if let email = self.emailTextField.text {
            if let password = self.passwordTextField.text {
                
                self.user1.email = email
                
                FIRAuth.auth()!.signIn(withEmail: email, password: password) { (user, error) in
                    if error == nil {
                        NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                    }
                    else if error != nil {
                        let nserror = error as! NSError
                        let errorvalue = nserror.userInfo["error_name"] as! String
                        if errorvalue == "ERROR_INVALID_EMAIL" || errorvalue == "ERROR_USER_NOT_FOUND" {
                            self.indicateError(fieldName: self.emailTextField)
                        } else if errorvalue == "ERROR_WRONG_PASSWORD" {
                            self.indicateError(fieldName: self.passwordTextField)
                        } else {
                            print("onClickSignIn: Another type of error was returned: \(errorvalue). This error needs to be handled.")
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func forgotPasswordButtonTouched(_ sender: UIButton) {
        
        let forgotPasswordAlert = UIAlertController(title: "Forgotten Password", message: "Enter your email address so we can send you info on how to reset your password.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("User pushed OK on alertController")
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("User pushed OK on alertController")
            
            let emailField = forgotPasswordAlert.textFields![0] as UITextField
            print("the user entered \(emailField)")
            
            
            //Not Needed?
            //guard let email = emailField.text else { return }
        }
        
        forgotPasswordAlert.addTextField { (textfield) in
            textfield.placeholder = "email address"
        }
        
        forgotPasswordAlert.addAction(cancelAction)
        forgotPasswordAlert.addAction(okAction)
        
        self.present(forgotPasswordAlert, animated: true) {
            print ("buttonpress")
        }
        
        guard let email = emailTextField.text else { return }
        
        FIRAuth.auth()?.sendPasswordReset(withEmail: email) { (success) in
            if (success != nil) {
                print ("reset email sent")
            } else {
                print ("error")
            }
        }
    
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
                        NotificationCenter.default.post(name: .closeLoginVC, object: nil)
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
    
    func indicateError(fieldName textFieldWithError: UITextField){
        UIView.animate(withDuration: 1, animations: {
            textFieldWithError.backgroundColor = UIColor.red
            textFieldWithError.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { success in
            UIView.animate(withDuration: 1, animations: {  // reset control to original state
                textFieldWithError.backgroundColor = UIColor.clear
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
}

