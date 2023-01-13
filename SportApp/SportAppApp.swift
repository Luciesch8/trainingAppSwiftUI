//
//  SportAppApp.swift
//  SportApp
//
//  Created by Ah lucie nous gênes 🍄 on 11/01/2023.
//
import SwiftUI

/*
final class AppDelegate: NSObject, UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [ UIApplication.LaunchOptionsKey :Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
*/
@main
struct SportAppApp: App {
    
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
