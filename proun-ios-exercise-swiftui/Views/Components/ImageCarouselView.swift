//
//  ImageCarouselView.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 3/9/21.
//

import SwiftUI
import Combine

struct ImageCarouselView: View {
    
    var images: [MediaModel]
    var body: some View {
        GeometryReader { geometry in
            TabView {
                ForEach(images, id: \.self.id) { image in
                    AsyncImage(
                        url: URL(string: image.url ?? "")!,
                        placeholder: { Text("Cargando ...") },
                        image: { Image(uiImage: $0).resizable() }
                    )
                        .scaledToFill()
                        .tag(image.id)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(width: geometry.size.width)
        }
        
    }
}


struct ImageCarouserView_Previews: PreviewProvider  {
    static var previews: some View {
        ImageCarouselView(images: [])
    }
}
