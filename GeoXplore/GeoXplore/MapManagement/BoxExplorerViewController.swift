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
        checkingUserPosition()
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
                    let annotation = MGLPointAnnotation()
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
    
    
    private func checkingUserPosition() {
        
        guard let pins = mapView.annotations else { return }
        let userCoordinate = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        pins.forEach { pin in
            let coordinate = CLLocation(latitude: pin.coordinate.latitude, longitude: pin.coordinate.longitude)
            let distanceInMeters: CLLocationDistance = coordinate.distance(from: userCoordinate)
            print("distanceInMeters: \(distanceInMeters)")
            
            if distanceInMeters < 1000 {
                let newPin = MGLPointAnnotation()
                newPin.coordinate = pin.coordinate
                newPin.title = "opened"
                mapView.removeAnnotation(pin)
                mapView.addAnnotation(newPin)
                
                let congratsViewController = StoryboardManager.congratsViewController()
                self.present(congratsViewController, animated: true, completion: nil)
            }
        
        }
    }
    
    private func viewSetup(){
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











