//
//  RCTLiveActivityModule.swift
//  notificationApp
//
//  Created by Vinícius Guedes on 04/02/23.
//

import Foundation

@objc(RCTLiveActivityModule)
class RCTLiveActivityModule: NSObject {
  
  @objc
  func startNotification() {
    print("startNotification")
  }
  
  @objc
  func updateNotification() {
    print("updateNotification")
  }
  
  @objc
  func cancelNotification() {
    print("cancelNotification")
  }
  
}
