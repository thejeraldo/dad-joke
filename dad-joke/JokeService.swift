//
//  JokeService.swift
//  dad-joke
//
//  Created by jerald on 7/9/20.
//

import Foundation
import Combine

protocol JokeServiceProtocol {
  func randomJoke() -> AnyPublisher<Joke, JokeError>
}

struct JokeService {
  func randomJoke() -> AnyPublisher<Joke, JokeError> {
    let api = API.random
    let req = RequestManager.request(api: api, resultType: Joke.self)
      .mapError({ err in JokeError.error(err as NSError) })
      .eraseToAnyPublisher()
    return req
  }
}
