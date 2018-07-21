//
//  LocalNotificationManager.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 7. 8..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit
import UserNotifications


class LocalNotificationManager {
    
    class func reqeustAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, error in
            print("\(#function) error: ", error.debugDescription)
            register()
        }
    }
    
    class func register() {
        let content = UNMutableNotificationContent()
        content.title = "오늘의 추천산"
        content.body = "오늘은 \(RecommendMountains.acquire()?.name ?? "")을 올라보는건 어떨까요?"
        
        let dateComponents = DateComponents(hour: 2, minute: 00)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "Recommend", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            print("\(#function) error: ", error.debugDescription)
        }
    }
}
