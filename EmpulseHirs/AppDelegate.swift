//
//  AppDelegate.swift
//  EmpulseHirs
//
//  Created by apple on 22/08/22.
//

import UIKit
import GoogleMaps
//import google maps Apikey
//Persnal


//Client
var googleMapApiKey = "AIzaSyChYnfDg2ORSMKaCddJM37G-nLla9khhME"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var currentCntrl = UIViewController()
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      //  goToScreen()
        GMSServices.provideAPIKey(googleMapApiKey)
//        GMSPlacesClient.provideAPIKey(googleMapApiKey)
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
func goToScreen(){
    if let token = UserDefaults.standard.string(forKey: "name"){
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    
        let navigationController = UINavigationController(rootViewController: initialViewControlleripad)

                    UIApplication.shared.windows.first?.rootViewController = navigationController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }else{
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
            let navigationController = UINavigationController(rootViewController: initialViewControlleripad)
                        UIApplication.shared.windows.first?.rootViewController = navigationController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
}
}
}
