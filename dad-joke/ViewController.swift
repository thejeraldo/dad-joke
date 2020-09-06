//
//  ViewController.swift
//  dad-joke
//
//  Created by jerald on 7/9/20.
//

import UIKit
import Combine

class ViewController: UIViewController {
  
  // MARK: - UI Properties
  
  @IBOutlet weak var jokeLabelBackground: UIView!
  @IBOutlet weak var jokeLabel: UILabel!
  @IBOutlet weak var newJokeButton: UIButton! {
    didSet {
      newJokeButton.layer.cornerRadius = 16
      newJokeButton.layer.cornerCurve = .continuous
      newJokeButton.backgroundColor = .systemBlue
      newJokeButton.setTitleColor(.white, for: .normal)
    }
  }
  @IBOutlet weak var shareButton: UIButton! {
    didSet {
      shareButton.backgroundColor = .clear
    }
  }
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  
  // MARK: - Properties
  
  let vm = JokeViewModel(service: JokeService())
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - View Controller Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    jokeLabel.text = ""
    errorLabel.text = ""
    setupBindings()
    getNewJoke()
  }
  
  // MARK: - Setup
  
  private func setupBindings() {
    vm.$isLoading.sink { [weak self] isLoading in
      self?.loadingIndicator.isHidden = !isLoading
      self?.newJokeButton.isEnabled = !isLoading
    }.store(in: &cancellables)
    
    vm.$errorMessage.sink { [weak self] errorMessage in
      self?.errorLabel.text = errorMessage
    }.store(in: &cancellables)
    
    vm.$joke.sink { [weak self] joke in
      UIView.animate(withDuration: 0.3) {
        self?.jokeLabel.alpha = 0
      } completion: { _ in
        self?.jokeLabel.alpha = 1
        self?.jokeLabel.text = joke
      }
    }.store(in: &cancellables)
  }
  
  // MARK: - Actions
  
  private func getNewJoke() {
    vm.getRandomJoke()
  }
  
  @IBAction func didTapNewJoke() {
    getNewJoke()
  }
}

