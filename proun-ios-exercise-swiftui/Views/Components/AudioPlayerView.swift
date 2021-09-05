//
//  AudioPlayerView.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 4/9/21.
//

import SwiftUI
import AVKit

struct AudioPlayerView : View {

    @StateObject var viewModel: AudioPlayerViewModel
    @Binding var playing: Bool {
        didSet {
            viewModel.isPlaying = playing
        }
    }
    
    var body : some View{
        
        HStack(spacing: 20){
            
            Image(systemName: viewModel.isPlaying && !viewModel.isFinished ? "pause.fill" : "play.fill")
                .resizable()
                .padding(viewModel.isPlaying && !viewModel.isFinished ? EdgeInsets(top: 14,leading: 14,bottom: 14,trailing: 14): EdgeInsets(top: 15,leading: 17,bottom: 14,trailing: 12))
                .frame(width: 48, height: 48, alignment: .center)
                .background(Color("PlayerButtonBackground"))
                .foregroundColor(Color("PlayerButtonIcon"))
                .clipShape(Circle())
                .onTapGesture {
                    viewModel.onTapPlayButton()
                }
            
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        
                        Rectangle().fill(Color("PlayerPlayableLine"))
                            .frame(height: 8)
                        
                        HStack(spacing: 0) {
                            Rectangle().fill(Color("PlayerPlayedLine"))
                                .frame(maxWidth: geometry.size.width)
                                .frame(width: viewModel.progressBarWidth, height: 8)
                                .gesture(DragGesture()
                                            .onChanged({ (value) in
                                                viewModel.changeProgressBarValue(value: value.location.x)
                                                
                                            }).onEnded({ (value) in
                                                viewModel.onEndProgressBarChange(value: value.location.x, progressBarWidth: geometry.size.width)
                                        }))
                            
                            Circle()
                                .fill(Color("PlayerProgressIcon"))
                                .frame(width: 18, height: 18)
                                
                        }
                    }
                    .onAppear(){
                        viewModel.prepareAudio(barWidth: geometry.size.width)
                    }
                    .onDisappear() {
                        viewModel.player?.pause()
                    }
                }
                .frame(height: 18)
                
                HStack{
                    Text(viewModel.currentTime)
                        .foregroundColor(Color("TextLight"))
                        .font(.custom("Roboto-Medium", size: 16))

                    Spacer()

                    Text(viewModel.totalDuration)
                        .foregroundColor(Color("Text"))
                        .font(.custom("Roboto-Medium", size: 16))
                }
            }
        }
        .padding(15)
        .background(Color("PlayerBackground"))
    }
    
    
}



struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerView(viewModel: AudioPlayerViewModel(audio: MediaModel()), playing: .constant(false))
    }
}
