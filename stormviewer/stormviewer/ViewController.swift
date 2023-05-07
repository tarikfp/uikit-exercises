//
//  ViewController.swift
//  stormviewer
//
//  Created by Tarık Fatih PINARCI on 6.05.2023.
//

import UIKit

class ViewController: UITableViewController {

  var pictures = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Storm Viewer"
    navigationController?.navigationBar.prefersLargeTitles = true

    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)

    let sortedItems = items.sorted()

    for item in sortedItems {
      if item.hasPrefix("nssl") {
        pictures.append(item)
      }
    }

    // Do any additional setup after loading the view.
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    cell.accessoryType = .disclosureIndicator
    var content = cell.defaultContentConfiguration()
    content.text = pictures[indexPath.row]
    content.textProperties.font = .systemFont(ofSize: 20)
    cell.contentConfiguration = content
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
      detailVC.selectedImage = pictures[indexPath.row]
      detailVC.title = "Picture \(indexPath.row + 1) of \(pictures.count)"
      navigationController?.pushViewController(detailVC, animated: true)
    }

  }

}
