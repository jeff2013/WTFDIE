//
//  DecisionViewController.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-09-28.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import MapKit
import CoreLocation
import GooglePlacePicker

//https://developers.google.com/places/web-service/search
class DecisionViewController: UIViewController {
    
    @IBOutlet weak var locationTitleLabel: UILabel!
    
    @IBOutlet weak var currentLocationLabel: UILabel!
    
    @IBOutlet weak var gpsImageView: UIImageView!

    private var locationManager = CLLocationManager()
    
    @IBOutlet weak var changeLocationBarButtonItem: UIBarButtonItem!
    
    var location: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.setTitle(title: "Location")
            title = "Location"
            navigationController?.navigationBar.largeTitleTextAttributes =
                [NSAttributedStringKey.font: UIFont(.helveticaNeueMedium, size: 30),
                 NSAttributedStringKey.foregroundColor: UIColor(.azureBlue)]
        } else {
            // Fallback on earlier versions
        }
        
        gpsImageView.animateCircle(with: 2.0, shouldRepeat: true)
        
        //locationManager.requestWhenInUseAuthorization()
       
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //only update location if distance has changed by 100m
            // For testing purposes set at 100, should find a better heuristic later
            locationManager.distanceFilter = 100.0;
            locationManager.startUpdatingLocation()
        }
    }
    
    func getCurrentLocation(){
        gpsImageView.image = UIImage(named: "gps_icon_green")
        gpsImageView.animateCircle(with: 2.0, shouldRepeat: true)
    }
    
    
    
    func rotateAnyView(with view: UIView, fromValue: Double, toValue: Float, duration: Double = 1) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = duration
        animation.fromValue = fromValue
        animation.toValue = toValue
        view.layer.add(animation, forKey: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func selectLocation(_ sender: Any) {
        launchPlacePicker()
    }
    
    @IBAction func configureSearch(_ sender: Any) {
        gpsImageView.image = UIImage(named: "gps_icon_green")
        gpsImageView.resetAnimation()
        gpsImageView.layer.removeAllAnimations()
        let destViewController: OptionsViewController = OptionsViewController.instanceFromStoryboard(storyboard: .optionsViewController)
        destViewController.location = location
        navigationController?.pushViewController(destViewController, animated: true)
    }
    
//    private func retreiveRestaurants() {
//        //let location = CLLocation(latitude: 49.285167, longitude: -123.125770)
//        if let location = location {
//            GooglePlacesService.getNearbyRestaurants(location: location, radius: "5000", type: "restaurant", keyword: "seafood") { (result) in
//                let x = result
//            }
//        } else {
//            // No location selected
//        }
//    }
    
    private func launchPlacePicker() {
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        
        present(placePicker, animated: true, completion: nil)
    }
    
    private func getAddress(from location: CLLocation, completion: @escaping (String) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let placemark = placemarks?.first,
                let subThoroughfare = placemark.subThoroughfare,
                let thoroughfare = placemark.thoroughfare,
                let locality = placemark.locality,
                let administrativeArea = placemark.administrativeArea {
                let address = subThoroughfare + " " + thoroughfare + ", " + locality + " " + administrativeArea
                
                placemark.addressDictionary
                
                return completion(address)
                
            }
            completion("No location found")
        }
    }
    @IBAction func changeLocation(_ sender: UIBarButtonItem) {
         launchPlacePicker()
    }
}

extension DecisionViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = manager.location {
            location = currentLocation.coordinate
            getAddress(from: currentLocation) { (address) in
                self.gpsImageView.image = UIImage(named: "gps_icon_green")
                self.gpsImageView.animateCircle(with: 2.0, shouldRepeat: false)
                self.currentLocationLabel.attributedText = address.localized.styled(.labelWhiteCenter)
            }
        } else {
            
            gpsImageView.image = UIImage(named: "gps_icon_red")
            gpsImageView.resetAnimation()
        }
       
    }
}


extension DecisionViewController: GMSPlacePickerViewControllerDelegate {
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        currentLocationLabel.attributedText = place.name.localized.styled(.labelWhiteCenter)
        location = place.coordinate
        gpsImageView.image = UIImage(named: "gps_icon_green")
        locationManager.stopUpdatingLocation()
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        if location == nil {
            gpsImageView.image = UIImage(named: "gps_icon_red")
            gpsImageView.resetAnimation()
        }
    }
}


