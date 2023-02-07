//
//  NotificationWidget.swift
//  NotificationWidget
//
//  Created by Vinícius Guedes on 05/02/23.
//

import WidgetKit
import SwiftUI
import ActivityKit

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


@main
struct NotificationWidgets: WidgetBundle {
    var body: some Widget {
        if #available(iOS 16.1, *) {
          NotificationActivityWidget()
        }
    }
}


struct ProgressBar: View {
  var step: CGFloat = 1
  var dark: Bool = false
  

  var body: some View {
    let activitieColor =  Color(hexStringToUIColor(hex: "#48EAB6"))
    let inactiveColor = self.dark ? Color(.white).opacity(0.3) : Color(.black).opacity(0.1)
    let width1: CGFloat = 80
    let width2: CGFloat = 160
    let width3: CGFloat = 60
    let heght: CGFloat = 5

    VStack {
      HStack{
          RoundedRectangle(cornerRadius: heght, style: .continuous)
            .frame(width: width1, height: heght)
            .foregroundColor(step >= 1 ? activitieColor : inactiveColor)
        
          RoundedRectangle(cornerRadius: heght, style: .continuous)
            .frame(width: width2, height: heght)
            .foregroundColor(step >= 2 ? activitieColor : inactiveColor)
        
          RoundedRectangle(cornerRadius: heght, style: .continuous)
            .frame(width: width3, height: heght)
            .foregroundColor(step >= 3 ? activitieColor : inactiveColor)
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
  let context: ActivityViewContext<NotificationAttributes>
  var body: some View {

    VStack(alignment: .leading) {
      HStack(alignment: .center) {
        Image("logoBurgao")
          .resizable()
          .frame( width: 50,height: 50)
          .background(.white)
          .cornerRadius(8)
        
        VStack(alignment: .leading){
          Text(context.attributes.restaurant)
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
          
          HStack{
            Text("Pedido:")
              .font(.subheadline)
              .fontWeight(.light)
              .foregroundColor(.gray)
            Text(context.attributes.order)
              .font(.subheadline)
              .fontWeight(.bold)
              .foregroundColor(.gray)
          }
        }
      }
      
      Text(context.state.status)
        .font(.subheadline)
        .fontWeight(.regular)
        .foregroundColor(.gray)
      
      ProgressBar(step: context.state.step)
      
      Text(context.state.description)
        .font(.caption)
        .fontWeight(.regular)
        .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.755))
    }
    .frame(maxWidth: .infinity)
    .padding(16)
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

struct ContentViewExpandedLeading: View {
  let context: ActivityViewContext<NotificationAttributes>
  var body: some View {

    VStack(alignment: .leading) {
      Image(context.state.imageStep)
        .resizable()
        .frame( width: 90,height: 65)
      
      
      VStack(alignment: .leading) {
        Text(context.state.stepMesage)
          .font(.title3)
          .fontWeight(.bold)
          .foregroundColor(Color.white)
        
        Text(context.state.status)
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundColor(Color.white)
        
        ProgressBar(step: context.state.step, dark: true)
        }
      
    }
    .padding(.horizontal, 26)
    .frame(maxWidth: .infinity)
  }
}

struct NotificationActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: NotificationAttributes.self) { context in
          VStack{
            ContentNotification(context: context)
          }
          .activitySystemActionForegroundColor(.white)
                  .activityBackgroundTint(.white)
                  .background(.white)
        } dynamicIsland: { context in
          DynamicIsland {
            DynamicIslandExpandedRegion(.leading, priority: 1){
              ContentViewExpandedLeading(context: context)
            }
          }
            compactLeading: {
            ContentViewLeading()
          } compactTrailing: {
            ContentViewTrailing()
          } minimal: {
            ContentViewTrailing()
          }
          .keylineTint(.white)
          .contentMargins(.all, 0, for: .expanded)
        }
    }
}

struct NotificationWidgetLiveActivityPreviews: PreviewProvider {
  static let attributes = NotificationAttributes(restaurant: "Burgão do Zé", order: "#423")
    static let contentState = NotificationAttributes.ContentState(status: "Estamos preparando o seu burgão.", description: "Em até 30 minutos seu pedido sai para entrega.", step: 3, stepMesage: "Boas notícias!", imageStep: "delivery")

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
