//
//  ScrollableTabbarView.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 4/9/21.
//

import SwiftUI

struct EventTabbarView: View {
    
    @State var offset: CGFloat = 0
    @State var selectedTab = 0
    var tabs = ["Eventos","Actualidad"]

    var body: some View {
        
        VStack (){
            EventTabBarPaginatorView(offset: $offset, selectedTab: $selectedTab, tabs: tabs)
            
                            
            switch selectedTab {
            case 0:
                EventsListView()
            default:
                Text("En construccion")
                    .frame(height: 300)

            }
            
            Spacer()
        }
        
    }
}

struct ScrollableTabbarView_Previews: PreviewProvider {
    static var previews: some View {
        EventTabbarView()
    }
}
