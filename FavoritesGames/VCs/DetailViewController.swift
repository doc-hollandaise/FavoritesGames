//
//  DetailViewController.swift
//  FavoritesGames
//
//  Created by Derek Justus on 5/10/18.
//  Copyright © 2018 Derek Justus. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController : ViewController {
    
    var dataController:DataController!
    var fetchedResultsController:NSFetchedResultsController<VideoGame>!
    
    var game: Game!
    
 
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var favImg: UIImageView!
    
    var isFav: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFetchedResultsController()
        
        self.navigationItem.title = game.name
        self.summaryLabel.text = game.summary
        
        fetchImage()        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        fetchedResultsController = nil
    }
    
    func fetchImage() {
        if let cover = game.cover, let url = cover.url {
            var path:String = url
            if let imgPath = cover.imagePath {
              path = imgPath
            }
                let fetcher = ImageFetcher()
                if let url = URL(string: path) {
                fetcher.imageFromUrl(url: url, completionHandler: { data, error in
                    if let err = error {
                        performUIUpdatesOnMain {
                            self.alertUser(withMessage: err)
                        }
                        return
                    }
                    if let imgData = data {
                        performUIUpdatesOnMain {
                            self.headerImage.image = UIImage(data: imgData)
                        }
                    }
                })
            }
        }
    }
    @IBAction func favTapped(_ sender: Any) {
        if isFav {
            // remove favorite
            removeFromFavorites()
        } else {
            // add favorite
            addGameToFavorites(game: game)
        }
    }
    
    
    
}

extension DetailViewController : NSFetchedResultsControllerDelegate {
    
    fileprivate func setupFetchedResultsController() {
        let fetchRequest:NSFetchRequest<VideoGame> = VideoGame.fetchRequest()
        let predicate = NSPredicate(format: "id == %i", game.id)
        fetchRequest.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "addedDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "games")
        fetchedResultsController.delegate = self
        do {
             try? fetchedResultsController.performFetch()
            if let games = fetchedResultsController.fetchedObjects {
                for obj in games {
                    if obj.id == game.id {
                        isFav = true
                        favImg.image = UIImage(named: "Favorite-selected")
                    }
                }
            }
          
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    func addGameToFavorites(game: Game) {
        let favorite = VideoGame(context: dataController.viewContext)
        favorite.gameDesc = game.summary
        favorite.name = game.name
        favorite.url = game.url
        favorite.id = Int64(game.id)
        try? dataController.viewContext.save()
    }
    
    func removeFromFavorites() {
        if let games = fetchedResultsController.fetchedObjects {
            for object in games {
                if object.id == game.id {
                    dataController.viewContext.delete(object)
                    try? dataController.viewContext.save()
                }
            }
        }
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
           isFav = true
           favImg.image = UIImage(named: "Favorite-selected")
            break
        case .delete:
            isFav = false
            self.favImg.image = UIImage(named: "addfavorite")
            break
        case .update:
           break
        case .move:
           break
        }
    }
    
}
