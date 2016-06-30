//
//  RegisterViewController.swift
//  o_X
//
//  Created by Larissa Clopton on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(sender: UIButton) {
        
        let registerMessage = {(user: User?, message: String?) in
            if user != nil {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController()
                let application = UIApplication.sharedApplication()
                let window = application.keyWindow
                window?.rootViewController = viewController
                
            }
            else {
                let failAlert = UIAlertController(title: "Registration failed", message: message, preferredStyle:UIAlertControllerStyle.Alert)
                
                let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
                
                failAlert.addAction(alertAction)
            
                self.presentViewController(failAlert, animated: true, completion: nil)
            }
        }
        
        UserController.sharedInstance.register(email: emailInput.text!, password: passwordInput.text!, onCompletion: registerMessage)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
