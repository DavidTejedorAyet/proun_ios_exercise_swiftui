//
//  MapMarkerView.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 3/9/21.
//

import SwiftUI

struct MapMarkerView: View {
    
    @State var name: String
    @State var time: String
    @State var location: String
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack (spacing: 0) {
                VStack {
                    Text(name)
                        .font(Font.custom("TradeGothicLTStd-BdCn20", size: 18))
                        .foregroundColor(Color("MapMarkerText"))
                        .textCase(.uppercase)
                        .padding(.top, 8)
                        .multilineTextAlignment(.center)
                    HStack {
                        Text("\(time) -")
                            .font(Font.custom("TradeGothicLTStd-BdCn20", size: 14))
                            .foregroundColor(Color("MapMarkerTime"))
                            .textCase(.uppercase)
                            .padding(.top, 8)
                        
                        
                        Spacer()
                            .frame(width: 4)
                        HStack (spacing: -2){
                            Image("poi")
                                .resizable()
                                .frame(width:12, height: 14)
                                .foregroundColor(Color("MapMarkerLocation"))
                                .padding(.top, 6)
                            
                            Text(location)
                                .font(Font.custom("TradeGothicLTStd-BdCn20", size: 14))
                                .foregroundColor(Color("MapMarkerLocation"))
                                .padding(.top, 8)
                        }
                    }
                    
                    
                }
                .padding(12)
                .background(Color("MapMarkerBackground"))
                
                Triangle()
                    .fill(Color("MapMarkerBackground"))
                    .frame(width: 24, height: 16, alignment: .center)
                   
            }

        }
        .frame(width: 340, height: 140)
        .onTapGesture {
            print("*** ON TAP")
        }
    }
}

struct MapMarkerView_Previews: PreviewProvider {
    static var previews: some View {
        MapMarkerView(name: "Palacio de Linares (casa de America", time: "22:30", location: "Calle con nombre muy muy largo, 23")
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))

        return path
    }
}

