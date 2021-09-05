//
//  EventCell.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 4/9/21.
//

import SwiftUI

struct EventCell: View {
    
    var event: EventModel
    
    
    var body: some View {
        
        let date = event.fromDatetime ?? ""
        
        HStack (alignment: .top, spacing: 18){
            VStack(spacing: -2) {
                Text(formatDate(date: date, format: "d"))
                    .font(Font.custom("TradeGothicLTStd-BdCn20", size: 38))
                    .foregroundColor(isInThisMonth(date: date) ? .white : Color("Text"))
                    .textCase(.uppercase)
                Text(formatDate(date: date, format: "MMM"))
                    .font(Font.custom("TradeGothicLTStd-BdCn20", size: 22))
                    .foregroundColor(isInThisMonth(date: date) ? .white : Color("Text"))
                    .textCase(.uppercase)
            }
            .frame(width: 60, height: 60)
            .padding(10)
            .padding(.top, 4)
            
            .background(Color(isInThisMonth(date: date) ? "PrimaryColor" : "BackgroundEventIcon"))
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title ?? "")
                    .font(Font.custom("TradeGothicLTStd-BdCn20", size: 22))
                    .foregroundColor(Color("Text"))
                
                Text(formatDate(date: event.fromDatetime ?? "", format: "d 'de' MMMM 'a las' HH:mm"))
                    .foregroundColor(Color("TextLight"))
            }
            .padding(.top, 8)
        }
        .frame(height: 90)
    }
    
    
    func formatDate(date: String, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "ES_es")
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = format
        return  dateFormatter.string(from: date!)
    }
    
    func isInThisMonth(date: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "ES_es")
        let date = dateFormatter.date(from: date)
        return date?.isInThisMonth ?? false
    }
}

struct EventCell_Previews: PreviewProvider {
    static var previews: some View {
        EventsListView()
    }
}
