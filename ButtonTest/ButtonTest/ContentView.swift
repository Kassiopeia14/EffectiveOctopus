//
//  ContentView.swift
//  ButtonTest
//
//  Created by Anastasiia Kasian on 22/07/2023.
//

import SwiftUI
import AVKit

class SoundManager{
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String{
        case ship
        case tada
        case game
    }
    
    func playSound(sound: SoundOption){
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
    
}

struct ContentView: View {
    
    @State var repeats = 8;
    
    @State var runTimer = 60
    @State var walkTimer = 90
    
    @State var countDownTimer = 60
    
    @State var isRunning = false
    @State var isWalking = false
    
    @State var timerRunning = false
    
    @State var action = "run"
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack{
            Text("\(action), \(8 - repeats)/8")
        }
        .font(.system(size: 50))
        .padding()
        
        VStack {
            Text("\(countDownTimer)")
                .onReceive(timer){ _ in
                    if countDownTimer > 0 && repeats > 0 && timerRunning{
                        countDownTimer -= 1
                    }
                    if countDownTimer == 0 && repeats > 0 && isRunning && timerRunning{
                        isRunning = false
                        isWalking = true
                        
                        action = "walk"
                        repeats -= 1
                        
                        if repeats > 0 {
                            countDownTimer = walkTimer
                        }
                        
                        SoundManager.instance.playSound(sound: .tada)
                    }
                    if countDownTimer == 0 && repeats > 0 && isWalking && timerRunning{
                        isRunning = true
                        isWalking = false
                        
                        action = "run"
                        countDownTimer = runTimer
                        
                        SoundManager.instance.playSound(sound: .game)
                    }
                    if countDownTimer == 0 && repeats == 0 && timerRunning{
                        timerRunning = false
                        isRunning = false
                        isWalking = false
                        
                        countDownTimer = 0
                        action = "rest"
                        
                        SoundManager.instance.playSound(sound: .ship)
                    }
                    
                }
        }
        .font(.system(size: 150))
        .padding()
        
        HStack(spacing: 30){
            Button("Start"){
                timerRunning = true
                if !isRunning && !isWalking {
                    isRunning = true
                }
            }.foregroundColor(.green)
            Button("Stop"){
                timerRunning = false
            }
            Button("Reset"){
                repeats = 8
                countDownTimer = runTimer
                action = "run"
                timerRunning = false
                isRunning = false
                isWalking = false
            }.foregroundColor(.red)
        }
        .font(.system(size: 25))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
