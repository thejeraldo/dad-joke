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
