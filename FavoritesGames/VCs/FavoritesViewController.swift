//
//  FavoritesViewController.swift
//  FavoritesGames
//
//  Created by Derek Justus on 5/10/18.
//  Copyright © 2018 Derek Justus. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController : ViewController, UITableViewDataSource, UITableViewDelegate {

    var dataController:DataController!
    var fetchedResultsController:NSFetchedResultsController<VideoGame>!

    @IBOutlet weak var newTable: UITableView!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let tabbar = self.tabBarController as! FGTabBarController
        dataController = tabbar.dataController
        tabbar.navigationItem.title = "FAVORITES"
        
        setupFetchedResultsController()
    }
    
    
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aGame = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        
        cell.gameName.text = aGame.name
        
        return cell
    }
    
    
}

extension FavoritesViewController : NSFetchedResultsControllerDelegate {
        
        fileprivate func setupFetchedResultsController() {
            let fetchRequest:NSFetchRequest<VideoGame> = VideoGame.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "addedDate", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "games")
            fetchedResultsController.delegate = self
            do {
                try? fetchedResultsController.performFetch()
                newTable.reloadData()
            } catch {
                fatalError("The fetch could not be performed: \(error.localizedDescription)")
            }
    }
}
