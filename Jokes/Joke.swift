//
//  Joke.swift
//  Jokes
//
//  Created by Alex Paul on 12/3/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct Joke: Decodable {
  let id: Int
  let type: String
  let setup: String
  let punchlin: String
}
