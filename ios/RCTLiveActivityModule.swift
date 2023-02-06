//
//  RCTLiveActivityModule.swift
//  notificationApp
//
//  Created by Vinícius Guedes on 04/02/23.
//

import ActivityKit
import Foundation

@objc(RCTLiveActivityModule)
class RCTLiveActivityModule: NSObject {
  
  @objc
  func startNotification() {
    let initialContentSate = NotificationAttributes.ContentState(mesage: "Hello Word startNotification!")
    let activityAttributes = NotificationAttributes(title: "My title")
    
    do {
      if #available(iOS 16.1, *){
        _ = try Activity.request(attributes: activityAttributes, contentState: initialContentSate)
      } else {
        print("Other platform")
      }
    } catch (_) {
        print("Error requesting pizza delivery Live Activity")
    }
  }
  
  @objc
  func updateNotification() {
    let initialContentSate = NotificationAttributes.ContentState(mesage: "Hello Word updateNotification!")
    if #available(iOS 16.1, *) {
      let alertConfiguration = AlertConfiguration(title: "Title Alert configuration", body: "body alert", sound: .default)
      Task{
        for activity in Activity<NotificationAttributes>.activities {
          await activity.update(using: initialContentSate, alertConfiguration: alertConfiguration)
        }
      }
    } else {
      print("Other platform")
    }
    
  }
  
  @objc
  func cancelNotification() {
    let notificationStatus = NotificationAttributes.NotificationStatus(mesage: "Hello word cancelNotifiaction")
    
    if #available(iOS 16.1, *) {
      Task{
        for activity in Activity<NotificationAttributes>.activities {
          await activity.end(using: notificationStatus, dismissalPolicy: .default)
        }
      }
    } else {
      print("Other platform")
    }
  }
  
}
