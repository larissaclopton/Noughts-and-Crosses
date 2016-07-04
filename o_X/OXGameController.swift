//
//  OXGameController.swift
//  o_X
//
//  Created by Larissa Clopton on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class OXGameController {
    
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
        
        let gameOne = OXGame()
        let gameTwo = OXGame()
        let gameThree = OXGame()
        
        // this will be updated for internet play
        onCompletion([gameOne, gameTwo, gameThree], nil)
        
    }

}
