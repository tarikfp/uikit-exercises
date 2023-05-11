//
//  ViewController.swift
//  ProgrammaticTabbarNavController
//
//  Created by Tarık Fatih PINARCI on 11.05.2023.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
  }

  func setupUI(){
    view.backgroundColor = .white

    let homeLabel: UILabel = {
      let label = UILabel()
      label.text = "This is home screen"
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()

    let homeButton: UIButton = {
      let button = UIButton()
      button.setTitle("Go to profile", for: .normal)
      button.setTitleColor(.white, for: .normal)
      button.backgroundColor = .systemOrange
      button.translatesAutoresizingMaskIntoConstraints = false
      button.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
      return button
    }()

    view.addSubview(homeButton)
    view.addSubview(homeLabel)


    NSLayoutConstraint.activate([
          homeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
          homeButton.widthAnchor.constraint(equalTo: view.widthAnchor),
          homeButton.heightAnchor.constraint(equalToConstant: 72),
          homeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          homeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])


  }

  @objc func goToProfile(){
    tabBarController?.selectedIndex = 1
  }


}


class SecondViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()

  }

  func setupUI(){
    view.backgroundColor = .white

    let profileLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.text = "This is profile screen"
      return label
    }()

    let profileButton: UIButton = {
      let button = UIButton()
      button.setTitle("Go to home", for: .normal)
      button.setTitleColor(.white, for: .normal)
      button.backgroundColor = .systemOrange
      button.translatesAutoresizingMaskIntoConstraints = false
      button.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
      return button
    }()

    view.addSubview(profileButton)
    view.addSubview(profileLabel)

    NSLayoutConstraint.activate([
          profileButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
          profileButton.widthAnchor.constraint(equalTo: view.widthAnchor),
          profileButton.heightAnchor.constraint(equalToConstant: 72),
          profileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          profileLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

  }


  @objc func goToHome(){
    tabBarController?.selectedIndex = 0
  }

}



