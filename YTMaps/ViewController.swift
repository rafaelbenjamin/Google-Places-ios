//
//  ViewController.swift
//  YTMaps
//
//  Created by Rafael Benjamin on 13/05/22.
//

import UIKit
import MapKit

class ViewController: UIViewController, UISearchResultsUpdating, UISearchControllerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let searchController = UISearchController(searchResultsController: ResultsViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Maps"
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.backgroundColor = .secondarySystemBackground
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.searchBarStyle = .minimal
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        GooglePlacesManager.shared.findPlaces(query: query) { result in
            switch result {
            case .success(let places):
                print(places)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
}

