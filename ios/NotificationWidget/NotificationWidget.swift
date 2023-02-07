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

struct ProgressBar: View {
  var width1: CGFloat = 80
  var width2: CGFloat = 180
  var width3: CGFloat = 60
  var heght: CGFloat = 5
  var percent1: CGFloat = 80
  var percent2: CGFloat = 180
  var percent3: CGFloat = 0
  private var gradientColors = [
    Color(.green),
    Color(.black).opacity(0)
  ]
  
  private var gradientColorsCompleted = [
    Color(.green),
    Color(.green)
  ]

  var body: some View {
    let multiplier1 = width1 / 80
    let multiplier2 = width2 / 180
    let multiplier3 = width3 / 60

    VStack {
      HStack{
        ZStack(alignment: .leading){
          RoundedRectangle(cornerRadius: heght, style: .continuous)
            .frame(width: width1, height: heght)
            .foregroundColor(Color.black.opacity(0.1))

          RoundedRectangle(cornerRadius: heght)
            .frame(width: percent1 * multiplier1, height: heght)
            .background(LinearGradient(gradient: Gradient(colors: gradientColorsCompleted),
              startPoint: UnitPoint.leading, endPoint: .trailing)
              .clipShape(RoundedRectangle(cornerRadius: heght, style: .continuous))
            )
            .foregroundColor(.clear)
        }
        
        ZStack(alignment: .leading){
          RoundedRectangle(cornerRadius: heght, style: .continuous)
            .frame(width: width2, height: heght)
            .foregroundColor(Color.black.opacity(0.1))

          RoundedRectangle(cornerRadius: heght)
            .frame(width: percent2 * multiplier2, height: heght)
            .background(LinearGradient(gradient: Gradient(colors: gradientColors),
              startPoint: UnitPoint.leading, endPoint: .trailing)
              .clipShape(RoundedRectangle(cornerRadius: heght, style: .continuous))
            )
            .foregroundColor(.clear)
        }
        
        ZStack(alignment: .leading){
          RoundedRectangle(cornerRadius: heght, style: .continuous)
            .frame(width: width3, height: heght)
            .foregroundColor(Color.black.opacity(0.1))

          RoundedRectangle(cornerRadius: heght)
            .frame(width: percent3 * multiplier3, height: heght)
            .background(LinearGradient(gradient: Gradient(colors: gradientColors),
              startPoint: UnitPoint.leading, endPoint: .trailing)
              .clipShape(RoundedRectangle(cornerRadius: heght, style: .continuous))
            )
            .foregroundColor(.clear)
        }
      }
    }
  }
}

struct ContetnView: View {
  var body: some View {
    Text("Hello World")
  }
}

struct ContentNotification: View {
  var body: some View {

    VStack(alignment: .leading) {
      HStack(alignment: .center) {
        Image("logoBurgao")
          .resizable()
          .frame( width: 50,height: 50)
          .background(.white)
          .cornerRadius(8)
        
        VStack(alignment: .leading){
          Text("Burgão do Zé")
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
          
          HStack{
            Text("Pedido:")
              .font(.subheadline)
              .fontWeight(.light)
              .foregroundColor(.gray)
            Text("#1234")
              .font(.subheadline)
              .fontWeight(.bold)
              .foregroundColor(.gray)
          }
        }
      }
      
      Text("Estamos preparando o seu burgão.")
        .font(.subheadline)
        .fontWeight(.regular)
        .foregroundColor(.gray)
      
      ProgressBar()
      
      Text("Em até 30 minutos seu pedido sai para entrega.")
        .font(.caption)
        .fontWeight(.regular)
        .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.755))
    }
    .frame(maxWidth: .infinity)
    .padding(16)
    .background(.white)
  }
}

struct ContentViewLeading: View {
  var body: some View {
    VStack(alignment: .trailing) {
      Image("logoBurgao")
        .resizable()
        .frame( width: 26,height: 26)
        .background(.white)
        .cornerRadius(30)
    }
  }
}

struct ContentViewTrailing: View {
  var body: some View {
    Image(systemName: "clock")
      .resizable()
      .frame( width: 22,height: 22)
      .foregroundColor(.gray)
  }
}

struct NotificationActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: NotificationAttributes.self) { context in
          ContentNotification()
        } dynamicIsland: { context in
          DynamicIsland {
            DynamicIslandExpandedRegion(.leading){
              Text("Leading")
            }
            DynamicIslandExpandedRegion(.trailing){
              Text("Trailing")
            }
            DynamicIslandExpandedRegion(.center){
              Text("Center")
            }
            DynamicIslandExpandedRegion(.bottom){
              Text("Bottom")
            }
          } compactLeading: {
            ContentViewLeading()
          } compactTrailing: {
            ContentViewTrailing()
          } minimal: {
            ContentViewTrailing()
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
