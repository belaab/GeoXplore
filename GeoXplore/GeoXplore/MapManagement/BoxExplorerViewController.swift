//
//  BoxExplorerViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 17.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit
import Mapbox

class BoxExplorerViewController: UIViewController, MGLMapViewDelegate {
    

    @IBAction func checkLocation(_ sender: UIButton) {
       // if checkingUserPosition() {
            checkingUserPosition()
            let congratsViewController = StoryboardManager.congratsViewController()
            self.present(congratsViewController, animated: true, completion: nil)
   //     }
    }
    @IBOutlet weak var mapView: MGLMapView!
    var locationManager:CLLocationManager!
    var boxes = [Box]()
    var userLocation = CLLocation()
    //var distanceInMeters = CLLocationDistance()

    func getPositions(){
        RequestManager.sharedInstance.getBoxesPositions { (success, data, error) in
            if success {
                if let array = data as? NSArray {
                    for obj in array {
                        if let dict = obj as? NSDictionary {
                            let long = dict.value(forKey: "longitude") as! Double
                            let lat = dict.value(forKey: "latitude") as! Double
                            let opened = dict.value(forKey: "opened") as! Bool
                            print(long, lat, opened)
                            //self.boxes.append(Box(longitude: long, latitude: lat, opened: opened))
                            var newBox = Box(longitude: long, latitude: lat, opened: opened)
                            self.boxes.append(newBox)
                            var annotation = MGLPointAnnotation()
                            var coordinates = CLLocationCoordinate2D()
                            coordinates.latitude = newBox.latitude
                            coordinates.longitude = newBox.longitude
                            annotation.coordinate = coordinates
                            switch opened {
                            case false:
                                annotation.title = "opened"
                            case true:
                                annotation.title = "closed"
                            }
                           // annotation.setValue(opened, forKey: "isOpened")
                            //annotation.title = String(opened)
                            self.mapView.addAnnotation(annotation)
                        }
                    }
                }
            } else {
                print(error)
            }
        }

    }
    
    //let distanceInMeters = coordinate₀.distance(from: coordinate₁) // result is in meters

    
    func checkingUserPosition() {
        let pins = mapView.annotations
        for pin in pins! {
            //var distanceInMeters = (pin.coordinate).distance(from: userLocation.coordinate)
            let coordinate = CLLocation(latitude: pin.coordinate.latitude, longitude: pin.coordinate.longitude)
            let userCoordinate = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            let distanceInMeters = coordinate.distance(from: userCoordinate)
   //         if distanceInMeters > 300 {
                print(distanceInMeters)
               // mapView.dequeueReusableAnnotationImage(withIdentifier: "box")
                //mapView.removeAnnotation(pin)
                let newPin = MGLPointAnnotation()
                newPin.coordinate = pin.coordinate
            switch (pin.title!)! {
            case "opened":
                newPin.title = "opened"
            case "closed":
                newPin.title = "opened"
            default:
                newPin.title = "opened"
                
            }
               // newPin.title = "closed"
                mapView.removeAnnotation(pin)
                mapView.addAnnotation(newPin)
//                return true
//            } else {
//                return false
//            }
    //    }
//return true
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.showsUserLocation = true
        getPositions()
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        //locationManager.delegate = self as! CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineMyCurrentLocation()
    }
}


extension BoxExplorerViewController {

    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        let camera = MGLMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 4000, pitch: 0, heading: 0)
        mapView.fly(to: camera, completionHandler: nil)
    }
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "box")
        
        if annotationImage == nil {
            switch (annotation.title!)! {
            case "opened":
                var image = UIImage(named: "box")!
                image = image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: image.size.height/2, right: 0))
                annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: "box")
            case "closed":
                var image = UIImage(named: "closed_box")!
                image = image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: image.size.height/2, right: 0))
                annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: "closed_box")
            default:
                print((annotation.title!)!)
                var image = UIImage(named: "closed_box")!
                image = image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: image.size.height/2, right: 0))
                annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: "closed_box")
            }
        }
        return annotationImage
    }
}











