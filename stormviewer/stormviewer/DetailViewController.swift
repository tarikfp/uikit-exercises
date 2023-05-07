//
//  DetailViewController.swift
//  stormviewer
//
//  Created by Tarık Fatih PINARCI on 6.05.2023.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet var ImageView: UIImageView!
  var selectedImage: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    navigationItem.largeTitleDisplayMode = .never
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(onSharePress))
    
    
    if let imageToLoad = selectedImage{
      ImageView.image = UIImage(named: imageToLoad)
    }
    
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }
  
  @objc func onSharePress(){
    guard let image = ImageView.image?.jpegData(compressionQuality: 1) else {
      let alertVC = UIAlertController(title: "Warning", message: "Image does not exist", preferredStyle: .alert)
      present(alertVC, animated: true)
      return
    }

    guard let imageName = selectedImage else {
      let alertVC = UIAlertController(title: "Warning", message: "Image does not exist", preferredStyle: .alert)
      present(alertVC, animated: true)
      return
    }
    
    let activityVC = UIActivityViewController(activityItems: [image, imageName], applicationActivities: [])
    activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(activityVC, animated: true)
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
