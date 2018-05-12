//
//  ViewController.swift
//  FavoritesGames
//
//  Created by Derek Justus on 5/9/18.
//  Copyright © 2018 Derek Justus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  var activityView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActivityView()
    }
    
    func setupActivityView() {
        activityView = UIActivityIndicatorView(frame: self.view.frame)
        activityView.activityIndicatorViewStyle = .gray
        activityView.hidesWhenStopped = true
        activityView.isHidden = true
        view.addSubview(activityView)
        view.bringSubview(toFront: activityView)        
    }
    
    func startSpinner() {
        performUIUpdatesOnMain {
            self.activityView.isHidden = false
            self.activityView.startAnimating()
        }
    }
    
    func stopSpinner() {
        performUIUpdatesOnMain {
            self.activityView.stopAnimating()
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alertUser(withMessage message:String) {
        performUIUpdatesOnMain {
            let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }


}

