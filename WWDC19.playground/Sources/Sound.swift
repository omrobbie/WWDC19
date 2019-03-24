import AVFoundation

var player: AVAudioPlayer?

public func playSound(soundName: String, ext: String) {
    guard let url = Bundle.main.url(forResource: soundName, withExtension: ext) else {return}
    
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
        guard let player = player else {return}
        player.play()
        
    } catch let error {
        print(error.localizedDescription)
    }
}

public func playSoundClick() {
    playSound(soundName: "click", ext: "m4a")
}

public func playSoundMatch() {
    playSound(soundName: "coin", ext: "wav")
}
