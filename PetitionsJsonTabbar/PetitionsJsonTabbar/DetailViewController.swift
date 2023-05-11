//
//  DetailViewController.swift
//  PetitionsJsonTabbar
//
//  Created by Tarık Fatih PINARCI on 11.05.2023.
//

import UIKit

class DetailViewController: UIViewController {
  var selectedPetition: Petition?
  var petitionFullBodyLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    petitionFullBodyLabel = UILabel()
    view.addSubview(petitionFullBodyLabel)
    petitionFullBodyLabel.font = UIFont.systemFont(ofSize: 14)
    petitionFullBodyLabel.numberOfLines = 0
    petitionFullBodyLabel.translatesAutoresizingMaskIntoConstraints = false
    
    
    if let petition = selectedPetition {
      petitionFullBodyLabel.text = petition.body
    } else{
      petitionFullBodyLabel.text = "Nothing to see here..."
    }
    
    NSLayoutConstraint.activate([
      petitionFullBodyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      petitionFullBodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      petitionFullBodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)

    ])
    
    
    
    
    // Do any additional setup after loading the view.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
