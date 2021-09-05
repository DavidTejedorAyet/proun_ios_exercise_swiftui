//
//  POICell.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 5/9/21.
//

import SwiftUI

struct POICell: View {
    var poi: POIModel
    
    var body: some View {
        
        ZStack {
            
            Color.white
            
            HStack {
                AsyncImage(
                    url: URL(string: poi.image?.url ?? "")!,
                                placeholder: { Text("Cargando ...") },
                                image: { Image(uiImage: $0).resizable() }
                             )
                .frame(width:70, height: 70)

                
                Text(poi.name ?? "name")
                    .foregroundColor(Color("Text"))
                    .font(.custom("Roboto-Medium", size: 16))
                    .padding(.leading, 15)
                Spacer()
                
                Text(String(poi.likesCount ?? 0))
                    .foregroundColor(Color("TextVeryLight"))
                    .font(.custom("Roboto-Medium", size: 16))
                
                Image("like")
                    .resizable()
                    .frame(width: 19, height: 16)
                    .foregroundColor(Color("TextVeryLight"))

            }
            .padding(.trailing, 14)
        }
    }
}

struct POICell_Previews: PreviewProvider {
    static var previews: some View {
        POICell(poi: POIModel())
    }
}
