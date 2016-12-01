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
    
    let store = DataStore.sharedInstance
    
    // Mark: Constants
    //    let loginToMain = "loginToMain"
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
        
        passwordTextField.isSecureTextEntry = true
        
        //        print("** inside viewDidLoad(), self.emailPopulated: \(self.emailPopulated), self.passwordPopulated: \(self.passwordPopulated)")
        
        
        
        FIRAuth.auth()!.addStateDidChangeListener() { auth, authenticatedEmail in
            if authenticatedEmail != nil {
                guard let uid = authenticatedEmail?.uid else {return}
            }
                
                
            else if self.emailPopulated || self.passwordPopulated {
                print("*** else if self.emailPopulated || self.passwordPopulated in FIRAuth.auth()!.addStateDidChangeListener(), authenticatedEmail = \(authenticatedEmail) ***")
            }
                
            else {  // enters here when authenticatedEmail = nil
                print("*** else in FIRAuth.auth()!.addStateDidChangeListener(), authenticatedEmail = \(authenticatedEmail) ***")
            }
            
        }
        
    }// end of view did load
    
    
    
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
    
    
//    func handleSignIn() {
//        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
//        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
//            if error != nil {
//                return
//            }
//        })
//    }
    
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

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "loginSegue") {
//            let destinationViewController = segue.destination as! MainViewController
//        }
//    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool { return true }
    
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
}







