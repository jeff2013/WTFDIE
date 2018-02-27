//
//  GooglePlacesService.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-09-30.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire
import MapKit

class GooglePlacesService {
    
    class func getNearbyRestaurants(location: CLLocationCoordinate2D, radius: String, type: String, keyword: String, completion: @escaping(DataResponse<Places>) -> Void) {
        let baseURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
        
        let parameters: [String: Any] = ["location": "\(location.latitude),\(location.longitude)", "radius": radius, "type": type, "keyword": keyword, "key": "AIzaSyBpVerz2iMPKNk864KkuzmC6UcMlPSPyDw"]
        
        Alamofire.request(baseURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response: DataResponse<Places>) in
            completion(response)
        }
    }
    
    class func getPath(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, completion: @escaping(DataResponse<Directions>) -> Void) {
        let baseURL = "https://maps.googleapis.com/maps/api/directions/json?"
        
        let parameters: [String: Any] = ["origin":"\(origin.latitude),\(origin.longitude)", "destination": "\(destination.latitude),\(destination.longitude)", "mode": "driving", "key": "AIzaSyBpVerz2iMPKNk864KkuzmC6UcMlPSPyDw"]
        
        Alamofire.request(baseURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response: DataResponse<Directions>) in
            completion(response)
        }
    }
    
//    
//    class func getAllNotifications(page: Int, length: Int, flag: Int = 2, completion: @escaping(Result<APIResponseArray<NotificationModel>, MoyaError>) -> Void ) {
//        Networking.request(target: .getAllNotifications(page: page, length: length, flag: flag)) {result in
//            completion(result)
//        }
}
