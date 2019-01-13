//
//  InformationPostingViewController.swift
//  OnTheMap
//
//  Created by Vui Nguyen on 1/4/19.
//  Copyright © 2019 Sunfish Empire. All rights reserved.
//

import UIKit
import MapKit

class InformationPostingViewController: UIViewController {

  @IBOutlet weak var locationTextField: UITextField!
  @IBOutlet weak var linkTextField: UITextField!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  @IBAction func cancelAddLocation(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }

  @IBAction func findLocation(_ sender: Any) {
    setGeocoding(true)
    guard let location = locationTextField.text else {
      return
    }

    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(location) { (locations, error) in
      self.setGeocoding(false)
      guard let locations = locations else {
        let alert = UIAlertController(title: "Error Geocoding Location", message: error?.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
                                      style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
        }

      guard let latitude = locations[0].location?.coordinate.latitude else {
        return
      }
      print("latitude is \(latitude)")

      guard let longitude = locations[0].location?.coordinate.longitude else {
        return
      }
      print("longitude is \(longitude)")

      let locationController = self.storyboard!.instantiateViewController(withIdentifier: "LocationAddedViewController") as! LocationAddedViewController
      locationController.latitude = latitude
      locationController.longitude = longitude
      locationController.mediaURL = self.linkTextField.text ?? nil
      locationController.mapString = self.locationTextField.text ?? nil
      self.navigationController!.pushViewController(locationController, animated: true)
    }

  }

  override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  func setGeocoding(_ geocoding: Bool) {
    if geocoding {
      activityIndicator.startAnimating()
    } else {
      activityIndicator.stopAnimating()
    }
    locationTextField.isEnabled = !geocoding
    linkTextField.isEnabled = !geocoding
  }
}
