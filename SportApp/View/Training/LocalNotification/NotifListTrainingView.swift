//
//  PlanTrainingView.swift
//  SportApp
//
//  Created by Ah lucie nous gênes 🍄 on 13/01/2023.
//

import SwiftUI

struct NotifListView: View {
    @StateObject private var notificationManager = NotificationManager()
    @State private var isCreatePresented = false
    
    private static var notificationDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    private func timeDisplayText(from notification: UNNotificationRequest) -> String {
        guard let nextTriggerDate = (notification.trigger as? UNCalendarNotificationTrigger)?.nextTriggerDate() else { return ""}
        return Self.notificationDateFormatter.string(from: nextTriggerDate)
    }
    
    @ViewBuilder
    var infoOverlayView: some View {
        switch notificationManager.authorizationStatus {
        case .authorized:
            if notificationManager.notifications.isEmpty {
                InfoOverlayView(infoMessage: "No notification Yet",
                                buttonTitle: "Create",
                                systemImageName: "plus.circle",
                                action: {
                        isCreatePresented = true
                    }
                )
            }
        case .denied:
            InfoOverlayView(infoMessage: "Please Enable Notification Permission In Setting",
                            buttonTitle: "Setting",
                            systemImageName: "gear",
                            action: {
                if let url = URL(string: UIApplication.openSettingsURLString),
                    UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            )
        default:
            EmptyView()
        }
    }
    
    var body: some View {
        List{
            ForEach (notificationManager.notifications, id: \.identifier) { notification in
                HStack{
                    Text(notification.content.title)
                        .fontWeight(.semibold)
                    Text(timeDisplayText(from: notification))
                        .fontWeight(.bold)
                    Spacer()

                }

            }
            .onDelete(perform: delete)
        }
        
        .listStyle(InsetGroupedListStyle())
        .overlay(infoOverlayView)
        .navigationTitle("Notification")
        .onAppear(perform: notificationManager.reloadAuthorizationStatus)
        .onChange(of: notificationManager.authorizationStatus){ AuthorizationStatus in
            switch AuthorizationStatus {
            case .notDetermined:
                //request authorization
                notificationManager.requestAuthorization()
            break
            case .authorized:
                // get local notifications
                notificationManager.reloadLocalNotification()
            break
            default:
                break
            }
        }
        
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)){ _ in
            notificationManager.reloadAuthorizationStatus()
        }
        
        .navigationBarItems(trailing: Button {
            isCreatePresented = true
        } label: {
            Image(systemName: "plus.circle")
                .imageScale(.large)
        })
        .sheet(isPresented: $isCreatePresented){
            NavigationView{
                CreateNotificationView(
                    notificationManager: notificationManager,
                    isPresented: $isCreatePresented
                )
            }
            .accentColor(.primary)

        }

        
        
    }
}


extension NotifListView{
    func delete(_ indexSet : IndexSet){
        notificationManager.deleteLocalNotifications(
            identifiers: indexSet.map {
            notificationManager.notifications[$0].identifier
        })
        notificationManager.reloadLocalNotification()
    }
}

struct NotifListView_Previews: PreviewProvider {
    static var previews: some View {
        NotifListView()
    }
}
