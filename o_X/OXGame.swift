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
    
}

class OXGame: NSObject {
    
    var ID: Int = 436030
    var host: String = "Anyone"
    
    var board = Array(count: 9, repeatedValue: CellType.Empty)
    var startType = CellType.X
    var numTurns = 0
    
    // X is the first player
    var currentPlayer = CellType.X
    
    override init()  {
        super.init()
        //we are simulating setting our board from the internet
        let simulatedBoardStringFromNetwork = "xo_x_o__x" //update this string to different values to test your model serialisation
        self.board = deserialiseBoard(simulatedBoardStringFromNetwork) //your OXGame board model should get set here
        if(simulatedBoardStringFromNetwork == serialiseBoard())    {
            print("start\n------------------------------------")
            print("congratulations, you successfully deserialised your board and serialized it again correctly. You can send your data model over the internet with this code. 1 step closer to network OX ;)")
            
            print("done\n------------------------------------")
        }   else    {
            print("start\n------------------------------------")
            print ("your board deserialisation and serialization was not correct :( carry on coding on those functions")
            
            print("done\n------------------------------------")
        }
        
    }
    
    private func deserialiseBoard(boardString: String) -> [CellType] {
        
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
        
        return tempBoard
        
    }
    
    private func serialiseBoard() -> String {
        
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
        return numTurns
    }
    
    func whoseTurn() -> CellType {
        // return CellType of whose turn it is
        return currentPlayer
    }
    
    func updateTurn() {
        // update currentPlayer to other player
        if(currentPlayer == CellType.O) {
            currentPlayer = CellType.X
        }
        else {
            currentPlayer = CellType.O
        }
    }
    
    func playMove(cellNumber: Int) -> CellType {
        
        board[cellNumber] = whoseTurn()
        numTurns += 1
        updateTurn()
        
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
        numTurns = 0
        currentPlayer = CellType.X
    }
}