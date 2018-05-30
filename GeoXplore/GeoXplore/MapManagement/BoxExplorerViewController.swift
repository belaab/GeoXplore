//
//  BoxExplorerViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 17.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit
import Mapbox
//TODO: TODO: validating distance
//TODO: TODO: handling errors

class BoxExplorerViewController: UIViewController {
    
    var boxes = [Box]()
    var userLocation = CLLocation()
    var locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MGLMapView!
    
    @IBAction func checkLocation(_ sender: UIButton) {
        
        let(isUblockedBox, closestBoxDisnatce) = checkingUserPosition()
        let determineIfAlreadyOpened = closestBoxDisnatce.isLess(than: Constants.minimalDistanceToUnblockBox)
        
        switch (isUblockedBox, determineIfAlreadyOpened) {
        case (true, _): //means user reached minimal distance to box
            print("You have unblocked the box")
        case (false, true): //means all boxes unblocked (user has not boxes to unblock; all boxes has been found: distance < 100)
            print("You already have unblocked all chests")
        case (false, false): //means no boxes reached with minimal distance
            print("You are not close enough")
        }
        
        let congratsViewController = StoryboardManager.congratsViewController()
        self.present(congratsViewController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        viewSetup()
        getPositions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineMyCurrentLocation()
    }
    
    private func getPositions(){
        RequestManager.sharedInstance.getBoxesPositions { (success, boxesArray, error) in
            if success {
                self.boxes = boxesArray
                boxesArray.forEach({ box in
                    let annotation = CustomPointAnnotation(id: box.id, dateCreated: box.dateCreated, dateFound: box.dateFound, opened: box.opened, value: box.value)
                    print(box.latitude,box.longitude)
                    annotation.coordinate = CLLocationCoordinate2DMake(box.longitude, box.latitude)
                    switch box.opened {
                    case false:
                        annotation.title = "closed"
                    case true:
                        annotation.title = "opened"
                    }
                    self.mapView.addAnnotation(annotation)
                })
            } else {
                print("Error while initilizing box positions")
            }
        }
    }
    
    
    private func checkingUserPosition() -> (isUnblockedBox: Bool, closestBoxDistance: Double) {
        
        guard let pins = mapView.annotations as? [CustomPointAnnotation] else { return (false, 0.0) }
        let userCoordinate = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        var distancesToAllBoxes = [CLLocationDistance]()
        let closedBoxes = pins.filter { $0.title != "opened" }
        if closedBoxes.count == 0 { return (false, 0.0)}
        
        for pin in closedBoxes {
            let pinCoordinate = CLLocation(latitude: pin.coordinate.latitude, longitude: pin.coordinate.longitude)
            let distanceInMeters: CLLocationDistance = pinCoordinate.distance(from: userCoordinate)
            print("Distance in meters: \(distanceInMeters)")
        
            if distanceInMeters < Constants.minimalDistanceToUnblockBox && (pin.title!) == "closed" {
                let newPin = CustomPointAnnotation(id: pin.id, dateCreated: pin.dateCreated, dateFound: pin.dateFound, opened: pin.opened, value: pin.value)
                newPin.coordinate = pin.coordinate
                newPin.title = "opened"
                mapView.removeAnnotation(pin)
                mapView.addAnnotation(newPin)
                return (true, distanceInMeters)
            } else if distanceInMeters > Constants.minimalDistanceToUnblockBox && (pin.title!) == "closed" {
                distancesToAllBoxes.append(distanceInMeters)
            }
        }
        return (false, distancesToAllBoxes.sorted { $0 < $1 }.first!)
    }
    
    private func viewSetup() {
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.showsUserLocation = true
    }
    
    private func determineMyCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
}


extension BoxExplorerViewController: CLLocationManagerDelegate, MGLMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0] as CLLocation
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        let camera = MGLMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 4000, pitch: 0, heading: 0)
        mapView.fly(to: camera, completionHandler: nil)
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        guard let annotations = mapView.annotations else { return }
        mapView.showAnnotations(annotations, edgePadding: UIEdgeInsetsMake(110.0, 40.0, 40.0, 40.0), animated: true)
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











