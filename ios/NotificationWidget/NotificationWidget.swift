//
//  NotificationWidget.swift
//  NotificationWidget
//
//  Created by Vinícius Guedes on 05/02/23.
//

import WidgetKit
import SwiftUI
import ActivityKit

@main
struct NotificationWidgets: WidgetBundle {
    var body: some Widget {
        if #available(iOS 16.1, *) {
          NotificationActivityWidget()
        }
    }
}

struct ContetnView: View {
  var body: some View {
    Text("Hello World")
  }
}

struct NotificationActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: NotificationAttributes.self) { context in
          ContetnView()
        } dynamicIsland: { context in
          DynamicIsland {
            DynamicIslandExpandedRegion(.leading){
              ContetnView()
            }
            DynamicIslandExpandedRegion(.trailing){
              ContetnView()
            }
            DynamicIslandExpandedRegion(.center){
              ContetnView()
            }
            DynamicIslandExpandedRegion(.bottom){
              ContetnView()
            }
          } compactLeading: {
            ContetnView()
          } compactTrailing: {
            ContetnView()
          } minimal: {
            ContetnView()
          }

        }
    }
}

struct NotificationWidgetLiveActivityPreviews: PreviewProvider {
  static let attributes = NotificationAttributes(title: "title")
    static let contentState = NotificationAttributes.ContentState(mesage: "Mesage")

    static var previews: some View {
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Island Compact")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Island Expanded")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal")
        attributes
            .previewContext(contentState, viewKind: .content)
            .previewDisplayName("Notification")
    }
}
