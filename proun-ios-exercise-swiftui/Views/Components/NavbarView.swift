//
//  NavbarView.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 2/9/21.
//

import SwiftUI

struct NavbarView: View {
    
    @State var city: String = "Madrid"
    var body: some View {
        ZStack {
            Color("NavbarBackground")
            HStack {
                Image("back")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        print("Do back action")
                    }
                
                Spacer()
                    .frame(width: 25)
                
                Text(city)
                    .font(Font.custom("TradeGothicLTStd-BdCn20", size: 25))
                    .foregroundColor(Color("NavbarText"))
                    .padding(.top, 8) //Compensa un pequeño desajuste en la tipografía
                
                Spacer()
                
                Image("calendar")
                    .resizable()
                    .frame(width: 32, height: 32)
                
                Image("navigation")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
            .padding(.horizontal, 20)
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)

        }
        .ignoresSafeArea()
        .frame(height: 88)
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarView()
    }
}
