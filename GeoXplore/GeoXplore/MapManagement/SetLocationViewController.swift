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
    
    @IBInspectable
    @IBOutlet weak var mapView: MGLMapView!
    @IBOutlet weak var viewTitleLabel: UILabel!
    @IBOutlet weak var viewDescriptionLabel: UILabel!
    private let annotation = MGLPointAnnotation()
    private let activityIndicatorView =
        NVActivityIndicatorView(frame: UIScreen.main.bounds,
                                type: NVActivityIndicatorType.ballClipRotateMultiple, color: Colors.loaderLightGreen)
  
    
    @IBOutlet weak var playButtonReady: UIButton!
    
    @IBAction func playButton(_ sender: UIButton) {
        showActivityIndicator()
        getCoordinates()
        //getCoordinates()
        //sendCoordinates()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        setupActivityIndicator()
        getCoordinates()
    }
    
    private func setupActivityIndicator() {
        activityIndicatorView.backgroundColor = Colors.loaderBackgroungPurple
        view.addSubview(activityIndicatorView)
    }
    
    private func viewSetup() {
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.showsUserLocation = true
        playButtonReady.isEnabled = false
        playButtonReady.alpha = 0.8
        mapView.alpha = 0.95
        
        self.view.isUserInteractionEnabled = false
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        mapView.addGestureRecognizer(gesture)
    }
    
    
    private func getCoordinates() {
        RequestManager.sharedInstance.getHomeLocation { (success, apimodel, errorStatusCode) in
            switch success {
            case true:
                self.configureView()
            case false:
                if let statusCode = errorStatusCode, statusCode == 404 {
                    self.sendCoordinates()
                } else {
                    print("Unacceptable status code: \(errorStatusCode!)")
                }
            }
        }
    }
    
    private func configureView() {
        viewTitleLabel.text = "Your home location"
        viewDescriptionLabel.text = "You can accept it or choose new location - long press the screen to set new one."
    }
    
    private func sendCoordinates() {
        let doubleLongitude: Double = annotation.coordinate.longitude
        let doubleLatitude: Double = annotation.coordinate.latitude
        
        RequestManager.sharedInstance.postLocation(longitude: doubleLatitude, latitude: doubleLongitude) { (success, error) in
            if success {
                print("longitude: \(doubleLongitude), latitude: \(doubleLatitude)")
                print("Coordinates sent.")
                let boxExplorerViewController = StoryboardManager.boxExplorerViewController()
                self.present(boxExplorerViewController, animated: true, completion: nil)
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
            playButtonReady.alpha = 1.0
            playButtonReady.isEnabled = true
        }
    }
    
    private func showActivityIndicator() {
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "Loading", messageFont: UIFont.systemFont(ofSize: 15, weight: .light), type: activityIndicatorView.type, textColor: Colors.loaderLightGreen)
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

