//
//  LoaderView.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 5/9/21.
//

import SwiftUI

struct LoaderView<Content>: View where Content: View {

    var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    Text("Cargando...")
                        .font(.custom("Roboto-Medium", size: 26))

                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color("PrimaryColor")))
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }

}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView(isShowing: true) {
            Text("")
        }
    }
}
