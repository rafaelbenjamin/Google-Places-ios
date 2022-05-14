//
//  GooglePlacesManager.swift
//  YTMaps
//
//  Created by Rafael Benjamin on 13/05/22.
//

import Foundation
import GooglePlaces

struct Place {
    let name: String
    let identifier: String
}

final class GooglePlacesManager {
    static let shared = GooglePlacesManager()
    
    private let client = GMSPlacesClient.shared()
    
    private init(){}
    
    enum PlacesError: Error {
        case failedToFind
    }
    
    public func setUp(){
        GMSPlacesClient.provideAPIKey(self.apiKey)
    }
    
    public func findPlaces(query: String,
                           completion: @escaping(Result<[Place], Error>) -> Void
                           
    ){
        let filter = GMSAutocompleteFilter()
        filter.type = .geocode
        client.findAutocompletePredictions(fromQuery: query, filter: filter, sessionToken: nil) {
            results, error in
            guard let results = results, error == nil else {
                completion(.failure(PlacesError.failedToFind))
                return
            }
            
            let places: [Place] = results.compactMap({
                Place(
                    name: $0.attributedFullText.string,
                    identifier: $0.placeID)
            })
            
            completion(.success(places))
            
        }
    }
}

//MARK: - Get Api Keys from Keys.plist
extension GooglePlacesManager {
    private var apiKey: String {
           get {
               guard let filePath = Bundle.main.path(forResource: "Keys", ofType: "plist") else {
                   fatalError("Couldn't find file 'Keys.plist'.")
               }
               let plist = NSDictionary(contentsOfFile: filePath)
               guard let value = plist?.object(forKey: "GooglePlacesKey") as? String else {
                   fatalError("Couldn't find key 'GooglePlacesKey' in 'Keys.plist'.")
               }
               if (value.starts(with: "_")) {
                   fatalError("Register for a Google Places developer account and get an API key at https://developers.google.com/maps/documentation/places/ios-sdk/get-api-key")
               }
               return value
           }
       }
}
