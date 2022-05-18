//
//  FullScreenAutocompleteController.swift
//  GoogleMapsDemo
//
//  Created by Rafael Benjamin on 22/05/22.
//

import UIKit
import GooglePlaces

class FullScreenAutocompleteController: UIViewController {
    
    @IBOutlet weak var placeTextField: UITextField!
    
    private var placesClient: GMSPlacesClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
    }
    
    @IBAction func placeTextFieldTouchedDown(_ sender: UITextField) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        
        let fields: GMSPlaceField =  [.name, .placeID, .formattedAddress]
        autocompleteController.placeFields = fields
        
        present(autocompleteController, animated: true, completion: nil)
    }
    
    
}

extension FullScreenAutocompleteController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name ?? "none")")
        print("Place ID: \(place.placeID ?? "none")")
        print("Place Address: \(place.formattedAddress ?? "none")")
        print("Place attributions: \(place.attributions?.string ?? "none")")
        
        if let name = place.name {
            placeTextField.text = name
        }
        dismiss(animated: true,completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}


