//
//  LocationAddedViewController.swift
//  OnTheMap
//
//  Created by Vui Nguyen on 1/4/19.
//  Copyright © 2019 Sunfish Empire. All rights reserved.
//

import UIKit
import MapKit

class LocationAddedViewController: UIViewController, MKMapViewDelegate {

  var latitude: Double?
  var longitude: Double?
  var mediaURL: String?
  var mapString: String?
  var firstName: String? = "Starlight"
  var lastName: String? = "Starbright"

  @IBOutlet weak var mapView: MKMapView!
  @IBAction func submitLocationToServer(_ sender: Any) {
   // let studentData = "{\"uniqueKey\": \"1234\", \"firstName\": \(String(describing: firstName)), \"lastName\": \(String(describing: lastName)),\"mapString\": \(String(describing: mapString)), \"mediaURL\": \(String(describing: mediaURL)),\"latitude\": \(latitude ?? 0.0), \"longitude\": \(longitude ?? 0.0)}".data(using: .utf8)

    //let decoder = JSONDecoder.init()

    let studentDict: [StudentInformation.CodingKeys: Any] = [StudentInformation.CodingKeys.uniqueKey: "1234",
                                                             StudentInformation.CodingKeys.firstName: firstName ?? "",
                                                             StudentInformation.CodingKeys.lastName: lastName ?? "",
                                                             StudentInformation.CodingKeys.mapString: mapString ?? "",
                                                             StudentInformation.CodingKeys.mediaURL: mediaURL ?? "",
                                                             StudentInformation.CodingKeys.latitude: latitude ?? 0.0,
                                                             StudentInformation.CodingKeys.longitude: longitude ?? 0.0]
   // do  {
      //let student = try decoder.decode(StudentInformation.self, from: studentData!)

      let student = StudentInformation(dictionary: studentDict)
      UdacityClient.addStudent(student: student) { (success, error) in
        if success {
          self.dismiss(animated: true, completion: nil)
        } else {
          print("there was an error in adding a student")
        }
      }
   // } catch {
   //   print("error with creating StudentInformation object")
   //   return
   // }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    guard let latitude = latitude, let longitude = longitude else  {
      return
    }

    print("In LocationAddedViewController, latitude is \(latitude), longitude is \(longitude)")

    var annotations = [MKPointAnnotation]()
    let lat = CLLocationDegrees(latitude)

    //let lat = CLLocationDegrees(dictionary["latitude"] as! Double)

    let long = CLLocationDegrees(longitude)
    //let long = CLLocationDegrees(dictionary["longitude"] as! Double)

    // The lat and long are used to create a CLLocationCoordinates2D instance.
    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)

    // Here we create the annotation and set its coordiate, title, and subtitle properties
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinate
    //annotation.title = "\(first) \(last)"
    annotation.title = "Testing"

    if let mediaURL = mediaURL {
      annotation.subtitle = mediaURL
    }

    // Finally we place the annotation in an array of annotations.
    annotations.append(annotation)
    self.mapView.addAnnotations(annotations)
    self.mapView.centerCoordinate = coordinate
  }


  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */

  // MARK: - MKMapViewDelegate

  // Here we create a view with a "right callout accessory view". You might choose to look into other
  // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
  // method in TableViewDataSource.
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

    let reuseId = "pin"

    var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

    if pinView == nil {
      pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
      pinView!.canShowCallout = true
      pinView!.pinTintColor = .red
      pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    else {
      pinView!.annotation = annotation
    }

    return pinView
  }


  // This delegate method is implemented to respond to taps. It opens the system browser
  // to the URL specified in the annotationViews subtitle property.
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    if control == view.rightCalloutAccessoryView {
      let app = UIApplication.shared
      if let toOpen = view.annotation?.subtitle! {
        //app.openURL(URL(string: toOpen)!)
        app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
      }
    }
  }
  
}
