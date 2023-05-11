//
//  FavoritesViewController.swift
//  PetitionsJsonTabbar
//
//  Created by Tarık Fatih PINARCI on 11.05.2023.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  var favoritePetitions = [Petition]()
  var appTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Favorite petition list"
    setupUI()
  }
  
  func setupUI(){
    view.backgroundColor = .white
    let mainVC = ViewController()
    
    appTableView = {
      let tableView = UITableView()
      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.frame = view.bounds
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "petitionCell")
      return tableView
    }()
    
    appTableView.delegate = self
    appTableView.dataSource = self
    
    view.addSubview(appTableView)
    
    favoritePetitions = mainVC.getPetitionsData()
  }


  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favoritePetitions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "petitionCell", for: indexPath)
    cell.accessoryType = .disclosureIndicator
    var content = cell.defaultContentConfiguration()
    content.text = favoritePetitions[indexPath.row].title
    content.textProperties.numberOfLines = 1
    content.secondaryText = favoritePetitions[indexPath.row].body
    cell.selectionStyle = .none
    content.secondaryTextProperties.numberOfLines = 2
    cell.contentConfiguration = content
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailVC = DetailViewController()
    detailVC.selectedPetition = favoritePetitions[indexPath.row]
    detailVC.title = favoritePetitions[indexPath.row].title
    navigationController?.pushViewController(detailVC, animated: true)
  }
  
}
