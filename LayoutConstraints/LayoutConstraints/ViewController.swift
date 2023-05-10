//
//  ViewController.swift
//  LayoutConstraints
//
//  Created by Tarık Fatih PINARCI on 10.05.2023.
//

import UIKit

class ViewController: UIViewController {
  var appLabels: [String] = ["label one", "label two", "label three"]
  var label1: UILabel!
  var label2: UILabel!
  var label3: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    label1 = {
      let label = UILabel()
      label.text = appLabels[0]
      label.backgroundColor = .blue
      label.translatesAutoresizingMaskIntoConstraints = false
      label.sizeToFit()
      return label
    }()

    label2 = {
      let label = UILabel()
      label.text = appLabels[1]
      label.backgroundColor = .orange
      label.translatesAutoresizingMaskIntoConstraints = false
      label.sizeToFit()
      return label
    }()

    label3 = {
      let label = UILabel()
      label.text = appLabels[2]
      label.backgroundColor = .cyan
      label.translatesAutoresizingMaskIntoConstraints = false
      label.sizeToFit()
      return label
    }()

    let shuffleButton: UIButton = {
      let button = UIButton()
      button.setTitle("Shuffle label rows", for: .normal)
      button.setTitleColor(.white, for: .normal)
      button.translatesAutoresizingMaskIntoConstraints = false
      button.sizeToFit()
      button.backgroundColor = .systemOrange
      button.addTarget(self, action: #selector(shuffleLabels), for: .touchUpInside)
      return button
    }()

    view.addSubview(label1)
    view.addSubview(label2)
    view.addSubview(label3)
    view.addSubview(shuffleButton)

    NSLayoutConstraint.activate([
      label1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      label1.widthAnchor.constraint(equalTo: view.widthAnchor),
      label1.heightAnchor.constraint(equalToConstant: 80),
      label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 20),
      label2.widthAnchor.constraint(equalTo: view.widthAnchor),
      label2.heightAnchor.constraint(equalToConstant: 80),
      label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 20),
      label3.widthAnchor.constraint(equalTo: view.widthAnchor),
      label3.heightAnchor.constraint(equalToConstant: 80),
      shuffleButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2),
      shuffleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      shuffleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      shuffleButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  @objc func shuffleLabels() {
    appLabels.shuffle()
    label1.text = appLabels[0]
    label2.text = appLabels[1]
    label3.text = appLabels[2]
  }

}

