//
//  ViewController.swift
//  BasicAnimations
//
//  Created by Tarık Fatih PINARCI on 21.05.2023.
//

import UIKit

class ViewController: UIViewController {
  var timingAnimationButton: UIButton!
  var springAnimationButton: UIButton!

  var imageView: UIImageView!
  var currentAnimation = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()

  }
  


  func setupUI() {
    view.backgroundColor = .white

    springAnimationButton = UIButton()

    springAnimationButton.translatesAutoresizingMaskIntoConstraints = false

    springAnimationButton.addTarget(self, action: #selector(onSpringAnimation), for: .touchUpInside)

    springAnimationButton.setTitleColor(.black, for: .normal)

    springAnimationButton.backgroundColor = .cyan

    springAnimationButton.setTitle("Spring", for: .normal)


    timingAnimationButton = UIButton()

    timingAnimationButton.translatesAutoresizingMaskIntoConstraints = false

    timingAnimationButton.addTarget(self, action: #selector(onTimingAnimation), for: .touchUpInside)

    timingAnimationButton.setTitleColor(.black, for: .normal)

    timingAnimationButton.backgroundColor = .cyan

    timingAnimationButton.setTitle("Timing", for: .normal)

    imageView = UIImageView(image: UIImage(named: "penguin"))

    imageView.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(timingAnimationButton)
    view.addSubview(springAnimationButton)
    view.addSubview(imageView)

    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

      timingAnimationButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 4),
      timingAnimationButton.heightAnchor.constraint(equalToConstant: 100),
      timingAnimationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      timingAnimationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

      springAnimationButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 4),
      springAnimationButton.heightAnchor.constraint(equalToConstant: 100),
      springAnimationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      springAnimationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])




  }

  @objc func onTimingAnimation() {
    // hide button on animation start
    timingAnimationButton.isHidden = true


    UIView.animate(withDuration: 0.5, delay: 0, animations: {
      switch self.currentAnimation {
      case 0:
        self.imageView.transform = .init(scaleX: 2, y: 2)
        break;
      case 1:
        self.imageView.transform = .identity
      case 2:
        self.imageView.transform = .init(translationX: 100, y: 100)
      case 3:
        self.imageView.transform = .identity
      case 4:
        self.imageView.transform = .init(rotationAngle: .pi)
      case 5:
        self.imageView.transform = .identity
      case 6:
        self.imageView.alpha = 0.1
        self.imageView.backgroundColor = .green
      case 7:
        self.imageView.alpha = 1
        self.imageView.backgroundColor = .clear
      default:
        break;
      }
    }) {
      finished in
      self.timingAnimationButton.isHidden = false
    }

    currentAnimation += 1

    if currentAnimation > 7 {
      currentAnimation = 0
    }

  }

  @objc func onSpringAnimation() {
    // hide button on animation start
    springAnimationButton.isHidden = true

    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 5, animations: {

      switch self.currentAnimation {
      case 0:
        self.imageView.transform = .init(scaleX: 2, y: 2)
        break;
      case 1:
        self.imageView.transform = .identity
      case 2:
        self.imageView.transform = .init(translationX: 100, y: 100)
      case 3:
        self.imageView.transform = .identity
      case 4:
        self.imageView.transform = .init(rotationAngle: .pi)
      case 5:
        self.imageView.transform = .identity
      case 6:
        self.imageView.alpha = 0.1
        self.imageView.backgroundColor = .green
      case 7:
        self.imageView.alpha = 1
        self.imageView.backgroundColor = .clear
      default:
        break;
      }
    }) {
      finished in
      self.springAnimationButton.isHidden = false
    }

    currentAnimation += 1

    if currentAnimation > 7 {
      currentAnimation = 0
    }

  }


}

