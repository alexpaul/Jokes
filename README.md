# Jokes

Using URLSession to fetch web API data.


Here we are using URLSession to fetch data from the Jokes API.
```swift 
static func fetchJokes(completion: @escaping (Result<[Joke], NetworkError>) -> ()) {
    let endpointURLString = "https://official-joke-api.appspot.com/jokes/programming/ten"
    
    // creating a URL from the given endpoint string above
    guard let url = URL(string: endpointURLString) else {
      completion(.failure(.badURL(endpointURLString)))
      return
    }
    
    // Use URLSession to get back JSON data (GET request) from the Jokes web API
    
    // by default URLSession dataTask is suspended - meaning request is pending
    // to perform request you have to resume() the dataTask
    let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      // check for errors
      if let error = error { // if error is nil there was no network error
        completion(.failure(.networkClientError(error)))
      }
      
      // downcast to HTTPURLResponse to get access to the statusCode
      guard let urlResponse = response as? HTTPURLResponse else {
        completion(.failure(.noResponse))
        return
      }
      
      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      
      // find out what's the status code
      switch urlResponse.statusCode { // statusCode in an Int
      case 200...299: break // everything went well
      default:
        completion(.failure(.badStatusCode(urlResponse.statusCode)))
      }
      
      // use data to create our Joke model
      do {
        let jokes = try JSONDecoder().decode([Joke].self, from: data)
        completion(.success(jokes))
      } catch {
        completion(.failure(.decodingError(error)))
      }
    }
    dataTask.resume()
  }
```
