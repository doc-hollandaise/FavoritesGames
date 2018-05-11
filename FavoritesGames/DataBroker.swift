//
//  DataBroker.swift
//  FavoritesGames
//
//  Created by Derek Justus on 5/9/18.
//  Copyright © 2018 Derek Justus. All rights reserved.
//

import Foundation


class Game : Codable {
    let name: String
    let url: String?
    let id: Int
    let cover: GameCover?
    let summary: String?
}

class GameCover : Codable {
    let url: String?
    var imagePath: String? {
        if var imgURL = url {
            if !imgURL.starts(with: "http:") {
                imgURL = "http:\(imgURL)"
            }
            
            if imgURL.range(of: "t_thumb") != nil {
                imgURL = imgURL.replacingOccurrences(of: "t_thumb", with: "t_cover_small_2x")
            }
            
            return imgURL
        } else {
            return url
        }
    }
}

class DataBroker {
    func getGames(completionHandler: @escaping (_ response: [Game]?, _ error: String?    ) -> Void)  {
        var request = URLRequest(url: URL(string: "https://api-endpoint.igdb.com/games/?fields=name,summary,cover,url&filter[release_dates.date]&filter[rating][gt]=75&order=release_dates.date:desc&limit=50")!)
        request.addValue("1631cd9547933145c916e1d78fd2f437", forHTTPHeaderField: "user-key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 10
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completionHandler(nil, error?.localizedDescription)
                return
            }
            if let newData = data {
                print(String(data: newData, encoding: .utf8)!)
                
                let decoder = JSONDecoder()
                 let games = try! decoder.decode([Game].self, from: newData)
                completionHandler(games, nil)
             
            } else {
                completionHandler(nil, "Error getting data!")
            }
            
        }
        task.resume()
    }
    
    func search(forGame game: String, completionHandler: @escaping (_ response: [Game]?, _ error: String?    ) -> Void)  {
        var request = URLRequest(url: URL(string: "https://api-endpoint.igdb.com/games/?search=\(game)&fields=name,summary,cover,url&limit=25&expand=game")!)
        request.addValue("1631cd9547933145c916e1d78fd2f437", forHTTPHeaderField: "user-key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 10
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completionHandler(nil, error?.localizedDescription)
                return
            }
            if let newData = data {
                print(String(data: newData, encoding: .utf8)!)
                
                let decoder = JSONDecoder()
                let games = try! decoder.decode([Game].self, from: newData)
                completionHandler(games, nil)
                
            } else {
                completionHandler(nil, "Error getting data!")
            }
            
        }
        task.resume()
    }
}
