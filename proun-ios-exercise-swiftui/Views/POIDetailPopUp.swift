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
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(Color("TextLight"))

                    
                    Text(viewModel.selectedPOI?.name ?? "NOMBRE")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.custom("TradeGothicLTStd-BdCn20", size: 25))
                        .foregroundColor(Color("TextLight"))
                        .textCase(.uppercase)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 8)

                    
                    Image("cross")
                        .resizable()
                        .foregroundColor(Color("VeryLightButtonColor"))
                        .frame(width: 22, height: 22)
                        .onTapGesture {
                            viewModel.showPopUp.toggle()
                        }
                }
                .frame(height: 48)
                .padding(15)
                
                ScrollView() {
                    VStack(spacing: 0) {
                        
                        ImageCarouselView(images: images)
                            .frame(height: 220)
                        
                        AudioPlayerView(viewModel: AudioPlayerViewModel(audio: viewModel.selectedPOI?.audio ?? MediaModel()))
                            .padding(15)
                            .frame(height: 102)
                            .background(Color.white)
//                        Color.gray
//                            .frame(height:102)
                        
                        Color("Separator")
                            .frame(height:1)
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

