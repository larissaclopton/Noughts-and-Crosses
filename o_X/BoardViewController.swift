//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet weak var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func newGameButtonTapped(sender: UIButton) {
        print("New Game button has been tapped.")
    }
    
    @IBAction func cellTapped(sender: UIButton){
            print("Cell \(sender.tag) has been tapped")
    }
    

}

