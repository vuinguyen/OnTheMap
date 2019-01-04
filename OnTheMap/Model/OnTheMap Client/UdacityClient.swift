//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Vui Nguyen on 12/29/18.
//  Copyright © 2018 Sunfish Empire. All rights reserved.
//

import Foundation
import UIKit

class UdacityClient {

  class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
    print("tapped the button")

    let urlString = "https://onthemap-api.udacity.com/v1/session"
    let url = URL(string: urlString)
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let body = LoginRequest(udacity: UserLogin(username: username, password: password))
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
          //self.performSegue(withIdentifier: "completeLogin", sender: nil)
          completion(true, nil)
        }
      } catch {
        do {
          let errorResponse = try decoder.decode(UdacityResponse.self, from: newData)
          print(errorResponse.errorDescription ?? "error")
          DispatchQueue.main.async {
            /*
            let alert = UIAlertController(title: "Login Error", message: errorResponse.errorDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
                                          style: .default, handler: { _ in
                                            print("There was an error in logging in")
            }))
            self.present(alert, animated: true, completion: nil)
 */
            completion(false, errorResponse)
          }
        } catch {
          print("cannot get error response from POST")
        }

      }
    }
    task.resume()
  }

  class func getStudentList(completion: @escaping (Bool, Error?) -> Void) {
    var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation?limit=100&order=-updatedAt")!)
    //request.addValue("clearlyTheWrongApplicationId", forHTTPHeaderField: "X-Parse-Application-Id")
    //request.addValue("clearlyTheWrongKey", forHTTPHeaderField: "X-Parse-REST-API-Key")

    request.addValue(APIKeys.ApplicationID, forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue(APIKeys.RESTAPIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")

    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in

      guard let data = data else {
        print("got no data back from GET")
        return
      }

      let decoder = JSONDecoder()
      do {
        let responseObject = try decoder.decode(StudentResults.self, from: data)
        //print(responseObject)
        StudentModel.studentList = responseObject.results
        print(StudentModel.studentList)
        // print("response is: \(String(describing: response))")
        DispatchQueue.main.async {
          //self.tableView.reloadData()
          completion(true, nil)
        }
      } catch {
        do {
          let errorResponse = try decoder.decode(UdacityResponse.self, from: data)
          print(errorResponse.errorDescription ?? "error")
          //let alert = UIAlertController(title: "error", message: errorResponse.errorDescription, preferredStyle: .alert)
          //self.present(alert, animated: true, completion: nil)
          DispatchQueue.main.async {
            completion(false, errorResponse)
          }
        } catch {
          print(String(data: data, encoding: .utf8)!)
          print("cannot get error response from GET")
        }

      }

    }
    task.resume()

  }
}
