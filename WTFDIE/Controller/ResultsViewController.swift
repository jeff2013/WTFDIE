//
//  ResultsViewController.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-10-26.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces
import SafariServices

protocol showDetailDelegate {
    func showDetail()
}

class ResultsViewController: UIViewController {
    
    var places: [Restaurant] = []
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var draggableView: DraggableView!
    
    @IBOutlet weak var leftLineImage: UIImageView!
    @IBOutlet weak var rightLineImage: UIImageView!
    
    var location: CLLocationCoordinate2D!
    
    var destination: CLLocationCoordinate2D!
    
    var selectedRestaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        collectionView.registerCellTypes(types: [PlaceCollectionViewCell.self])
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        
        draggableView.customViewHeight = collectionViewHeight
        setupCarousel()
        
        leftLineImage.layer.borderColor = UIColor.blue.cgColor
        leftLineImage.layer.borderWidth = 2.0
        
        if let firstPlace = places.first {
            destination = CLLocationCoordinate2D(latitude: firstPlace.latitude, longitude: firstPlace.longitude)
        }
    }
    
    private func setupCarousel() {
        let cellScaling:CGFloat = 0.8
        let screenSize = collectionView.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        
        let insetX = (collectionView.bounds.width - cellWidth) / 2
        let insetY = (collectionView.bounds.height - cellHeight) / 2
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
    }
    
    private func setupMap() {
        createAnnotation(for: location)
    }
    
    private func createAnnotation(for location: CLLocationCoordinate2D) {
        mapView.animate(toLocation: location);
        mapView.camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 16.0)
        
        let marker = GMSMarker(position: location)
        marker.style(with: MarkerType.currentLocation)
        marker.map = mapView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Fallback on earlier versions
        }
        setupMap()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    // Can't be done with a ternary operator, not sure why
    // Above line is untrue 
    // Nope writing code at 4am probably makes me write dumb things
    @IBAction func toggleCollectionView(_ sender: Any) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            if self.collectionViewHeight.constant == 344.0 {
                self.collectionViewHeight.constant = 50
            } else {
                self.collectionViewHeight.constant = 344
            }
            self.view.layoutIfNeeded()
        })
        
        guard let destination = destination else {
            return
        }
        
        plotPath(with: destination)
        
//        let frame: CGRect = leftLineImage.frame
//        let oldAnchorPoint = leftLineImage.layer.anchorPoint
//        let newAnchorPoint = CGPoint(x: 1.0, y: 0.0)
//
//        let offSetFrameX = leftLineImage.bounds.width * (newAnchorPoint.x-oldAnchorPoint.x)
//        let offSetFrameY = leftLineImage.bounds.height * (newAnchorPoint.y-oldAnchorPoint.y)
//        self.leftLineImage.transform = CGAffineTransform.init(translationX: leftLineImage.bounds.width/2, y: leftLineImage.bounds.height/2)
//        leftLineImage.layer.anchorPoint = newAnchorPoint
//        self.view.layoutIfNeeded()
//        UIView.animateKeyframes(withDuration: 1, delay: 0, animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
////                self.leftLineImage.transform = CGAffineTransform(translationX: offSetFrameX, y: offSetFrameY)
//                self.leftLineImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
//
//            })
//        })
//
        //leftLineImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
        
        
    }
    
    func plotPath(with destination: CLLocationCoordinate2D) {
        GooglePlacesService.getPath(origin: location, destination: destination) { (result) in
            if let directions = result.value, let routes = directions.routes, let route = routes.first, let points = route.points {
                self.mapView.clear()
                
                self.createAnnotation(for: self.location)
                self.createAnnotation(for: destination)
                let path = GMSPath(fromEncodedPath: points)
                let polyline = GMSPolyline(path: path)
                polyline.strokeWidth = 3.0
                polyline.map = self.mapView
                let bounds = GMSCoordinateBounds(path: path!)
                let cameraUpdate = GMSCameraUpdate.fit(bounds)
                self.mapView.animate(with: cameraUpdate)
            }
        }
    }
    
    func getWebsiteInformation() {
        
    }
}
// MARK: UICollectionViewDataSource
extension ResultsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        //return places.count
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:PlaceCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCollectionViewCell.defaultReuseIdentifier, for: indexPath) as! PlaceCollectionViewCell
        cell.configureCell(object: (places[indexPath.row], CLLocation(latitude: location.latitude, longitude: location.longitude)))
        cell.backgroundColor = UIColor.lightGray
        cell.delegate = self
        return cell
    }
    
    func updateMapDirections(for selectedPlace: Restaurant) {
            let client = GMSPlacesClient.shared()
            client.lookUpPlaceID(selectedPlace.id, callback: { (place, error) -> Void in
                //selectedPlace.website = place?.website
                if let url = place?.website {
                    let vc = SFSafariViewController(url: url)
                    //let vc = SFSafariViewController(url: url, configuration: config)
                    self.present(vc, animated: true)
                    print("PRESENTED")
                    return
                } else {
                    print("URL NIL")
                }
                //let config = SFSafariViewController.Configuration()
               
            })
        
        
    }
    
}

// MARK: UICollectionViewDelegate
extension ResultsViewController: UICollectionViewDelegate {
    
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
}


extension ResultsViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidth = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = round((offset.x + scrollView.contentInset.left) / cellWidth)
        
        offset = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
        
        let selectedRestaurant = places[Int(index)]
        let destination: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: selectedRestaurant.latitude, longitude: selectedRestaurant.longitude)
        createAnnotation(for: destination)
        let bounds = GMSCoordinateBounds(coordinate: destination, coordinate: destination)
        mapView.animate(with: GMSCameraUpdate.fit(bounds))
        mapView.animate(toZoom: 16.0)
        mapView.animate(with: GMSCameraUpdate.scrollBy(x: 0, y: 100))
        self.destination = destination
        self.selectedRestaurant = selectedRestaurant

    }   
}

extension ResultsViewController: showDetailDelegate {
    
    func showDetail() {
        guard let selectedRestaurant = selectedRestaurant else {
            return
        }
        updateMapDirections(for: selectedRestaurant)
    }
}
