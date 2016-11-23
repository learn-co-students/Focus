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
}






