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
            // some other error printed here
            print("some error in getting student list")
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
    /*
    print("tapped the button")

    let urlString = "https://onthemap-api.udacity.com/v1/session"
    let url = URL(string: urlString)
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let body = LoginRequest(udacity: UserLogin(username: emailTextField.text ?? "", password: passwordTextField.text ?? ""))
    request.httpBody = try! JSONEncoder().encode(body)
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in


      guard let data = data else {
        print("got no data back from post")
        return
      }

      //let range = Range(5..<data!.count)
      let range = 5..<data.count
      let newData = data.subdata(in: range) /* subset response data! */
      print(String(data: newData, encoding: .utf8)!)

      let decoder = JSONDecoder()
      do {
        let responseObject = try decoder.decode(LoginResponse.self, from: newData)
        print(responseObject)
        DispatchQueue.main.async {
          self.performSegue(withIdentifier: "completeLogin", sender: nil)
        }
      } catch {
        do {
          let errorResponse = try decoder.decode(UdacityResponse.self, from: newData)
          print(errorResponse.errorDescription ?? "error")
          DispatchQueue.main.async {
            let alert = UIAlertController(title: "Login Error", message: errorResponse.errorDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
                                          style: .default, handler: { _ in
                                            print("There was an error in logging in")
            }))
            self.present(alert, animated: true, completion: nil)
          }
        } catch {
          print("cannot get error response from POST")
        }

      }
    }
    task.resume()
    */
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  func getStudentData() {

  }
}

