//
//  ViewController.swift
//  Jokes
//
//  Created by Alex Paul on 12/3/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadJokes()
  }
  
  func loadJokes() {
    // trailing closure syntax
    JokesAPIClient.fetchJokes { [weak self] result in
      switch result {
      case .failure(let error):
        // show a UIAlertController to present to the user
        self?.showAlert(title: "Network Error", message: "\(error)")
      case .success(let jokes):
        dump(jokes)
      }
    }
  }
  
  func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: "Network Error", message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(okAction)
    // always update UI on the Main thread
    DispatchQueue.main.async {
      self.present(alertController, animated: true, completion: nil)
    }
  }
}

