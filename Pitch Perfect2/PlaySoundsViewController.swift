//
//  PlaySoundsViewController.swift
//  Pitch Perfect2
//
//  Created by David Miller on 5/23/15.
//  Copyright (c) 2015 David Miller. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController{


    var audioPlayer:AVAudioPlayer!
    var receievedAudio:RecordedAudio!
    var engine:AVAudioEngine!
    var audioFile:AVAudioFile! //Need to convert NSURL to AudioFIle in order to play the pitch changes.
    
    
    func audioSettings(currentTime: Double, rate: Float, timeAffectsActive: Bool, pitch: Float, audioRate: Float) {
        
        audioPlayer.stop()
        audioPlayer.currentTime = currentTime
        audioPlayer.rate = rate
        engine.stop()
        engine.reset()
        
        //Setting pitch controll
        if (timeAffectsActive == true) {
            
            print("Engine started")
            let playerNode = AVAudioPlayerNode()
            engine.attachNode(playerNode)
            
            
            let audioPitch = AVAudioUnitTimePitch()
            audioPitch.pitch = pitch        //In cents. The default value is 1.0. The range of values is -2400 to 2400
            engine.attachNode(audioPitch)
            
            
            engine.connect(playerNode, to: audioPitch, format: nil)
            engine.connect(audioPitch, to: engine.outputNode, format: nil)
            
            playerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
            
            try! engine.start()
            playerNode.play()
            
            print("Engine Playing")
            
        } else {
            //Play audio with new settings
            audioPlayer.play()
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = try! AVAudioPlayer(contentsOfURL: receievedAudio.filePathUrl, fileTypeHint:nil)
        audioPlayer.enableRate = true
        engine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receievedAudio.filePathUrl)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func playSlow(sender: UIButton) {
        
        //Play audio file slow
        audioSettings(0, rate: 0.5, timeAffectsActive: false, pitch: 1, audioRate: 1)
        print("playing slow audio")
        print("Audio slow is playing: \(audioPlayer.playing)")
        
    }
    
    @IBAction func playFastButton(sender: UIButton) {
        
        //Play audio file fast
        audioSettings(0, rate: 1.5, timeAffectsActive: false, pitch: 1, audioRate: 1)
        print("playing fast audio")
        print("Audio fast is playing: \(audioPlayer.playing)")
        
    }
    
    
    
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        
        //Play audio file at higher pitch
        audioSettings(0, rate: 1, timeAffectsActive: true, pitch: 1000, audioRate: 1)
        print("Playing Chipmunk audio")
        
    }
    
    @IBAction func playDarthvaderAudio(sender: AnyObject) {
        
        //Play audio file at lower pitch
        audioSettings(0, rate: 1, timeAffectsActive: true, pitch: -1000, audioRate: 1)
        print("Playing Darth Vadar audio")
        
    }
    
    @IBAction func stopPlayBack(sender: UIButton) {
        
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        print("Audio Stopped")
        
    }
    

}
