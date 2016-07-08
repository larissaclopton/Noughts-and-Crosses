//
//  LoginViewController.swift
//  o_X
//
//  Created by Larissa Clopton on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailInput.delegate = self
        self.passwordInput.delegate = self
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        
        let loginMessage = {(user: User?, message: String?) in
            if user != nil {
                
                // if login succeeds, switch to game board
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController()
                let application = UIApplication.sharedApplication()
                let window = application.keyWindow
                window?.rootViewController = viewController
                
                //OXGameController.sharedInstance.getCurrentGame().host
            }
            else {
                
                // if login fails
                let failAlert = UIAlertController(title: "Login failed", message: "Invalid credentials. Please try again.", preferredStyle:UIAlertControllerStyle.Alert)
                
                let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
                
                failAlert.addAction(alertAction)
                
                self.presentViewController(failAlert, animated: true, completion: nil)
                
            }
        }
        
        UserController.sharedInstance.login(email: emailInput.text!, password: passwordInput.text!, onCompletion: loginMessage)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}
