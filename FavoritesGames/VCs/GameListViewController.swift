//
//  GameListViewController.swift
//  FavoritesGames
//
//  Created by Derek Justus on 5/9/18.
//  Copyright © 2018 Derek Justus. All rights reserved.
//

import UIKit
import CoreData

class GameListViewController: ViewController {
    
    @IBOutlet weak var gameTableView: UITableView!
    @IBOutlet weak var searchTextView: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBAction func search(_ sender: Any) {
        searchForGame()
    }
    
    var dataController:DataController!
    var games: Array<Game>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = self.tabBarController as! FGTabBarController
        dataController = tabbar.dataController
        
        let broker = DataBroker()
        startSpinner()
        broker.getGames(completionHandler: { games, error in
            self.stopSpinner()
            guard error == nil else {
                self.alertUser(withMessage: error!)
                return
            }
            
            self.games = games
            
            performUIUpdatesOnMain {
                self.gameTableView.reloadData()
            }
            
        })
    }
    
    func searchForGame() {
        dismissKeyboard()
        if let text = searchTextView.text {            
            let broker = DataBroker()
            broker.search(forGame: text, completionHandler: {games, error in
                performUIUpdatesOnMain {
                    if let nc = self.navigationController, let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchVC") as? SearchResultsViewController {
                        vc.games = games
                        vc.dataController = self.dataController
                        
                        nc.pushViewController(vc, animated: true)
                    }
                }
            })
        }
    }
    
    func dismissKeyboard() {
        self.searchTextView.resignFirstResponder()
    }
    
    
}

extension GameListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameListCell", for: indexPath) as! GameListCell
        if let gameList = games {
            let game = gameList[indexPath.row]
            cell.game = game
            cell.setupCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nc = self.navigationController, let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController, let gamesArray = games  {
            vc.game = gamesArray[indexPath.row]
            vc.dataController = dataController
            nc.pushViewController(vc, animated: true)
        }
    }

}

extension GameListViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
