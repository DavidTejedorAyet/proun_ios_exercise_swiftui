//
//  TabbarView.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 2/9/21.
//

import SwiftUI

struct TabbarView: View {
    
    @Binding var isShowingMap: Bool
    
    var body: some View {
        ZStack {
            Color("TabbarBackground")
            HStack {
                Text(isShowingMap ? "Mostrar listado" : "Mostrar mapa")
                    .font(Font.custom("TradeGothicLTStd-BdCn20", size: 25))
                    .foregroundColor(Color("TabbarText"))
                    .textCase(.uppercase)
                    .padding(.top, 8)
                
                Spacer()
                
                Image(isShowingMap ? "list" : "map")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(Color("TabbarText"))
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0)))

                
            }
            .padding(.horizontal, 20)
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
            
        }
        .onTapGesture {
            isShowingMap.toggle()
        }
        .ignoresSafeArea()
        .frame(height: 50)
        
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView(isShowingMap: .constant(false))
    }
}
