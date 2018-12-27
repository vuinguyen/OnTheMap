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
    print("tapped the button")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }


}

