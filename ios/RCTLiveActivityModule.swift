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
  
  @objc(startNotification:withOrder:withStatus:withDescription:withStep:withStepMesage:withImageStep:)
  func startNotification(_ restaurant: String, _ order: String, _ status: String, _ description: String, _ step: CGFloat, _ stepMesage: String, _ imageStep: String) {
    let initialContentSate = NotificationAttributes.ContentState(status: status, description: description, step: step, stepMesage: stepMesage, imageStep: imageStep)
    let activityAttributes = NotificationAttributes(restaurant: restaurant, order: order)

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
  
  @objc(updateNotification:withDescription:withStep:withStepMesage:withImageStep:)
  func updateNotification(_ status: String, _ description: String, _ step: CGFloat, _ stepMesage: String, _ imageStep: String) {
    let initialContentSate = NotificationAttributes.ContentState(status: status, description: description, step: step, stepMesage: stepMesage, imageStep: imageStep)
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
  
  @objc(cancelNotification:withDescription:withStep:withStepMesage:withImageStep:)
  func cancelNotification(_ status: String, _ description: String, _ step: CGFloat, _ stepMesage: String, _ imageStep: String) {
    let notificationStatus = NotificationAttributes.NotificationStatus(status: status, description: description, step: step, stepMesage: stepMesage, imageStep: imageStep)
    
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
