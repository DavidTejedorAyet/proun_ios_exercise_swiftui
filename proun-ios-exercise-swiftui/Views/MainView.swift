//
//  MainView.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 1/9/21.
//

import SwiftUI

struct MainView: View {
    
    var viewModel = POIViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
