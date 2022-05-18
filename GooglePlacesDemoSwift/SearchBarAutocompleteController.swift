//
//  SearchBarAutocompleteController.swift
//  GoogleMapsDemo
//
//  Created by Rafael Benjamin on 22/05/22.
//

import UIKit
import GooglePlaces

class SearchBarAutocompleteController: UIViewController {
    
    @IBOutlet weak var searchView: UIView!
    private var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Bar"
        
        let resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        searchController?.searchBar.sizeToFit()
        searchView.addSubview(searchController?.searchBar ?? UISearchBar())
        
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        resultsViewController.autocompleteFilter = filter
        
        let fields: GMSPlaceField =  [.name, .placeID, .formattedAddress]
        resultsViewController.placeFields = fields
        
        //definesPresentationContext = true
        
        searchController?.hidesNavigationBarDuringPresentation = false
    }
    
}

extension SearchBarAutocompleteController:GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        
        searchController?.isActive = false
        print("Place name: \(place.name ?? "none")")
        print("Place ID: \(place.placeID ?? "none")")
        print("Place Address: \(place.formattedAddress ?? "none")")
        print("Place attributions: \(place.attributions?.string ?? "none")")
        
        if let formattedAddress = place.formattedAddress {
            searchController?.searchBar.searchTextField.text = formattedAddress
        }
        
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
}

