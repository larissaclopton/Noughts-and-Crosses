//
//  UserController.swift
//  o_X
//
//  Created by Larissa Clopton on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class UserController: WebService {
    
    static var sharedInstance = UserController()
    
    var currentUser = User(token: "", client: "")
    
    var registeredUsers: [User] = []
    
    var currentlyLoggedIn: User?
    
    func register(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        
        let user = ["email":email,"password":password]
        
        //remember a request has 4 things:
        //1: A endpoint
        //2: A method
        //3: input data (optional)
        //4: A response
        let request = self.createMutableAnonRequest(NSURL(string: "https://ox-backend.herokuapp.com/auth"), method: "POST", parameters: user)
        
        //execute request is a function we are able to call in UserController, because UserController extends WebService (See top of file, where UserController is defined)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            //Here is our completion closure for the web request. when the web service is done, this is what is executed.
            //Not only is the code in this block executed, but we are given 2 input parameters, responseCode and json.
            //responseCode is the response code from the server.
            //json is the response data received
            
            print(json)
            var user:User = User(token: "", client:"")
            
            if (responseCode/100 == 2)   { //if the responseCode is 2xx (any responseCode in the 200's range is a success case. For example, some servers return 201 for successful object creation)
                
                //successfully registered user. get the obtained data from the json response data and create the user object to give back to the calling ViewController
                
                user.email = json["data"]["email"].stringValue
                user.password = "not_given_and_not_stored"
                user = User(token:json["data"]["token"].stringValue, client:json["data"]["client"].stringValue)
                
                //while we are at it, lets persist our user
                //and while we still at it, lets set the user as logged in. This is good programming as we are keeping all the user management inside the UserController and handling it at the right time
                
                self.currentlyLoggedIn = user
                
                let defaults = NSUserDefaults.standardUserDefaults()
                
                defaults.setObject(self.currentlyLoggedIn!.email, forKey: "currentUserEmail")
                defaults.setObject(self.currentlyLoggedIn!.password, forKey: "currentUserPassword")
                defaults.synchronize()
                
                //Note that our registerUser function has 4 parameters: email, password, presentingViewController and requestCompletionFunction
                //requestCompletionFunction is a closure for what is to happen in the ViewController when we are done with the webservice.
                
                //lets execute that closure now - Lets me be clear. This is 1 step more advanced than normal. We are executing a closure inside a closure (we are executing the viewControllerCompletionFunction from within the requestCompletionFunction.
                onCompletion(user,nil)
            }   else    {
                //the web service to create a user failed. Lets extract the error message to be displayed
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                //execute the closure in the ViewController
                onCompletion(nil,errorMessage)
            }
        })
  
        
        //we are now done with the registerUser function. Note that this function doesnt return anything. But because of the viewControllerCompletionFunction closure we are given as an input parameter, we can set in motion a function in the calling class when it is needed.
    
        /*var userExists = false
        
        // search all registered users for a matching email
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
            
            // fill in currentUser properties
            currentUser.email = email
            currentUser.password = password
            currentlyLoggedIn = currentUser
            registeredUsers += [currentUser]
            
            onCompletion(currentUser, nil)
            
            // set currentUserEmail and currentUserPassword
            let defaults = NSUserDefaults.standardUserDefaults()
            
            defaults.setObject(currentlyLoggedIn!.email, forKey: "currentUserEmail")
            defaults.setObject(currentlyLoggedIn!.password, forKey: "currentUserPassword")
            defaults.synchronize()
            
            
        }*/
        
    }
    
    func login(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        
        let user = ["email":email,"password":password]
        
        //remember a request has 4 things:
        //1: A endpoint
        //2: A method
        //3: input data (optional)
        //4: A response
        let request = self.createMutableAnonRequest(NSURL(string: "https://ox-backend.herokuapp.com/auth/sign_in"), method: "POST", parameters: user)

        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
        
            print(json)
            var user:User = User(token: "", client:"")
            
            if (responseCode/100 == 2)   {
            
                
                user.email = json["data"]["email"].stringValue
                user.password = "not_given_and_not_stored"
                user = User(token:json["data"]["token"].stringValue, client:json["data"]["client"].stringValue)
            
                self.currentlyLoggedIn = user
                
                let defaults = NSUserDefaults.standardUserDefaults()
                
                defaults.setObject(self.currentlyLoggedIn!.email, forKey: "currentUserEmail")
                defaults.setObject(self.currentlyLoggedIn!.password, forKey: "currentUserPassword")
                defaults.synchronize()

                onCompletion(user,nil)
            }   else    {
                //the web service to create a user failed. Lets extract the error message to be displayed
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                //execute the closure in the ViewController
                onCompletion(nil,errorMessage)
            }
        })
        
        /*var existingUser: User? = nil
        
        // verify that the login info matches an existing user
        for index in 0 ..< registeredUsers.count {
            if (email == registeredUsers[index].email && password == registeredUsers[index].password) {
                existingUser = registeredUsers[index]
                break
            }
        }
        
        if existingUser != nil {
            
            onCompletion(existingUser, nil)
            currentlyLoggedIn = currentUser
            
            // set currentUserEmail and currentUserPassword
            let defaults = NSUserDefaults.standardUserDefaults()
            
            defaults.setObject(currentlyLoggedIn!.email, forKey: "currentUserEmail")
            defaults.setObject(currentlyLoggedIn!.password, forKey: "currentUserPassword")
            defaults.synchronize()
            
        }
        else {
            
            onCompletion(nil, "Username or password is incorrect.")
            
        }*/
        
    }
    
    func logout(onCompletion onCompletion: (String?) -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
    
        defaults.removeObjectForKey("currentUserEmail")
        defaults.removeObjectForKey("currentUserPassword")
        defaults.synchronize()
    
        currentlyLoggedIn = nil
        
        onCompletion("logged out")

    }

}

