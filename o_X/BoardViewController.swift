//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {
    
    var gameObject = OXGame()
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var boardView: UIView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func cancelGame() {
        OXGameController.sharedInstance.restartGame()
        // set all button titles to empty
        button1.setTitle("", forState: UIControlState.Normal)
        button2.setTitle("", forState: UIControlState.Normal)
        button3.setTitle("", forState: UIControlState.Normal)
        button4.setTitle("", forState: UIControlState.Normal)
        button5.setTitle("", forState: UIControlState.Normal)
        button6.setTitle("", forState: UIControlState.Normal)
        button7.setTitle("", forState: UIControlState.Normal)
        button8.setTitle("", forState: UIControlState.Normal)
        button9.setTitle("", forState: UIControlState.Normal)
    }
    
    @IBAction func newGameButtonTapped(sender: UIButton) {
        print("Let's play a new game!")
        cancelGame()
    }
    
    @IBAction func cellTapped(sender: UIButton){
        print("Cell \(sender.tag) has been tapped")
        OXGameController.sharedInstance.playMove(sender.tag)
        sender.setTitle(String(gameObject.currentPlayer), forState: UIControlState.Normal)
        
        let gameState = gameObject.state()
        
        // game in progress
        if(gameState == OXGameState.InProgress) {
            return
        }
        
        // game has concluded
        if (gameState == OXGameState.Won) {
            print("We have a winner!")
        }
        else if (gameState == OXGameState.Tie) {
            print("It's a draw!")
        }
        
        cancelGame()
        
    }
    
    @IBAction func logoutTapped(sender: UIButton) {
        print("Time to logout!")
        // what to do here?
    }
    
    // TODO: action for back/logout button?, using gameWon and displaying message after win, using state, what to do with OXGameState?
    
}

