//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {
    
    var gameObject = OXGame()
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var boardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func newGameButtonTapped(sender: UIButton) {
        print("Let's play a new game!")
    }
    
    @IBAction func cellTapped(sender: UIButton){
        print("Cell \(sender.tag) has been tapped")
        gameObject.playMove(sender.tag)
    }
    
    @IBAction func logoutTapped(sender: UIButton) {
        print("Time to logout!")
    }
    
    // TODO: action for back/logout button?, using gameWon and displaying message after win, using state, what to do with OXGameState?
    
}

