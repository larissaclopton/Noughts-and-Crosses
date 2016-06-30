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
    
    var registeredUsers: [User] = []
    
    public var currentlyLoggedIn: User?
    
    func register(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        
        var userExists = false
        
        for index in 0 ..< registeredUsers.count {
            if (email == registeredUsers[index].email) {
                userExists = true
                break
            }
        }
        
        if (userExists) {
            onCompletion(nil, "Email address already exists.")
        }
        else if password.characters.count < 6 {
            onCompletion(nil, "Password must be at least 6 characters.")
        }
        else {
            currentUser.email = email
            currentUser.password = password
            onCompletion(currentUser, nil)
            currentlyLoggedIn = currentUser
        }
        
    }
    
    func login(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        currentlyLoggedIn = currentUser
    }
    
    func logout(onCompletion onCompletion: (String?) -> Void) {
        currentlyLoggedIn = nil
    }

}

