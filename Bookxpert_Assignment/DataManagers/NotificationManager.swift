//
//  NotificationManager.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 27/05/25.
//

import Foundation
import UserNotifications

class NotificationManager{
    static let shared = NotificationManager()
    
    private init(){}
    
    func requestNotificationPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success{
                print("Permission Granted \(success)")
            }else{
                print("Permission Denied")
            }
        }
    }
    
    func sendDeletedNotification(for device: DeviceObjects){
        let content = UNMutableNotificationContent()
        content.title = "Device Deleted"
        content.body = "\(device.name ?? "Unknown Device") has been deleted"
        content.sound = .default
        
        // Notification will trigger after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request){ error in
            if let error = error{
                print("Notification error: \(error)")
            }else{
                print(" Notification scheduled for: \(device.name ?? "")")
//                DispatchQueue.main.async {
//                    let alert = UIAlertController(title: "Notification Scheduled", message: "But it may not show in simulator!", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .default))
//                    UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
//                }
            }
        }
    }
}
