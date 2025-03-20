//
//  LocalNotificationSmaple.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 19.03.2025.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { _, error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            } else {
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "NOTIFICATION"
        content.subtitle = "SUBNOTIFICATION"
        content.sound = .default
        content.badge = 1
        
        // time
        // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 20
//        dateComponents.minute = 18
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // location
        let coordinates = CLLocationCoordinate2D(latitude: 55.00, longitude: 37.00)
        
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func updateBadge() {
        UNUserNotificationCenter.current().setBadgeCount(0)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

struct LocalNotificationSmaple: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Request Permission") {NotificationManager.instance.requestAuthorization()}
                .buttonStyle(.borderedProminent)
                .foregroundStyle(.wb)
            Button("Schedule Notification") {NotificationManager.instance.scheduleNotification()}
                .buttonStyle(.borderedProminent)
                .foregroundStyle(.wb)
            Button("Cancel Notification") {NotificationManager.instance.cancelNotification()}
                .buttonStyle(.borderedProminent)
                .foregroundStyle(.wb)
        }
        .onAppear {
            NotificationManager.instance.updateBadge()
        }
    }
}

#Preview {
    LocalNotificationSmaple()
}
