//
//  Alarm.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 14/12/2020.
//

import UIKit
import UserNotifications

class Alarm: NSObject, UNUserNotificationCenterDelegate {
    
    // Pattern singleton
    public static let alarm = Alarm()
    
    // Days that are activated for the notification (1->Sunday ... 7->Sarurday)
    var notificationSunday = false
    var notificationMonday = false
    var notificationTuesday = false
    var notificationWednesday = false
    var notificationThursday = false
    var notificationFriday = false
    var notificationSaturday = false
    
    // Time for the notification
    var hour = 12
    var minutes = 00
    
    // Notificationcenter
    let notificationCenter = UNUserNotificationCenter.current()
    
    // Public init for pattern singleton
    public override init() {}
    
    private func setAlarm(day: Int, notificationDay: Bool, hour: Int, minute: Int){
        
        // Check if notification is activated for the day
        if notificationDay {
            
            // Configure the alarm
            let content = UNMutableNotificationContent()
            content.title = "It is time !"
            content.body = "Let's study your Kanji !!"
            content.sound = UNNotificationSound.default
            
            // Configure the recurring date.
            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current

            dateComponents.weekday = day
            dateComponents.hour = hour
            dateComponents.minute = minute

            // Create the trigger as a repeating event.
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: dateComponents, repeats: true)
            
            // Create the request
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString,
                        content: content, trigger: trigger)

            // Schedule the request with the system.
            notificationCenter.add(request) { (error) in
               if error != nil {
                  print("Error, Notification not sent")
               }
            }
            
        } else {
            print("\(day) is not activated")
        }
    }
    
    // Set alarms for all weekday
    func setAllAlarms () {
        // Remove all pendings notifications
        notificationCenter.removeAllPendingNotificationRequests()
        
        // Set the notification for each day of the week
        setAlarm(day: 1, notificationDay: notificationSunday, hour: hour, minute: minutes)
        setAlarm(day: 2, notificationDay: notificationMonday, hour: hour, minute: minutes)
        setAlarm(day: 3, notificationDay: notificationTuesday, hour: hour, minute: minutes)
        setAlarm(day: 4, notificationDay: notificationWednesday, hour: hour, minute: minutes)
        setAlarm(day: 5, notificationDay: notificationThursday, hour: hour, minute: minutes)
        setAlarm(day: 6, notificationDay: notificationFriday, hour: hour, minute: minutes)
        setAlarm(day: 7, notificationDay: notificationSaturday, hour: hour, minute: minutes)
    }
    
    // MARK: Database methods
    // Method to save alarm parameters in the database
    func saveAlarmParameters() {
        // Save the object in the context
        let alarmParameters = AlarmEntity(context: AppDelegate.viewContext)
        alarmParameters.mondayNotification = notificationMonday
        alarmParameters.tuesdayNotification = notificationTuesday
        alarmParameters.wednesdayNotification = notificationWednesday
        alarmParameters.thursdayNotification = notificationThursday
        alarmParameters.fridayNotification = notificationFriday
        alarmParameters.saturdayNotification = notificationSaturday
        alarmParameters.sundayNotification = notificationSunday
        
        alarmParameters.hour = Int16(hour)
        alarmParameters.minutes = Int16(minutes)
        
        // Save the context
        try? AppDelegate.viewContext.save()
    }
    
    // Database method to charge the saved data
    func chargeAlarmParameters () {
        
        for i in AlarmEntity.all {
            notificationMonday = i.mondayNotification
            notificationTuesday = i.tuesdayNotification
            notificationWednesday = i.wednesdayNotification
            notificationThursday = i.thursdayNotification
            notificationFriday = i.fridayNotification
            notificationSaturday = i.saturdayNotification
            notificationSunday = i.sundayNotification
            
            hour = Int(i.hour)
            minutes = Int(i.minutes)
        }
    }
    
    
}
