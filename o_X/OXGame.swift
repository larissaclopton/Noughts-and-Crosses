//
//  OXGame.swift
//  o_X
//
//  Created by Larissa Clopton on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

enum CellType : String {
    
    case O = "O"
    case X = "X"
    case Empty = ""
    
}

enum OXGameState {
    
    case InProgress
    case Tie
    case Won
    
}

class OXGame {
    
    // initial board of 9 empty cells
    private var board:[CellType] = [CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty]
    
    private var startType:CellType = CellType.X
    
    var numTurns:Int = 0
    
    // might need to change this
    // X is the first player
    var currentPlayer:CellType = CellType.X
    
    func turnCount() -> Int {
        // returns the number of counts in a game
        return self.numTurns
        
    }
    
    func whoseTurn() -> CellType {
        // return CellType of whose turn it is
        return self.currentPlayer
        // should this alternate here or somewhere else?
        /*if(currentPlayer == CellType.O) {
            return CellType.X
        }
        else {
            return CellType.O
        }*/
    }
    
    func playMove(cellNumber: Int) -> CellType {
        board[cellNumber] = self.currentPlayer
        return self.currentPlayer
    }
    
    func gameWon() -> Bool {
        // return true if a player has won
        // winning cases - 123, 456, 789, 147, 258, 369, 159, 357
        if(board[1] == board[2] == board[3]) {

}
    }
    
}