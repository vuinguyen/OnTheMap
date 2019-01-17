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


  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    subscribeToKeyboardNotifications()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unsubscribeFromKeyboardNotifications()
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

  // MARK: Keyboard Helper Functions
  @objc func keyboardWillShow(_ notification: Notification) {
    // ensure that the keyboard moves up when a text field is being edited
    if locationTextField.isEditing || linkTextField.isEditing {
      view.frame.origin.y = -getPartialKeyboardHeight(notification)
    }
  }

  @objc func keyboardWillHide(_ notification: Notification) {
    view.frame.origin.y = 0
  }

  func getPartialKeyboardHeight(_ notification:Notification) -> CGFloat {
    let userInfo = notification.userInfo
    let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
    return keyboardSize.cgRectValue.height * (3/4)
  }

  func subscribeToKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                           name: UIResponder.keyboardWillShowNotification, object: nil)

    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                           name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  func unsubscribeFromKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
}
