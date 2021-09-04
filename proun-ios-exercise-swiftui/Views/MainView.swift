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
        ZStack {
            VStack(spacing: 0) {
                
                NavbarView()
                
                ZStack {
                    
                    Color("TitleBackground")
                    
                    HStack {
                        Text(viewModel.districtName)
                            .font(Font.custom("TradeGothicLTStd-BdCn20", size: 20))
                            .foregroundColor(Color("TitleText"))
                            .textCase(.uppercase)
                            .padding(.top, 8)
                            .padding(.leading, 15)
                        
                        Spacer()
                        
                        HStack(spacing: -2) {
                            Image("poi")
                                .resizable()
                                .frame(width:24, height: 28)
                                .foregroundColor(Color("TitleText"))
                            Text(viewModel.poisCount)
                                .font(Font.custom("TradeGothicLTStd-BdCn20", size: 20))
                                .foregroundColor(Color("TitleText"))
                                .textCase(.uppercase)
                                .padding(.top, 8)
                        }
                        
                        Spacer()
                            .frame(width: 18)
                        
                        ZStack {
                            Color("PrimaryColor")
                            Image("menu")
                                .foregroundColor(Color("TitleText"))
                        }
                        .frame(width: 50)
                    }
                    
                }
                .frame(height: 50)
                
                if isShowingMap {
                    MapView(pois: $viewModel.pois, districtCoordinates: $viewModel.districtCoordinates, detailPopUpDelegate: viewModel)
                } else {
                    POIsListView(detailPopUpDelegate: viewModel)
                }
                
                TabbarView(isShowingMap: $isShowingMap) 
            }
            .onAppear(){
                viewModel.downloadData()
            }
            
            if viewModel.showPopUp {
                withAnimation {
                    POIDetailPopUp(viewModel: viewModel)
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
