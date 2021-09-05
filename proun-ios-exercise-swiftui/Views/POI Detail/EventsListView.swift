//
//  EventsListView.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 4/9/21.
//

import SwiftUI

struct EventsListView: View {
    
//    var viewModel: POIViewModel No necesario con los datos hardcodeados
    
    var mockEvents: [EventModel] = [ EventModel(title: "Metronomy en concierto", date: "2021-09-10T20:00:00+00:00"),
                                     EventModel(title: "Mago de Oz en concierto", date: "2021-09-23T20:00:00+00:00"),
                                     EventModel(title: "Mission of Burma en concierto", date: "2020-05-23T20:00:00+00:00")
    ]
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 18) {
            ForEach(mockEvents, id: \.self.title) { event in
                EventCell(event: event)
            }
        }
        .padding(15)
        .listStyle(PlainListStyle())
        
    }
}

struct EventsListView_Previews: PreviewProvider {
    static var previews: some View {
        EventsListView()
    }
}
