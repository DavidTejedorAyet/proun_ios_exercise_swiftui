//
//  MusicPlayerView.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 4/9/21.
//

import SwiftUI
import AVKit

struct AudioPlayerView : View {
    
    @State var data : Data = .init(count: 0)
    @State var player : AVAudioPlayer!
    @State var isPlaying = false
    @State var songs = ["audio"]
    @State var isFinished = false
    @State var delegate = AVdelegate()
    @State var progressBarWidth: CGFloat = 0.0
    
    var body : some View{
        
        HStack(spacing: 20){
            
            Image(systemName: isPlaying && !isFinished ? "pause.fill" : "play.fill")
                .resizable()
                .padding(isPlaying && !isFinished ? EdgeInsets(top: 14,leading: 14,bottom: 14,trailing: 14): EdgeInsets(top: 15,leading: 17,bottom: 14,trailing: 12))
                .frame(width: 48, height: 48, alignment: .center)
                .background(Color("PlayerButtonBackground"))
                .foregroundColor(Color("PlayerButtonIcon"))
                .clipShape(Circle())
                .onTapGesture {
                    if self.player.isPlaying {
                        self.player.pause()
                        self.isPlaying = false
                    } else{
                        if self.isFinished {
                            self.player.currentTime = 0
                            self.progressBarWidth = 0
                            self.isFinished = false
                        }
                        self.player.play()
                        self.isPlaying = true
                    }
                }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    
                    Rectangle().fill(Color("PlayerPlayableLine"))
                        .frame(height: 8)
                    
                    HStack(spacing: 0) {
                        Rectangle().fill(Color("PlayerPlayedLine"))
                            .frame(width: self.progressBarWidth, height: 8)
                            .gesture(DragGesture()
                                        .onChanged({ (value) in
                                            let x = value.location.x
                                            self.progressBarWidth = x
                                            self.player.pause()
                                            
                                        }).onEnded({ (value) in
                                            let x = value.location.x
                                            let percent = x / geometry.size.width
                                            self.player.currentTime = Double(percent) * self.player.duration
                                            self.player.play()
                                    }))
                        
                        Circle()
                            .fill(Color("PlayerProgressIcon"))
                            .frame(width: 18, height: 18)
                            
                    }
                }
                .onAppear(){
                    prepareAudio(barWidth: geometry.size.width)
                }
            }
            .frame(height: 18)
        }
        .padding(15)
        .background(Color("PlayerBackground"))
        
    }
    
    func prepareAudio(barWidth: CGFloat) {
        let url = Bundle.main.path(forResource: "audio", ofType: "aac")
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
        self.player.delegate = self.delegate
        self.player.prepareToPlay()
        
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (_) in
            if self.player.isPlaying{
                let value = self.player.currentTime / self.player.duration
                self.progressBarWidth = barWidth * CGFloat(value)
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("FinishedAudio"), object: nil, queue: .main) { (_) in
            self.isFinished = true
        }
    }
}

class AVdelegate : NSObject,AVAudioPlayerDelegate{
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name("FinishedAudio"), object: nil)
    }
}


struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerView()
    }
}
