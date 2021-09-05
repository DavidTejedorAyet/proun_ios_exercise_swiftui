//
//  POIsListView.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 2/9/21.
//

import SwiftUI

struct POIsListView: View {
    var viewModel: POIViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Ordenar:")
                    .foregroundColor(Color("TextVeryLight"))
                    .font(.custom("Roboto-Light", size: 16))
                Text("Popularidad")
                    .foregroundColor(Color("TextVeryLight"))
                    .font(.custom("Roboto-Medium", size: 16))
                
                Spacer()
                
                Image("dots")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 15)
            .frame(height: 50)
            .background(Color("BackgroundListHeader"))
            
            List {
                ForEach(viewModel.pois, id: \.self.id) { poi in
                    POICell(poi: poi)
                        .listRowInsets(EdgeInsets())
                        .onTapGesture {
                            viewModel.showDetailPopUp(with: poi)
                        }
                }
            }
            .listStyle(PlainListStyle())

        }
        
    }
}

struct POIsListView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(isShowingMap: false, viewModel: POIViewModel())
    }
}
