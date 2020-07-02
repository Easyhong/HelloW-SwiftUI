//
//  RootView.swift
//  HelloW-SwiftUI
//
//  Created by ronzhang on 2020/6/29.
//  Copyright © 2020 ronzhang. All rights reserved.
//

import SwiftUI
import AVFoundation

//struct RootView: View {
//    var body: some View {
//
//        NavigationView {
//            List { Text("Hello World")} .navigationBarItems(trailing:
//            Button("Click me") { //
//
//
//            }) .navigationBarTitle(Text("Settings"))
//        }
//    }
//
//    //        Image("tower")
//    //                    .scaleEffect(half ? 0.5 : 1.0)
//    //                    .opacity(dim ? 0.2 : 1.0)
//    //                    .animation(.easeInOut(duration: 1.0))
//    //
//    //                    .onTapGesture {
//    //                        self.dim.toggle()
//    //                        self.half.toggle()
//    //                    }
//}
//
//struct RootView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView()
//    }
//}

private let demoURL = URL(string: "https://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4")!

// private let demoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!

struct RootView : View {
    
    @State private var isPlay: Bool = true
    @State private var time: CMTime = .zero
    @State private var autoReplay: Bool = true
    @State private var mute: Bool = false
    @State private var stateText: String = ""
    @State private var totalDuration: Double = 0
    @State private var playProgressWidth: CGFloat = 0
    
    var body: some View {
        
        VStack {
            ZStack {
                       VideoPlayer(url: demoURL,
                                   play: $isPlay,
                                   time: $time)
                           
                           .autoReplay(autoReplay)
                           .mute(mute)
                           .onBufferChanged { progress in print("onBufferChanged \(progress)") }
                           .onPlayToEndTime { print("onPlayToEndTime") }
                           .onReplay { print("onReplay") }
                           .onStateChanged { state in
                               switch state {
                               case .loading:
                                   self.stateText = "loading..."
                               case .playing(let totalDuration):
                                   self.stateText = "player"
                                   
                                   self.totalDuration = totalDuration
                                
                                DispatchQueue.global(qos: .background).async {
                                 while true {
                                    let screenWidth = UIScreen.main.bounds.width - 20
                                    let curreenProgress = self.time.seconds / self.totalDuration
                                    let playProgressWidth = CGFloat(curreenProgress)  * screenWidth
                                    self.playProgressWidth = playProgressWidth
                                    }
                                }
                               case .paused(let playProgress, let bufferProgress):
                                   
                                   self.stateText = "Paused: Play \(Int(playProgress * 100))% buffer \(Int(bufferProgress * 100))%"
                               case .error(let error):
                                   self.stateText = "\(error)"
                               }
                           }
                       //.aspectRatio(1.0, contentMode: .fit)
                         //  .cornerRadius(16)
                         //  .shadow(color: Color.black.opacity(0.7), radius: 6, x: 0, y: 2)
                        //  .padding()
                       .frame(width: UIScreen.main.bounds.width,
                              height: UIScreen.main.bounds.width * 9 / 16, alignment: .bottom)
                       
                       // 加载状态
                Text(stateText).foregroundColor(.white).font(.none)
                       .padding()
                }
                   .onDisappear { self.isPlay = false }
           
            
            ZStack(alignment: .leading, content: {
                Capsule().fill(Color.black).frame(height: 4).padding(10)
                Capsule().fill(Color.white).frame(width: self.playProgressWidth, height: 4).padding(10)

            })
            
            
            HStack {
                Button(self.isPlay ? "暂停" : "播放") {
                    self.isPlay.toggle()
                }

                Divider().frame(height: 30)

                Button(self.mute ? "声音关" : "声音开") {
                    self.mute.toggle()
                }

                Divider().frame(height: 20)

                Button(self.autoReplay ? "自动播放开" : "自动播放关") {
                    self.autoReplay.toggle()
                }
                Divider().frame(height: 20)
                Text("\(getTimeString()) / \(getTotalDurationString())")
            }

            HStack {
                Button("快退5s") {
                    self.time = CMTimeMakeWithSeconds(max(0, self.time.seconds - 5), preferredTimescale: self.time.timescale)
                }

                Divider().frame(height: 20)

                

                Divider().frame(height: 20)

                Button("快进5s") {
                    self.time = CMTimeMakeWithSeconds(min(self.totalDuration, self.time.seconds + 5), preferredTimescale: self.time.timescale)
                }
            }
            
        }
       
    }
    
    // 进度时间
    func getTimeString() -> String {
        let m = Int(time.seconds / 60)
        let s = Int(time.seconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%d:%02d", arguments: [m, s])
    }
    
    // 总时间
    func getTotalDurationString() -> String {
        let m = Int(totalDuration / 60)
        let s = Int(totalDuration.truncatingRemainder(dividingBy: 60))
        return String(format: "%d:%02d", arguments: [m, s])
    }
}

#if DEBUG
struct RootView_Previews : PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
#endif



