//
//  ResultsViewController.swift
//  YTMaps
//
//  Created by Rafael Benjamin on 13/05/22.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var places:[Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        //self.view.backgroundColor = .systemBlue
    }
    
    public func update(with places: [Place]){
        self.places = places
        print(places.count)
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
    
}
