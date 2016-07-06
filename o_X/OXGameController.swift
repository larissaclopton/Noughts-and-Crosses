//
//  OXGameController.swift
//  o_X
//
//  Created by Larissa Clopton on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class OXGameController: WebService {
    
    static var sharedInstance = OXGameController()
    private var currentGame = OXGame()
    
    func getCurrentGame() -> OXGame {
        return currentGame
    }
    
    func restartGame() {
        currentGame.reset()
    }
    
    func playMove(cellNumber: Int) -> CellType {
        return currentGame.playMove(cellNumber)
    }
    
    func getGames(onCompletion onCompletion: ([OXGame]?, String?) -> Void) {
        
        let request = createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games"), method: "GET", parameters: nil)
        
        executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode/100 == 2)   {
            
                var list:[OXGame] = []
                
                for game in json.arrayValue {
                    
                    let newGame = OXGame()
                    newGame.ID = game["id"].intValue
                    newGame.host = game["host_user"]["uid"].stringValue
                    
                    list.append(newGame)
                    
                }
                
                onCompletion(list,nil)
            }
            else {
                //the web service to create a user failed. Lets extract the error message to be displayed
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                print(errorMessage)
                //execute the closure in the ViewController
                onCompletion(nil,errorMessage)
            }
        })
        
    }
    
    func hostGame(onCompletion onCompletion: (OXGame?, String?) -> Void) {
        
        let request = createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/"), method: "POST", parameters: nil)
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            print(json)
            
            if (responseCode/100 == 2) {
                
                let newGame = OXGame()
                
                newGame.ID = json["id"].intValue
                newGame.host = json["host_user"]["uid"].stringValue
                newGame.deserialiseBoard(json["board"].stringValue)
                
                OXGameController.sharedInstance.currentGame = newGame
                
                onCompletion(OXGameController.sharedInstance.currentGame, nil)
            }
            else {
                
                //the web service to create a user failed. Lets extract the error message to be displayed
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                print(errorMessage)
                //execute the closure in the ViewController
                onCompletion(nil,errorMessage)
                
            }
        })
        
    }
    
    func acceptGame(gameID: String, onCompletion: (OXGame?, String?) -> Void) {
        
        let request = createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(gameID)/join"), method: "GET", parameters: nil)
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            print(json)
    
            if (responseCode/100 == 2) {
                
                let newGame = OXGame()
                
                newGame.ID = json["id"].intValue
                newGame.host = json["host_user"]["uid"].stringValue
                newGame.deserialiseBoard(json["board"].stringValue)
                
                OXGameController.sharedInstance.currentGame = newGame
                
                onCompletion(OXGameController.sharedInstance.currentGame, nil)
            }
            else {
                
                //the web service to create a user failed. Lets extract the error message to be displayed
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                print(errorMessage)
                //execute the closure in the ViewController
                onCompletion(nil,errorMessage)
                
            }
        })

        
    }
    
    func playMove(onCompletion: () -> Void) {
        
        let game = OXGameController.sharedInstance.currentGame
        
        let boardString =  game.serialiseBoard()
        
        let gameID = String(game.ID)
        
        let boardStatus = ["board":boardString]
        
        let request = createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(gameID)"), method: "PUT", parameters: boardStatus)
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            print(json)
            
            if (responseCode/100 == 2) {
               
               onCompletion()
               
            }
        else {
    
            onCompletion()
    
        }

        })

    }
    
    func getGame(onCompletion: (String?) -> Void) {
    
        let game = OXGameController.sharedInstance.currentGame
        
        let gameID = String(game.ID)
        
        let request = createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(gameID)"), method: "GET", parameters: nil)
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            print(json)
            
            if (responseCode/100 == 2) {
                
                game.deserialiseBoard(json["board"].stringValue)
                onCompletion(nil)
                
            }
            else {
                
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                onCompletion(errorMessage)
                
            }

         
        })

    }

}
