//
//  NetworkGamesTableViewController.swift
//  o_X
//
//  Created by Larissa Clopton on 7/4/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class NetworkGamesTableViewController: UITableViewController {
    
    var gameList: [OXGame] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OXGameController.sharedInstance.getGames(onCompletion: {(games: [OXGame]?, message: String?) in
            
            if let game = games {
                self.gameList = game
                self.tableView.reloadData()
            }
            else {
                print(message)
            }
           
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newGame" {
            
            if let boardViewController = segue.destinationViewController as? BoardViewController {
                boardViewController.networkMode = true
            }
            
        }
    }
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("GameInfo", forIndexPath: indexPath)

        cell.textLabel?.text = " Game \(gameList[indexPath.row].ID) @ \(gameList[indexPath.row].host)"
    
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("newGame", sender: self)
        
    }

}
