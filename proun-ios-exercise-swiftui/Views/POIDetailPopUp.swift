//
//  POIDetailPopUp.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 3/9/21.
//

import SwiftUI
protocol POIDetailPopUpDelegate {
    func showDetailPopUp(with poi: POIModel)
}

struct POIDetailPopUp: View {
    
    @ObservedObject var viewModel: POIViewModel
    @State var isPlayingAudio: Bool = false
    
    var body: some View {
        let selectedPOI = viewModel.selectedPOI
        let images: [MediaModel] = selectedPOI?.galleryImages ?? []
        
        ZStack {
            Color.black.opacity(0.5)
            VStack(spacing: 0) {
                HStack {
                    //                    Image(uiImage: UIImage(withContentsOfUrl: viewModel.selectedPOI?.category?.icon?.url ?? "") ?? UIImage())
                    Image("menu")
                    
                    Spacer()
                    
                    Text(viewModel.selectedPOI?.name ?? "")
                    
                    Spacer()
                    
                    Image("cross")
                        .resizable()
                        .foregroundColor(Color("VeryLightButtonColor"))
                        .frame(width: 22, height: 22)
                        .onTapGesture {
                            viewModel.showPopUp.toggle()
                        }
                }
                .frame(height: 48)
                .padding(12)
                
                ScrollView() {
                    VStack(spacing: 0) {
                        
                        ImageCarouselView(images: images)
                            .frame(height: 220)
                        
                        MusicPlayerView()
                        .padding(15)
                        
                        Color.green
                            .frame(height:300)
                    }
                }
                
                Spacer()
            }
            .background(Color.white)
            .padding(.horizontal, 20)
            .padding(.top,108 + (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
            .padding(.bottom, 40 + (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0))
        }
        .ignoresSafeArea()
    }
}

struct POIDetailPopUp_Previews: PreviewProvider {
    static var previews: some View {
        POIDetailPopUp(viewModel: POIViewModel())
    }
}

