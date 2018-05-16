//
//  ChooseLocationViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 16.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit
import Mapbox
import NVActivityIndicatorView

class SetLocationViewController: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var mapView: MGLMapView!
    private let annotation = MGLPointAnnotation()
    private let activityIndicatorView =
        NVActivityIndicatorView(frame: UIScreen.main.bounds,
                                type: NVActivityIndicatorType.ballClipRotateMultiple, color: UIColor(red: 113.0/255.0, green: 195.0/255.0, blue: 139.0/255.0, alpha: 1.0))
    
    
    @IBAction func playButton(_ sender: UIButton) {
        showActivityIndicator()
        sendCoordinates()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        setupActivityIndicator()
    }
    
    private func setupActivityIndicator() {
        activityIndicatorView.backgroundColor = UIColor(red: 33.0/255.0, green: 19.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        view.addSubview(activityIndicatorView)
    }
    
    private func viewSetup() {
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.showsUserLocation = true
        mapView.alpha = 0.95
        self.view.isUserInteractionEnabled = false
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        mapView.addGestureRecognizer(gesture)
    }
    
    private func sendCoordinates() {
        let doubleLongitude: Double = annotation.coordinate.longitude
        let doubleLatitude: Double = annotation.coordinate.latitude
        
        RequestManager.sharedInstance.postLocation(longitude: doubleLatitude, latitude: doubleLongitude) { (success, error) in
            if success {
                print("longitude: \(doubleLongitude), latitude: \(doubleLatitude)")
                print("Coordinates sent.")
                
                //let tabBarVC = UITabBarViewCon
//                let boxExplorerViewController = StoryboardManager.boxExplorerViewController()
//                self.present(boxExplorerViewController.viewControllers![0], animated: true, completion: nil)
                let storyboard = UIStoryboard(name: "BoxExplorer", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "tabbarViewController")
                self.present(controller, animated: true, completion: nil)
//                let boxExplorerViewController = StoryboardManager.boxExplorerViewController()
//                self.present(boxExplorerViewController, animated: true, completion: nil)
                self.activityIndicatorView.stopAnimating()
            } else {
                print(error) //TODO
                self.stopAnimating()
                let alert = UIAlertController(title: "Sending location failure", message: "Sorry, please try again.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("destructive")
                    }}))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "tabBarViewController" {
//                if let destinationVC = segue.destination as? UITabBarController {
//                    destinationVC.selectedIndex = 0
//                }
//            }
//        }
    }
    
    
    private func addAnnotationOnLocation(pointedCoordinate: CLLocationCoordinate2D) {
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
    
    private func showActivityIndicator() {
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "Loading", messageFont: UIFont.systemFont(ofSize: 15, weight: .light), type: activityIndicatorView.type, textColor: UIColor(red: 113.0/255.0, green: 195.0/255.0, blue: 139.0/255.0, alpha: 0.7))
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage("Almost there...")
        }
    }
    
}



extension SetLocationViewController: MGLMapViewDelegate, UIGestureRecognizerDelegate, CLLocationManagerDelegate {
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "picker")
        
        if annotationImage == nil {
            var image = UIImage(named: "picker")!
            image = image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: image.size.height/2, right: 0))
            annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: "picker")
        }
        return annotationImage
    }           
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        let camera = MGLMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 4000, pitch: 0, heading: 0)
        mapView.fly(to: camera, completionHandler: nil)
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        let camera = MGLMapCamera(lookingAtCenter: (mapView.userLocation?.coordinate)!, fromDistance: 4000, pitch: 10, heading: 0)
        mapView.fly(to: camera) {
            self.view.isUserInteractionEnabled = true
            mapView.alpha = 1.0
        }
    }

}

