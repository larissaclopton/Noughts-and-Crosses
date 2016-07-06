//
//  OXGame.swift
//  o_X
//
//  Created by Larissa Clopton on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

enum CellType : String {
    
    case O = "O"
    case X = "X"
    case Empty = ""
    
}

enum OXGameState {
    
    case InProgress
    case Tie
    case Won
    case Open
    case Abandoned
    
}

class OXGame: NSObject {
    
    var ID: Int = 0
    var host: String = ""
    
    var board = Array(count: 9, repeatedValue: CellType.Empty)
    var startType = CellType.X
    
    // X is the first player
    var currentPlayer = CellType.X
    
    override init()  {
        super.init()
        
    }
    func getTurn() -> Int{
        var turns = 0
        for cell in board{
            if cell == CellType.O || cell == CellType.X{
                turns+=1
            }
        }
        return turns
    }
    func deserialiseBoard(boardString: String) {
        
        var tempBoard = [CellType]()
        
        for item in boardString.characters {
            if (item == "x") {
                tempBoard += [CellType.X]
            }
            else if (item == "o") {
                tempBoard += [CellType.O]
            }
            else {
                tempBoard += [CellType.Empty]
            }
        }
        self.board = tempBoard
        return
        
    }
    
    func serialiseBoard() -> String {
        
        var boardString = ""
        
        for type in self.board {
            if (type == CellType.X) {
                boardString += "x"
            }
            else if (type == CellType.O) {
                boardString += "o"
            }
            else {
                boardString += "_"
            }
        }
        
        return boardString
    }
    
    func turnCount() -> Int {
        // returns the number of counts in a game
        return getTurn()
    }
    
    func whoseTurn() -> CellType {
        // return CellType of whose turn it is
        if getTurn()%2 == 0{
         return CellType.X
        }
        else {
         return  CellType.O
        }
    }

    func playMove(cellNumber: Int) -> CellType {
        
        board[cellNumber] = whoseTurn()
        
        return board[cellNumber]
    }
    
    func gameWon() -> Bool {
        // return true if a player has won
        return  (board[0] != .Empty && board[0] == board[1] && board[1] == board[2]) ||
                (board[3] != .Empty && board[3] == board[4] && board[4] == board[5]) ||
                (board[6] != .Empty && board[6] == board[7] && board[7] == board[8]) ||
                (board[0] != .Empty && board[0] == board[3] && board[3] == board[6]) ||
                (board[1] != .Empty && board[1] == board[4] && board[4] == board[7]) ||
                (board[2] != .Empty && board[2] == board[5] && board[5] == board[8]) ||
                (board[0] != .Empty && board[0] == board[4] && board[4] == board[8]) ||
                (board[2] != .Empty && board[2] == board[4] && board[4] == board[6])
    }
    
    func state() -> OXGameState {
        // return the state of the game
        if(gameWon()) {
            return OXGameState.Won
        }
        if(turnCount() >= 9) {
            return OXGameState.Tie
        }
        else {
            return OXGameState.InProgress
        }
    }
    
    func reset() {
        // reset all cells to be empty and the turn count to be 0
        board = Array(count: 9, repeatedValue: CellType.Empty)
        currentPlayer = CellType.X
    }

}