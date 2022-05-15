//
//  AppDelegate.swift
//  GoogleMapsDemo
//
//  Created by Rafael Benjamin on 13/05/22.
//

import GooglePlaces
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSPlacesClient.provideAPIKey(self.apiKey)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

//MARK: - Get Api Keys from Keys.plist
extension AppDelegate {
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
                   fatalError("Register for a Google Cloud Platform developer account and get an API key at https://developers.google.com/maps/documentation/places/ios-sdk/cloud-setup")
               }
               return value
           }
       }
}

