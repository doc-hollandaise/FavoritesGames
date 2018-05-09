//
//  DataBroker.swift
//  FavoritesGames
//
//  Created by Derek Justus on 5/9/18.
//  Copyright © 2018 Derek Justus. All rights reserved.
//

import Foundation


struct Game : Codable {
    let name: String
    let url: String?
}

class DataBroker {
    func getGames(completionHandler: @escaping (_ response: [Game]?, _ error: String?    ) -> Void)  {
        var request = URLRequest(url: URL(string: "https://api-endpoint.igdb.com/games/?fields=*&filter[release_dates.date]&order=release_dates.date:desc")!)
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
                do {
                     let games = try? decoder.decode([Game].self, from: newData)
                   
                    completionHandler(games, nil)
                } catch {
                    fatalError("error trying to convert data to JSON")
                }
            } else {
                completionHandler(nil, "Error getting data!")
            }
            
        }
        task.resume()
    }
}
