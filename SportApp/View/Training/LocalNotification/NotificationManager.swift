//
//  NotificationManager.swift
//  SportApp
//
//  Created by Ah lucie nous gênes 🍄 on 13/01/2023.
//

import Foundation
import UserNotifications

final class NotificationManager: ObservableObject {
    
    @Published private(set) var notifications: [UNNotificationRequest] = []
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    
    func reloadAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    func requestAuthorization(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, _ in
            DispatchQueue.main.async {
                self.authorizationStatus = isGranted ? .authorized : .denied
            }
        }
    }
    
    
    func reloadLocalNotification(){
        print("reloadLocalNotification")
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications  in
            DispatchQueue.main.async {
                self.notifications = notifications
            }
        }
    }
    
    func createLocalNotification(title: String, hour: Int, minute: Int, completion: @escaping (Error?) -> Void){
        var dateComportement = DateComponents()
        dateComportement.hour = hour
        dateComportement.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComportement, repeats: true)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.sound = .default
        notificationContent.body = "Some Message"
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler : completion)
    }
    
    func deleteLocalNotifications(identifiers: [String]){
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: identifiers)
    }

}
