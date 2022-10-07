//
//  MusicManager.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 02.10.2022.
//

import AVFoundation

var player: AVAudioPlayer?

func playBackgroundMusic() {
    if !UserDefaultsValues.musicOff {
    guard let url = Bundle.main.url(forResource: "background",
                                    withExtension: "mp3") else { return }
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
        guard let player = player else { return }
        player.volume = 0.5
        player.numberOfLoops = -1
        player.play()
    } catch let error {
        print(error.localizedDescription)
    }
    }
}

func stopPlaying() {
    player?.stop()
}
