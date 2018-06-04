import UIKit
import AVFoundation
class VoiceViewController: UIViewController {
    let synthesizer : AVSpeechSynthesizer = AVSpeechSynthesizer()
    var utterance : AVSpeechUtterance = AVSpeechUtterance(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
        // Setting defaults speaking
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: .interruptSpokenAudioAndMixWithOthers)
        utterance.voice = AVSpeechSynthesisVoice(identifier: "en-UK")
        synthesizer.pauseSpeaking(at: .word)
        testSpeech()
    }
    // Setting the language
    
    private func testSpeech() {
        utterance = AVSpeechUtterance(string: "Hi, where you are? I miss you so much. may i pick you now? Hi, where you are? I miss you so much. may i pick you now? Hi, where you are? I miss you so much. may i pick you now? ")
        utterance.rate = 0.5
        speak()
    }
    // Content of calling and speed
    
    private func speak() {
        if synthesizer.isSpeaking {
            synthesizer.pauseSpeaking(at: .immediate)
            return
        }
        synthesizer.speak(utterance)
    }
}
   // Speak over
