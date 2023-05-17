//
//  PersonCell.swift
//  CollectionViewPractice
//
//  Created by Tarık Fatih PINARCI on 17.05.2023.
//

import UIKit

class PersonCell: UICollectionViewCell {
  var imageView: UIImageView!
  var name: UILabel!

  override init(frame: CGRect) {
    super.init(frame: frame)

    imageView = UIImageView(frame: contentView.bounds)
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    contentView.addSubview(imageView)

    name = UILabel(frame: CGRect(x: 0, y: contentView.bounds.height - 30, width: contentView.bounds.width, height: 30))
    name.backgroundColor = UIColor(white: 0, alpha: 0.5)
    name.textColor = .white
    name.textAlignment = .center
    contentView.addSubview(name)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
