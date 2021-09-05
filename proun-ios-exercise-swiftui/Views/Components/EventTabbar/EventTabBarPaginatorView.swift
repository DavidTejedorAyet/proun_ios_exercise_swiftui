//
//  TabBar.swift
//  Chanel (iOS)
//
//  Created by Balaji on 04/02/21.
//

import SwiftUI

struct EventTabBarPaginatorView: View {
    
    @Binding var offset: CGFloat
    @State var width : CGFloat = 0
    @Binding var selectedTab: Int
    var tabs: [String]
    var body: some View {
        
        GeometryReader{proxy -> AnyView in
            
            // Equal Width...
            let equalWidth = proxy.frame(in: .global).width / CGFloat(tabs.count)
            
            DispatchQueue.main.async {
                self.width = equalWidth
            }
            
            return AnyView(
            
                ZStack(alignment: .bottomLeading, content: {
                    
                    Rectangle()
                        .fill(Color("SelectedTabColor"))
                        .frame(width: equalWidth - 15, height: 4)
                        .offset(x: getOffset())
                    
                    HStack(spacing: 0){
                        
                        ForEach(tabs.indices,id: \.self){index in
                            
                            Text(tabs[index])
                                .font(Font.custom("TradeGothicLTStd-BdCn20", size: 25))
                                .foregroundColor(Color(selectedTab == index ? "Text" : "TextVeryLight"))
                                .textCase(.uppercase)
                                .frame(width: equalWidth, height: 55)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.2)){
                                        offset = UIScreen.main.bounds.width * CGFloat(index)
                                    }
                                    selectedTab = index

                                }
                        }
                        
                        
                    }
                    
                })
                .frame(maxWidth: .infinity,maxHeight: 40, alignment: .center)
            )
        }
        .padding()
        .frame(height: 60)
    }
    
    func getOffset() -> CGFloat {
        let progress = offset / UIScreen.main.bounds.width
        return progress * width
    }
    
}

struct ScrollableTabBarPaginatorView_Previews: PreviewProvider {
    static var previews: some View {
        EventTabbarView()
    }
}
