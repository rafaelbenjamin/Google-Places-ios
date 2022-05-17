//
//  ViewController.swift
//  GoogleMapsDemo
//
//  Created by Rafael Benjamin on 13/05/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UISearchResultsUpdating, UISearchControllerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var searchController:UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Maps"
        let storyboard = UIStoryboard(name: "Result", bundle: nil)
        let resultsController = storyboard.instantiateViewController(withIdentifier: "ResultsViewController")
        configureSearchController(resultsController as? ResultsViewController ?? ResultsViewController())
    }
    
    private func configureSearchController(_ searchResultsController: ResultsViewController){
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController?.searchResultsUpdater = self
        searchController?.delegate = self
        searchController?.searchBar.backgroundColor = .secondarySystemBackground
        searchController?.searchBar.barTintColor = .white
        searchController?.searchBar.searchBarStyle = .minimal
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty, let resultsVC = searchController.searchResultsController as?  ResultsViewController else { return }
        
        resultsVC.delegate = self
        
        GooglePlacesManager.shared.findPlaces(query: query) { result in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    resultsVC.update(with: places)
                }
                print(places)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}

extension MapViewController: ResultsViewControllerDelegate {
    func didTapPlace(with coordinates: CLLocationCoordinate2D) {
        searchController?.searchBar.resignFirstResponder()
        searchController?.dismiss(animated: true, completion: nil)
        
        //Remove all map pins
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        
        //Add a map pin
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        mapView.addAnnotation(pin)
        mapView.setRegion(
            MKCoordinateRegion(
                center: coordinates,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.2,
                    longitudeDelta: 0.2)),
            animated: true)
    }
}

