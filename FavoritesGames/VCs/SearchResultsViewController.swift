//
//  SearchResultsViewController.swift
//  FavoritesGames
//
//  Created by Derek Justus on 5/10/18.
//  Copyright © 2018 Derek Justus. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    var games: Array<Game>!
     var dataController:DataController!
    
    @IBOutlet weak var gameTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchResultsViewController : UITableViewDelegate, UITableViewDataSource {
    
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
