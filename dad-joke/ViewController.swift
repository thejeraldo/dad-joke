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
    vm.$isLoading
      .map { !$0 }
      .assign(to: \.isHidden, on: loadingIndicator)
      .store(in: &cancellables)
    
    vm.$isLoading
      .map { !$0 }
      .assign(to: \.isEnabled, on: newJokeButton)
      .store(in: &cancellables)
    
    vm.$errorMessage
      .assign(to: \.text!, on: errorLabel)
      .store(in: &cancellables)
    
    vm.$joke.sink { [weak self] joke in
      self?.jokeLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
      UIView.animate(withDuration: 1.0,
                     delay: 0.0,
                     usingSpringWithDamping: 0.5,
                     initialSpringVelocity: 0.2,
                     options: .curveEaseOut) {
        self?.jokeLabel.text = joke
        self?.jokeLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
      } completion: { _ in
        
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
  
  @IBAction func didTapShare() {
    guard let text = jokeLabel.text, !text.isEmpty else { return }
    let vc = UIActivityViewController(activityItems: [ text ], applicationActivities: nil)
    present(vc, animated: true, completion: nil)
  }
}

