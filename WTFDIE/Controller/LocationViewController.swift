//
//  LocationViewController.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2018-01-30.
//  Copyright © 2018 WTFDIE. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    
    let locationManager: CLLocationManager = CLLocationManager()

    @IBOutlet weak var EnableButton: UIButton!
    
    @IBOutlet weak var LocationRequestBodyLabel: UILabel!
    
    @IBOutlet weak var LocationRequestTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        
        LocationRequestTitleLabel.attributedText = "Location.Request.Title".localized.styled(.titleHeader)
        LocationRequestBodyLabel.attributedText = "Location.Request.Body".localized.styled(.labelGreyCenter)
        EnableButton.setAttributedTitle("Location.Button.Title".localized.styled(.labelWhiteCenter), for: .normal)
        
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
        
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //only update location if distance has changed by 100m
            // For testing purposes set at 100, should find a better heuristic later
            locationManager.distanceFilter = 100.0;
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func EnableLocation(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
}
