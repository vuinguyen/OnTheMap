//
//  ViewController.swift
//  OnTheMap
//
//  Created by Vui Nguyen on 12/19/18.
//  Copyright © 2018 Sunfish Empire. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var signUpButton: UIButton!
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  @IBAction func signUpForAccount(_ sender: Any) {
    let app = UIApplication.shared
    let toOpen: String = "https://www.udacity.com/account/auth#!/signup"
    app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
  }

  @IBAction func loginTapped(_ sender: UIButton) {
    setLoggingIn(true)
    UdacityClient.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (success, error) in
      if success {
        UdacityClient.getStudentList(completion: { (success, error) in
          self.setLoggingIn(false)
          if success {
              self.performSegue(withIdentifier: "completeLogin", sender: nil)
          } else {
            // we should display an alert here and segue to the next view
            print("There was an error in getting the student list")
            let alert = UIAlertController(title: "Error Retrieving Data", message: error?.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
                                          style: .default, handler: { _ in
                                            self.performSegue(withIdentifier: "completeLogin", sender: nil)
            }))

            self.present(alert, animated: true, completion: nil)
          }
        })
      } else {
        self.setLoggingIn(false)
        print("There was an error in logging in")
        let alert = UIAlertController(title: "Login Error", message: error?.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
                                      style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
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

  func setLoggingIn(_ loggingIn: Bool) {
    if loggingIn {
      activityIndicator.startAnimating()
    } else {
      activityIndicator.stopAnimating()
    }
    emailTextField.isEnabled = !loggingIn
    passwordTextField.isEnabled = !loggingIn
    loginButton.isEnabled = !loggingIn
    signUpButton.isEnabled = !loggingIn
  }

  // MARK: Keyboard Helper Functions
  @objc func keyboardWillShow(_ notification: Notification) {
    // ensure that the keyboard moves up when a text field is being edited
    if emailTextField.isEditing || passwordTextField.isEditing {
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

