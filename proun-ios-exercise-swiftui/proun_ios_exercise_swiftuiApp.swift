//
//  proun_ios_exercise_swiftuiApp.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 1/9/21.
//

import SwiftUI
import GoogleMaps

let mapsApiKey = "AIzaSyAIgDNybKUgtY_1oIFhiwzUfNMrJNRCJ8M"

@main
struct proun_ios_exercise_swiftuiApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            MainView()
            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate    {
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
         GMSServices.provideAPIKey(mapsApiKey)
         return true
     }
 }
