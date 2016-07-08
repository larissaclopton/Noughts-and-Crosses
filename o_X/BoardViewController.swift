//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {
    
    var networkMode: Bool = false
    
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
    @IBOutlet weak var button9:
        UIButton!
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    @IBOutlet weak var gameStateMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide the new game button
        if (networkMode) {
        
            let defaults = NSUserDefaults.standardUserDefaults()
            
            let game = OXGameController.sharedInstance.getCurrentGame()
            
            if game.host == defaults.stringForKey("currentUserEmail") {
            
                gameStateMessage.text = "Play your move"
                
            }
            else {
                
                gameStateMessage.text = "Waiting for opponent"
                
            }
        }
        else {
            newGameButton.hidden = true
        }
        
        
        // setup the board
        updateUI()
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
        
        // clear the board
        cancelGame()
        
        // hide the new game button
        newGameButton.hidden = true
    }
    
    @IBAction func cellTapped(sender: UIButton){
        
        let testPlayMove = {(message: String?) in
            
            if message == "invalid move" {
                
                let game = OXGameController.sharedInstance.getCurrentGame()
                
                    let illegalMoveAlert = UIAlertController(title: "Cannot play move", message: "Please wait your turn.", preferredStyle:UIAlertControllerStyle.Alert)
                    
                    let alertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    
                    illegalMoveAlert.addAction(alertAction)
                    
                    game.board[sender.tag] = CellType.Empty
                    
                    self.presentViewController(illegalMoveAlert, animated: true, completion: nil)
                    
            }
            else {
                
                self.updateUI()
                self.gameStateMessage.text = "Waiting for opponent"
                
            }
            
        }
        
            // if illegal move, display an alert
            if OXGameController.sharedInstance.getCurrentGame().board[sender.tag] != CellType.Empty {
                
                let illegalMoveAlert = UIAlertController(title: "Illegal Move", message: "Square already filled, please play again.", preferredStyle:UIAlertControllerStyle.Alert)
                
                let alertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                
                illegalMoveAlert.addAction(alertAction)
                
                self.presentViewController(illegalMoveAlert, animated: true, completion: nil)
                
                return
            }
            // otherwise, play move and set button title
            else {
                if (self.networkMode) {
                    
                    OXGameController.sharedInstance.playMove(sender.tag)
                    
                    OXGameController.sharedInstance.playMove(testPlayMove)
                    
                }
                else {
                    sender.setTitle(OXGameController.sharedInstance.playMove(sender.tag).rawValue, forState: UIControlState.Normal)
                }
            
            // retrieve the current game state
            let gameState = OXGameController.sharedInstance.getCurrentGame().state()
        
            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                if self.networkMode == false {
                    self.newGameButton.hidden = false
                }
            })
        
            // display alerts for ties and wins
            if (gameState == OXGameState.Tie) {
                
                let tieAlert = UIAlertController(title: "Game Over", message: "It's a tie", preferredStyle:UIAlertControllerStyle.Alert)
                
                tieAlert.addAction(alertAction)
                
                self.presentViewController(tieAlert, animated: true, completion: nil)
                
                refreshButton.enabled = false
                
            }
            else if (gameState == OXGameState.Won) {
                
                let game = OXGameController.sharedInstance.getCurrentGame()
                
                let winAlert = UIAlertController(title: "Game Over", message: "\(game.currentPlayer) won", preferredStyle:UIAlertControllerStyle.Alert)
                
                winAlert.addAction(alertAction)
                
                self.presentViewController(winAlert, animated: true, completion: nil)
                
                refreshButton.enabled = false
                
            }
        }
    }
    
    @IBAction func logoutTapped(sender: UIButton) {
        
        let logoutMessage = {(message: String?) in
            
        }
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        let application = UIApplication.sharedApplication()
        let window = application.keyWindow
        window?.rootViewController = viewController

        UserController.sharedInstance.logout(onCompletion: logoutMessage)
        
    }
    
    
    @IBAction func cancelNetworkGame(sender: UIBarButtonItem) {
        
        OXGameController.sharedInstance.cancelGame() {
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
    }
    
    @IBAction func refreshNetworkGame(sender: UIBarButtonItem) {
        
        let refreshMessage = {(message: String?) in
            self.updateUI()
            let game = OXGameController.sharedInstance.getCurrentGame()
            
            if message == "in_progress" {
                
                if OXGameController.sharedInstance.getCurrentGame().whoseTurn() == game.currentPlayer {
                    self.gameStateMessage.text = "Play your move"
                }
                else {
                    self.gameStateMessage.text = "Waiting for opponent"
                }
            }
            else if message == "abandoned" {
                self.gameStateMessage.text = "Game canceled"
                sender.enabled = false
            }
            
            switch OXGameController.sharedInstance.getCurrentGame().state() {
            case .Won:
                var winner = CellType.X.rawValue
                if (game.currentPlayer == CellType.X) {
                    winner = CellType.O.rawValue
                }
                
                let winAlert = UIAlertController(title: "Game Over", message: "\(winner) won", preferredStyle:UIAlertControllerStyle.Alert)
                let dismissAlert = UIAlertAction(title: "Dismiss", style: .Default, handler: {(action) in
                    if (!self.networkMode) {
                        self.newGameButton.hidden = false
                    }
                    else {
                        self.gameStateMessage.text = "Game ended"
                        sender.enabled = false
                    }
                })
                
                winAlert.addAction(dismissAlert)
                self.presentViewController(winAlert, animated: true, completion: nil)
                return
                
            case .Tie:
                let tieAlert = UIAlertController(title: "Game Over", message: "It's a tie", preferredStyle:UIAlertControllerStyle.Alert)
                
                let dismissAlert = UIAlertAction(title: "Dismiss", style: .Default, handler: {(action) in
                    if (!self.networkMode) {
                        self.newGameButton.hidden = false
                    }
                    else {
                        self.gameStateMessage.text = "Game ended"
                        sender.enabled = false
                    }
                })
                
                tieAlert.addAction(dismissAlert)
                self.presentViewController(tieAlert, animated: true, completion: nil)
                return
            default:
                // do nothing
                break
            }
        }
        
        OXGameController.sharedInstance.getGame(refreshMessage)
    
    }
    
    
    func updateUI() {
        
        let game = OXGameController.sharedInstance.getCurrentGame()
        
        button1.setTitle(game.board[0].rawValue, forState: UIControlState.Normal)
        button2.setTitle(game.board[1].rawValue, forState: UIControlState.Normal)
        button3.setTitle(game.board[2].rawValue, forState: UIControlState.Normal)
        button4.setTitle(game.board[3].rawValue, forState: UIControlState.Normal)
        button5.setTitle(game.board[4].rawValue, forState: UIControlState.Normal)
        button6.setTitle(game.board[5].rawValue, forState: UIControlState.Normal)
        button7.setTitle(game.board[6].rawValue, forState: UIControlState.Normal)
        button8.setTitle(game.board[7].rawValue, forState: UIControlState.Normal)
        button9.setTitle(game.board[8].rawValue, forState: UIControlState.Normal)
        
    }
    
}

