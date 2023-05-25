//
//  Capital.swift
//  MapKitExercise
//
//  Created by Tarık Fatih PINARCI on 25.05.2023.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
  var title: String?
  var coordinate: CLLocationCoordinate2D
  var info: String

  init(title: String? = nil, coordinate: CLLocationCoordinate2D, info: String) {
    self.title = title
    self.coordinate = coordinate
    self.info = info
  }

}
