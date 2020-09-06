//
//  JokeViewModel.swift
//  dad-joke
//
//  Created by jerald on 7/9/20.
//

import Foundation
import Combine

protocol JokeViewModelProtocol {
  var joke: String { get set }
  var errorMessage: String { get set }
  var isLoading: Bool { get set }
  func getRandomJoke()
}

class JokeViewModel: ObservableObject, Identifiable, JokeViewModelProtocol {
  
  @Published var joke: String = ""
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  
  var service: JokeService?
  var cancellables = Set<AnyCancellable>()
  
  init(service: JokeService) {
    self.service = service
  }
  
  func getRandomJoke() {
    isLoading = true
    service?.randomJoke()
      .print()
      .sink(receiveCompletion: { [weak self] completion in
        self?.isLoading = false
        switch completion {
          case .finished:
            break
          case .failure(let error):
            self?.errorMessage = error.localizedDescription
            break
        }
      }, receiveValue: { [weak self] value in
        self?.joke = value.joke ?? ""
      })
      .store(in: &cancellables)
  }
}


