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
    
    
    
    func hostGame() {
        
        let request = createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/"), method: "POST", parameters: nil)
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            print(json)
            
            if (responseCode/100 == 2) {
                
                var newGame = OXGame()
                
                newGame.ID = json["id"].intValue
                newGame.host = json["host_user"]["uid"].stringValue
                newGame.updateBoard(json["board"].stringValue)
                
                OXGameController.sharedInstance.currentGame = newGame
                
                //onCompletion(,nil)
            }
            else {
                
                
            }
        })
        
    }

}
