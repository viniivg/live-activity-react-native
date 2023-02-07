//
//  ActivityAttributes.swift
//  notificationApp
//
//  Created by Vinícius Guedes on 05/02/23.
//

import Foundation
import ActivityKit

struct NotificationAttributes: ActivityAttributes {
  public typealias NotificationStatus = ContentState
  
  public struct ContentState: Codable, Hashable {
    var status: String
    var description: String
    var step: CGFloat
    var stepMesage: String
    var imageStep: String
  }
  var restaurant: String
  var order: String
}
