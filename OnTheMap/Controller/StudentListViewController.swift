//
//  StudentListViewController.swift
//  OnTheMap
//
//  Created by Vui Nguyen on 12/29/18.
//  Copyright © 2018 Sunfish Empire. All rights reserved.
//

import UIKit

class StudentListViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!

  let reuseIdentifier = "StudentListCell"

    override func viewDidLoad() {
      super.viewDidLoad()

        // Do any additional setup after loading the view.
      var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation?limit=20&order=-updatedAt")!)
      request.addValue("clearlyTheWrongApplicationId", forHTTPHeaderField: "X-Parse-Application-Id")

      request.addValue("clearlyTheWrongKey", forHTTPHeaderField: "X-Parse-REST-API-Key")
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
            self.tableView.reloadData()
          }
        } catch {
          do {
            let errorResponse = try decoder.decode(UdacityResponse.self, from: data)
            print(errorResponse.errorDescription ?? "error")
            //let alert = UIAlertController(title: "error", message: errorResponse.errorDescription, preferredStyle: .alert)
            //self.present(alert, animated: true, completion: nil)
          } catch {
            print("cannot get error response from GET")
            print(String(data: data, encoding: .utf8)!)
          }

        }

      }
      task.resume()
  }
    

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    tableView.reloadData()
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension StudentListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return StudentModel.studentList.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!

    let student = StudentModel.studentList[indexPath.row]

    cell.textLabel?.text = student.firstName + " " + student.lastName
    cell.imageView?.image = UIImage(named: "Udacity")
    if (cell.detailTextLabel != nil) {
      cell.detailTextLabel?.text = student.mediaURL
    }

    return cell
  }


}
