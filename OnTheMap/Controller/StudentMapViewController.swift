//
//  StudentMapViewController.swift
//  OnTheMap
//
//  Created by Vui Nguyen on 1/3/19.
//  Copyright © 2019 Sunfish Empire. All rights reserved.
//

import UIKit
import MapKit

class StudentMapViewController: UIViewController, MKMapViewDelegate {

  @IBOutlet weak var mapView: MKMapView!
  
  @IBAction func logout(_ sender: Any) {
    UdacityClient.logout { (success, error) in
      if success {
        self.dismiss(animated: true, completion: nil)
      } else {
        let alert = UIAlertController(title: "Error Logging Out", message: error?.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
                                      style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    }
  }
  
  @IBAction func refreshData(_ sender: Any) {
    UdacityClient.getStudentList { (success, error) in
      if success {
        self.populateMap()
      } else {
        print("refresh data failed")
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    populateMap()
  }

  func populateMap() {
    var annotations = [MKPointAnnotation]()
    let locations = StudentModel.studentList
    for studentLocation in locations {

      guard let latitude = studentLocation.latitude, let longitude = studentLocation.longitude else {
        continue
      }
      let lat = CLLocationDegrees(latitude)
      let long = CLLocationDegrees(longitude)
      let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)

      let first = studentLocation.firstName ?? ""
      let last = studentLocation.lastName ?? ""
      let mediaURL = studentLocation.mediaURL ?? ""

      let annotation = MKPointAnnotation()
      annotation.coordinate = coordinate
      annotation.title = "\(first) \(last)"
      annotation.subtitle = mediaURL

      // Finally we place the annotation in an array of annotations.
      annotations.append(annotation)
    }

    // When the array is complete, we add the annotations to the map.
    self.mapView.addAnnotations(annotations)
  }

  // MARK: - MKMapViewDelegate

  // Here we create a view with a "right callout accessory view". You might choose to look into other
  // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
  // method in TableViewDataSource.
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

    let reuseId = "pin"

    var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

    if pinView == nil {
      pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
      pinView!.canShowCallout = true
      pinView!.pinTintColor = .red
      pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    else {
      pinView!.annotation = annotation
    }

    return pinView
  }

  // This delegate method is implemented to respond to taps. It opens the system browser
  // to the URL specified in the annotationViews subtitle property.
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    if control == view.rightCalloutAccessoryView {
      let app = UIApplication.shared
      if let toOpen = view.annotation?.subtitle! {
        //app.openURL(URL(string: toOpen)!)
        app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
      }
    }
  }
}
