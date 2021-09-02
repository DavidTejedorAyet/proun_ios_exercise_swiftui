//
//  MainView.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 1/9/21.
//

import SwiftUI

struct MainView: View {
    @State private var isShowingMap = true
    
    @ObservedObject var viewModel = POIViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            
            NavbarView()
            
            if isShowingMap {
                MapView(pois: $viewModel.pois, districtCoordinates: $viewModel.districtCoordinates)
            } else {
                POIsListView()
            }
            
            TabbarView(isShowingMap: $isShowingMap)
            
        }
        
            .onAppear(){
                viewModel.downloadData()
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
