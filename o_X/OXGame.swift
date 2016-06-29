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

enum OXGameState: Int {
    
    case InProgress = 0
    case Tie = 2
    case Won = 1
    
}

class OXGame {
    
    // initial board of 9 empty cells
    private var board:[CellType] = Array(count: 9, repeatedValue: CellType.Empty)
    
    private var startType:CellType = CellType.X
    
    var numTurns:Int = 0
    
    // might need to change this
    // X is the first player
    var currentPlayer:CellType = CellType.X
    
    func turnCount() -> Int {
        // returns the number of counts in a game
        return numTurns
    }
    
    func whoseTurn() -> CellType {
        // return CellType of whose turn it is
        return currentPlayer
    }
    
    func updateTurn() {
        if(currentPlayer == CellType.O) {
            currentPlayer = CellType.X
        }
        else {
            currentPlayer = CellType.O
        }
    }
    
    func playMove(cellNumber: Int) -> CellType {
        // update the board based on the current player's move
        board[cellNumber] = whoseTurn()
        numTurns += 1
        updateTurn()
        return board[cellNumber]
    }
    
    func gameWon() -> Bool {
        // return true if a player has won
        // winning cases - 123, 456, 789, 147, 258, 369, 159, 357
        if((board[0] != CellType.Empty && (board[0], board[1]) == (board[1], board[2])) ||
            (board[3] != CellType.Empty && (board[3], board[4]) == (board[4], board[5])) ||
            (board[6] != CellType.Empty && (board[6], board[7]) == (board[7], board[8])) ||
            (board[0] != CellType.Empty && (board[0], board[3]) == (board[3], board[6])) ||
            (board[1] != CellType.Empty && (board[1], board[4]) == (board[4], board[7])) ||
            (board[2] != CellType.Empty && (board[2], board[5]) == (board[5], board[8])) ||
            (board[0] != CellType.Empty && (board[0], board[4]) == (board[4], board[8])) ||
            (board[2] != CellType.Empty && (board[2], board[4]) == (board[4], board[6]))) {
            return true
        }
        else {
            return false
        }
    }
    
    func state() -> OXGameState {
        // return the state of the game
        if(gameWon()) {
            return OXGameState.Won
        }
        if(turnCount() == 9) {
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
    }
}