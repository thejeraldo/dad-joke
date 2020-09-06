//
//  Joke.swift
//  dad-joke
//
//  Created by jerald on 7/9/20.
//

import Foundation

struct Joke: Codable, Identifiable {
  let id: String
  let joke: String
  let status: Int
}
