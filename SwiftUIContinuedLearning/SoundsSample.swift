//
//  SoundsSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 19.03.2025.
//

import SwiftUI
import AVKit

class SoundManager {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case tomodell
        case carti
    }
    
    func playSound(sound: SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

struct SoundsSample: View {
    
    var body: some View {
        VStack(spacing: 40) {
            Button("play sound 1") {
                SoundManager.instance.playSound(sound: .tomodell)
            }
            .tint(.pink)
            .buttonStyle(.borderedProminent)
            Button("play sound 2") {
                SoundManager.instance.playSound(sound: .carti)
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
        }
    }
}

#Preview {
    SoundsSample()
}
