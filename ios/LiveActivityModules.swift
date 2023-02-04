//
//  LiveActivity.swift
//  notificationApp
//
//  Created by Vinícius Guedes on 04/02/23.
//

import Foundation

@objc(LiveActivityModules)
class LiveActivityModules: NSObject {
  
  @objc(startNotificaton:withMessage:)
  func startNotificaton(title: String, message: String) -> Void {
    print("startNotificaton")
  }
  
  @objc(updateNotificaton)
  func updateNotificaton() {
    print("updateNotificaton")
  }
  
  @objc(cancelNotificaton)
  func cancelNotificaton() {
    print("cancelNotificaton")
  }
  
}
