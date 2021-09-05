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
    
    @StateObject var viewModel: POIViewModel
    @State var stopPlayingAudio: Bool = false
    
    var body: some View {
        let selectedPOI = viewModel.selectedPOI
        let images: [MediaModel] = selectedPOI?.galleryImages ?? []
        
        ZStack {
            Color.black.opacity(0.5)
            VStack(spacing: 0) {
                HStack {
                    
                    AsyncImage(
                        url: URL(string: viewModel.selectedPOI?.category?.icon?.url ?? "")!,
                        placeholder: { Text("Cargando ...") },
                        image: { Image(uiImage: $0).resizable() }
                    )
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
                            stopPlayingAudio = false
                            viewModel.showPopUp.toggle()
                        }
                }
                .frame(height: 48)
                .padding(18)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        ImageCarouselView(images: images)
                            .frame(height: 240)
                        
                        AudioPlayerView(viewModel: AudioPlayerViewModel(audio: viewModel.selectedPOI?.audio ?? MediaModel()), playing: $stopPlayingAudio)
                            .padding(18)
                            .frame(height: 118)
                            .background(Color.white)
                        
                        Color("Separator")
                            .frame(height:1)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 4) {
                                Text("Acerca de este local:")
                                    .foregroundColor(Color("Text"))
                                    .font(.custom("Roboto-Medium", size: 16))
                                
                                Spacer()
                                
                                Text(String(viewModel.selectedPOI?.likesCount ?? 0))
                                    .foregroundColor(Color("TextVeryLight"))
                                    .font(.custom("Roboto-Medium", size: 16))
                                
                                Image("like")
                                    .resizable()
                                    .frame(width: 19, height: 16)
                                    .foregroundColor(Color("TextVeryLight"))
                                
                            }
                            
                            Text(viewModel.selectedPOI?.description ?? "Descripción")
                                .foregroundColor(Color("TextVeryLight"))
                                .font(.custom("Roboto-Medium", size: 16))
                        }
                        .padding(18)
                        
                        MapView(viewModel: MapViewModel(selectedPOI: viewModel.selectedPOI ?? POIModel()))
                            .frame(height: 190)
                            .padding(18)
                        
                        EventTabbarView()
                            .frame(minHeight: 300, maxHeight: .infinity)
                    }
                }
                
                Spacer()
            }
            .background(Color.white)
            .padding(.horizontal, 20)
            .padding(.top, 80 + (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
            .padding(.bottom, 35 + (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0))
        }
        .ignoresSafeArea()
    }
}

struct POIDetailPopUp_Previews: PreviewProvider {
    static var previews: some View {
        POIDetailPopUp(viewModel: POIViewModel())
    }
}

