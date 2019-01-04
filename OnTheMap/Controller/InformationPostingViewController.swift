//
//  InformationPostingViewController.swift
//  OnTheMap
//
//  Created by Vui Nguyen on 1/4/19.
//  Copyright © 2019 Sunfish Empire. All rights reserved.
//

import UIKit

class InformationPostingViewController: UIViewController {

  @IBOutlet weak var locationTextField: UITextField!
  @IBOutlet weak var linkTextField: UITextField!

  @IBAction func findLocation(_ sender: Any) {
    print("find location, yo!!")
  }

  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
