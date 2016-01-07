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
    
    
    
    func audioSettings(currentTime: Double, rate: Float, timeAffectsActive: Bool, pitch: Float, audioRate: Float) {
        
        audioPlayer.stop()
        audioPlayer.currentTime = currentTime
        audioPlayer.rate = rate
        
        //Setting pitch controll
        if (timeAffectsActive == true) {
            
            let playerNode = AVAudioPlayerNode()
            engine.attachNode(playerNode)
            
            
            let audioPitch = AVAudioUnitTimePitch()
            engine.attachNode(audioPitch)
            audioPitch.pitch = pitch        //In cents. The default value is 1.0. The range of values is -2400 to 2400
            
            engine.connect(playerNode, to: audioPitch, format: nil)
            engine.connect(audioPitch, to: engine.outputNode, format: nil)
            
            playerNode.play()
            
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
        
        /**
        // Do any additional setup after loading the view.
        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
            //Convert string to NSURL
            let filePathURL = NSURL.fileURLWithPath(filePath)
            
            //Initialize auido player
            //Using the try! call gives us teh ability to test for errors. By adding the exclamation mark we tell the error capture that we know for sure that there is no error. 
            
            audioPlayer = try! AVAudioPlayer(contentsOfURL: filePathURL, fileTypeHint:nil)
            audioPlayer.enableRate = true
            
            
        } else {
            print("This file is empty")
        }
        **/
        
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
    
    
    //TODO: Add Chipmunk to storyboard
    //TODO: Add constraints to make it appear in the correct spot on the phone
    //TODO: Add an action for this button called playChipmunkAudio (this action can be empty for now)
    
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        
        //Play audio file at higher pitch
        audioSettings(0, rate: 1, timeAffectsActive: true, pitch: 2, audioRate: 1)
        print("Playing pitch audio")
        print("Audio pitch chnage is playing: \(audioPlayer.playing)")
        
    }
    
    
    @IBAction func stopPlayBack(sender: UIButton) {
        
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
