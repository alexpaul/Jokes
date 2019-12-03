//
//  JokesTests.swift
//  JokesTests
//
//  Created by Alex Paul on 12/3/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import XCTest
@testable import Jokes

class JokesTests: XCTestCase {

  func testJokeModel() {
    // arrange
    let jsonData = """
    [
    {
        "id": 379,
        "type": "programming",
        "setup": "A programmer puts two glasses on his bedside table before going to sleep.",
        "punchline": "A full one, in case he gets thirsty, and an empty one, in case he doesn’t."
    },
    {
        "id": 23,
        "type": "programming",
        "setup": "Why do programmers always mix up Halloween and Christmas?",
        "punchline": "Because Oct 31 == Dec 25"
    }]
    """.data(using: .utf8)!
    let expectedJokesCount = 2
    
    // act
    do {
      let jokes = try JSONDecoder().decode([Joke].self, from: jsonData)
      XCTAssertEqual(jokes.count, expectedJokesCount, "there should be \(expectedJokesCount) jokes created")
    } catch {
      XCTFail("decoding error: \(error)")
    }
  }

}
