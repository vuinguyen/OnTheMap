//
//  ViewController.swift
//  OnTheMap
//
//  Created by Vui Nguyen on 12/19/18.
//  Copyright © 2018 Sunfish Empire. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  
  @IBAction func loginTapped(_ sender: UIButton) {
    UdacityClient.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (success, error) in
      if success {
        UdacityClient.getStudentList(completion: { (success, error) in
          if success {
              self.performSegue(withIdentifier: "completeLogin", sender: nil)
          } else {
            // we should display an alert here and segue to the next view
            let alert = UIAlertController(title: "Error Retrieving Data", message: error.debugDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
                                          style: .default, handler: { _ in
                                            print("There was an error in getting the student list")
                                            self.performSegue(withIdentifier: "completeLogin", sender: nil)
            }))
            self.present(alert, animated: true, completion: nil)
          }
        })
      } else {
        let alert = UIAlertController(title: "Login Error", message: error.debugDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
                                      style: .default, handler: { _ in
                                        print("There was an error in logging in")
        }))
        self.present(alert, animated: true, completion: nil)
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
}

