//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {
    
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
        
        // restart the game
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
        cancelGame()
    }
    
    @IBAction func cellTapped(sender: UIButton){
        
        // play the move
        
        
        // set the button title
        sender.setTitle(OXGameController.sharedInstance.playMove(sender.tag).rawValue, forState: UIControlState.Normal)
        
        let gameState = OXGameController.sharedInstance.getCurrentGame().state()
        
        
        if(gameState != OXGameState.InProgress) {
            cancelGame()
        }
        
    }
    
    @IBAction func logoutTapped(sender: UIButton) {
        print("Time to logout!")
        // what to do here?
    }
    
    // TODO: action for back/logout button?, using gameWon and displaying message after win, using state, what to do with OXGameState?
    
}

