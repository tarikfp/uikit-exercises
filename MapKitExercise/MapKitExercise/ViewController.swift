//
//  ViewController.swift
//  MapKitExercise
//
//  Created by Tarık Fatih PINARCI on 25.05.2023.
//

import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate {
  var mapView: MKMapView!
  
  override func viewDidLoad() {
    mapView = MKMapView(frame: view.frame)
    mapView.delegate = self
    super.viewDidLoad()

    view.addSubview(mapView)

    let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.127), info: "Home to the 2012 Suımmer Olympics")

    let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago")

    let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light")

    let washington = Capital(title: "Washington", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Washington city")

    mapView.addAnnotations([london, oslo, paris, washington])

  }

  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard annotation is Capital else { return nil }
    let identifier = "Capital Annotation"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

    if annotationView == nil {
      annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      annotationView?.canShowCallout = true

      let btn = UIButton(type: .detailDisclosure)
      annotationView?.rightCalloutAccessoryView = btn
    } else {
      annotationView?.annotation = annotation
    }

    return annotationView

  }

  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    guard let capital = view.annotation as? Capital else { return }

    let placeName = capital.title
    let placeInfo = capital.info

    let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
    ac.addAction(.init(title: "OK", style: .default))
    present(ac, animated: true)

  }
  
  
  
  
}

