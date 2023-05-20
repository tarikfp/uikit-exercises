//
//  ViewController.swift
//  CollectionViewPractice
//
//  Created by Tarık Fatih PINARCI on 17.05.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {

  var collectionView: UICollectionView!
  var persons = [Person]()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Collection view"

    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 100, height: 150)
    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    layout.minimumInteritemSpacing = 10
    layout.minimumLineSpacing = 10

    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(PersonCell.self, forCellWithReuseIdentifier: "PersonCell")
    view.addSubview(collectionView)

    setSavedData()

    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))

  }

  @objc func addNewPerson(){
    let imagePickerController = UIImagePickerController()

    imagePickerController.allowsEditing = true
    imagePickerController.delegate = self

    present(imagePickerController, animated: true)
  }

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.originalImage] as? UIImage else { return }

    let imageName = UUID().uuidString
    let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
    if let jpegData = image.jpegData(compressionQuality: 0.8) {
      try? jpegData.write(to: imagePath)
    }

    let person = Person(name: "Unknown", image: imageName)
    persons.append(person)
    self.save()
    collectionView?.reloadData()
    dismiss(animated: true)
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let personCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCell", for: indexPath) as? PersonCell else { fatalError("An error occurred when creating PersonCell") }

    let person = persons[indexPath.item]

    personCell.name.text = person.name

    let path = getDocumentsDirectory().appendingPathComponent(person.image)

    personCell.imageView.image = UIImage(contentsOfFile: path.path())

    return personCell
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return persons.count
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let person = persons[indexPath.item]

    let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)

    ac.addTextField()

    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

    ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in

      let newName = ac?.textFields![0]
      person.name = (newName?.text)!
      let defaults = UserDefaults.standard

      self?.save()

      self?.collectionView.reloadData()
    })

    present(ac, animated: true)


  }

  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
  }

  func save(){
    let jsonEncoder = JSONEncoder()

    if let encodedPersonsData = try? jsonEncoder.encode(self.persons){
      let defaults = UserDefaults.standard
      defaults.set(encodedPersonsData, forKey: "Persons")
    }
  }

  func setSavedData() {
    let defaults = UserDefaults.standard

    if let savedPersonsData = defaults.object(forKey: "Persons") as? Data{
      let decoder = JSONDecoder()
      do {
        persons = try decoder.decode([Person].self, from: savedPersonsData)
      } catch {
        print("Failed to load persons data from storage")
      }


    }

  }

}



