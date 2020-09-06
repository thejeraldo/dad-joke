//
//  Joke.swift
//  dad-joke
//
//  Created by jerald on 7/9/20.
//

import Foundation

struct Joke: Codable, Identifiable {
  var id: String?
  var joke: String?
  var status: Int
  var message: String?
}

enum JokeError: Error, LocalizedError {
  case error(_ error: NSError)
  
  var errorDescription: String? {
    switch self {
      case .error(let error):
        if error.code == -1009 { return "There is no internet connection." }
        return "Something went wrong."
    }
  }
}
