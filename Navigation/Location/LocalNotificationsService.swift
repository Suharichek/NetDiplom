//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Suharik on 14.10.2022.
//

import Foundation
import UserNotifications

final class LocalNotificationsService: NSObject {
    
    let center = UNUserNotificationCenter.current()
    static var shared = LocalNotificationsService()
    
    func registeForLatestUpdatesIfPossible() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) {
            granted, error in
            guard granted else {return}
            self.registerUpdatesCategory()
            if let error = error {
                print("errorAlertMessage".localized + error.localizedDescription)
            }
        }
    }
    
    func sendNotification() {
        let content = UNMutableNotificationContent()
        var components = DateComponents()
        components.hour = 9
        components.minute = 35
        content.categoryIdentifier = "Homework"
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        content.title = "contentTitle".localized
        content.body = "contentBody".localized
        content.badge = 1
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func registerUpdatesCategory() {
        let actionShow = UNNotificationAction(identifier: "Показать", title: "Показать больше", options: .foreground)
        let actionHide = UNNotificationAction(identifier: "Спрятать", title: "Спрятать текст", options: .destructive)
        let category = UNNotificationCategory(identifier: "Homework", actions: [actionShow, actionHide], intentIdentifiers: [])
        center.setNotificationCategories([category])
    }
}

extension LocalNotificationsService: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .banner])
    }
}
