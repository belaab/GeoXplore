//
//  ChooseLocationViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 16.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit
import Mapbox

class SetLocationViewController: UIViewController, MGLMapViewDelegate, UIGestureRecognizerDelegate {
    

    @IBAction func playButton(_ sender: UIButton) {
        let doubleLongitude: Double = annotation.coordinate.longitude
        let doubleLatitude: Double = annotation.coordinate.latitude
        
        RequestManager.sharedInstance.postLocation(longitude: doubleLatitude, latitude: doubleLongitude) { (success, error) in
            if success {
                print("longitude: \(doubleLongitude), latitude: \(doubleLatitude)")
                print("Coordenates sent.")
//                let saveAccessToken: Bool = KeychainWrapper.standard.set(token!, forKey: "accessToken")
//                print("Acces token save result: \(saveAccessToken)")
//
//                let setLocationViewController = StoryboardManager.setLocationViewController()
//                self.present(setLocationViewController, animated: true, completion: nil)
            }
        }
        
    }
    @IBOutlet weak var mapView: MGLMapView!
    private let annotation = MGLPointAnnotation()
    
    func addAnnotationOnLocation(pointedCoordinate: CLLocationCoordinate2D){
        annotation.coordinate = pointedCoordinate
        annotation.title = "Loading..."
        annotation.subtitle = "Loading..."
        mapView.addAnnotation(annotation)
    }
    
    @objc func handleTap(_ gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizerState.began {
        let touchPoint: CGPoint = gestureRecognizer.location(in: mapView)
        let newCoordinate: CLLocationCoordinate2D = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        addAnnotationOnLocation(pointedCoordinate: newCoordinate)
        }
        
    }
    
//    private func chceckingAnnotationAmount() -> Bool {
//        if (mapView.annotations!.count > 0) {
//            mapView.removeAnnotations([annotation])
//            return false
//        }
//        return true
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //mapView.setCenter(MGLUserLocation, animated: )
        //mapView.setCenter(CLLocationCoordinate2D(latitude: 40.74699, longitude: -73.98742), zoomLevel: 9, animated: false)
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.showsUserLocation = true
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        mapView.addGestureRecognizer(gesture)

    }
    



}

extension SetLocationViewController {
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        // Try to reuse the existing ‘pisa’ annotation image, if it exists.
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "box")
        
        if annotationImage == nil {
            // Leaning Tower of Pisa by Stefan Spieler from the Noun Project.
            var image = UIImage(named: "box")!
            
            // The anchor point of an annotation is currently always the center. To
            // shift the anchor point to the bottom of the annotation, the image
            // asset includes transparent bottom padding equal to the original image
            // height.
            //
            // To make this padding non-interactive, we create another image object
            // with a custom alignment rect that excludes the padding.
            image = image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: image.size.height/2, right: 0))
            
            // Initialize the ‘pisa’ annotation image with the UIImage we just loaded.
            annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: "box")
        }
        
        return annotationImage
    }
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        let camera = MGLMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 4000, pitch: 0, heading: 0)
        mapView.fly(to: camera, completionHandler: nil)
    }
}

