//
//  RegisterViewController.swift
//  o_X
//
//  Created by Larissa Clopton on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailInput.delegate = self
        self.passwordInput.delegate = self
    }
    
    @IBAction func registerButtonTapped(sender: UIButton) {
        
        let registerMessage = {(user: User?, message: String?) in
            if user != nil {
                
                // if register succeeds, switch to the game board
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController()
                let application = UIApplication.sharedApplication()
                let window = application.keyWindow
                window?.rootViewController = viewController
                
            }
            else {
                
                //if register fails
                let failAlert = UIAlertController(title: "Registration failed", message: message, preferredStyle:UIAlertControllerStyle.Alert)
                
                let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
                
                failAlert.addAction(alertAction)
                
                self.presentViewController(failAlert, animated: true, completion: nil)
                
            }
        }
        
        UserController.sharedInstance.register(email: emailInput.text!, password: passwordInput.text!, onCompletion: registerMessage)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}
