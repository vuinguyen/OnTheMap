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
        self.tableView.reloadData()
      } else {
        print("refresh data failed")
      }
    }
  }

  let reuseIdentifier = "StudentListCell"

    override func viewDidLoad() {
      super.viewDidLoad()

      tableView.reloadData()
  }
    

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    tableView.reloadData()
  }
}

extension StudentListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return StudentModel.studentList.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!

    let student = StudentModel.studentList[indexPath.row]

    cell.textLabel?.text = (student.firstName ?? "") + " " + (student.lastName ?? "")
    cell.imageView?.image = UIImage(named: "Udacity")
    if (cell.detailTextLabel != nil) {
      cell.detailTextLabel?.text = student.mediaURL
    }

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let student = StudentModel.studentList[indexPath.row]
    let app = UIApplication.shared
    if let toOpen = student.mediaURL {
      app.open(URL(string:toOpen)!, options: [:], completionHandler: nil)

    }

    tableView.deselectRow(at: indexPath, animated: true)
  }
}
