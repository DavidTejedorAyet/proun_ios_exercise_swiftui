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
                    
                    Image(uiImage: UIImage(withContentsOfUrl: viewModel.selectedPOI?.category?.icon?.url ?? "") ?? UIImage())
                        .resizable()
                        .frame(width: 34, height: 34)
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
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        ImageCarouselView(images: images)
                            .frame(height: 240)
                        
                        AudioPlayerView(viewModel: AudioPlayerViewModel(audio: viewModel.selectedPOI?.audio ?? MediaModel()))
                            .padding(16)
                            .frame(height: 102)
                            .background(Color.white)
                        
                        Color("Separator")
                            .frame(height:1)
                        
                        HStack(spacing: 4) {
                            Text("Acerca de este local:")
                                .foregroundColor(Color("Text"))
                                .font(.custom("Roboto-Medium", size: 18))

                            Spacer()
                            
                            Text(String(viewModel.selectedPOI?.likesCount ?? 0))
                                .foregroundColor(Color("TextVeryLight"))
                                .font(.custom("Roboto-Medium", size: 18))
                            
                            Image("like")
                                .resizable()
                                .frame(width: 19, height: 16)
                                .foregroundColor(Color("TextVeryLight"))
 
                        }
                        .padding(16)
                        
                        Text(viewModel.selectedPOI?.description ?? "Descripción")
                            .foregroundColor(Color("TextVeryLight"))
                            .font(.custom("Roboto-Medium", size: 18))
                            .padding(.horizontal,16)

                        MapView(viewModel: MapViewModel(selectedPOI: viewModel.selectedPOI ?? POIModel()))
                            .frame(height: 180)
                            .padding(16)

                        EventTabbarView()
                            .frame(height: 380)
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

