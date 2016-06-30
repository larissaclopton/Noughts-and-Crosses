//
//  UserController.swift
//  o_X
//
//  Created by Larissa Clopton on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class UserController {
    
    static var sharedInstance = UserController()
    
    var currentUser = User()
    
    func register(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        
    }
    
    func login(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        
    }
    
    func logout(onCompletion onCompletion: (String?) -> Void) {
        
    }

}
