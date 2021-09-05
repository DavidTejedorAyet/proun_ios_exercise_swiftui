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
        VStack {
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
            .frame(height: 50)
            .padding(.horizontal, 15)
            .background(Color("Text"))
            
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
        POIsListView(viewModel: POIViewModel())
    }
}
