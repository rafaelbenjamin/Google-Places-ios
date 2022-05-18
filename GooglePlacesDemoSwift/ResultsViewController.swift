//
//  ResultsViewController.swift
//  GoogleMapsDemo
//
//  Created by Rafael Benjamin on 13/05/22.
//

import UIKit
import CoreLocation

protocol ResultsViewControllerDelegate: AnyObject {
    func didTapPlace(with coordinates: CLLocationCoordinate2D, of place: Place)
}

class ResultsViewController: UIViewController {
    
    weak var delegate:ResultsViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    private var places:[Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        self.view.backgroundColor = .clear
    }
    
    public func update(with places: [Place]){
        tableView.isHidden = false
        self.places = places
        //print(places.count)
        tableView.reloadData()
    }
    
    func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = places[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.isHidden = true
        
        let place = places[indexPath.row]
        GooglePlacesManager.shared.resolveLocation(for: place) {[weak self] result in
            switch result {
            case .success(let coordinate):
                DispatchQueue.main.async {
                    self?.delegate?.didTapPlace(with: coordinate, of: place)
                }              
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
