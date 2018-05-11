//
//  FavoritesViewController.swift
//  FavoritesGames
//
//  Created by Derek Justus on 5/10/18.
//  Copyright © 2018 Derek Justus. All rights reserved.
//

import UIKit

class FavoritesViewController : ViewController{
    var dataController:DataController!
    var games: [Game]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabbar = self.tabBarController as! FGTabBarController
        dataController = tabbar.dataController
    }
}
