//
//  TabBarController.swift
//  GoogleMapsDemo
//
//  Created by Rafael Benjamin on 22/05/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configTabBar()
    }
        
    private func configTabBar(){
        tabBar.layer.borderWidth = 0.1
        tabBar.layer.borderColor = UIColor.black.cgColor
        tabBar.backgroundColor = .white
    }
    
}
