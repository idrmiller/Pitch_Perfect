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
    
    func audioSettings(currentTime: Double, rate: Float) {
        audioPlayer.stop()
        audioPlayer.currentTime = currentTime
        audioPlayer.rate = rate
        audioPlayer.play()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = try! AVAudioPlayer(contentsOfURL: receievedAudio.filePathUrl, fileTypeHint:nil)
        audioPlayer.enableRate = true
        
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
        audioSettings(0, rate: 0.5)
        print("playing slow audio")
        print("Audio slow is playing: \(audioPlayer.playing)")
        
    }
    
    @IBAction func playFastButton(sender: UIButton) {
        
        //Play audio file fast
        audioSettings(0, rate: 1.5)
        print("playing fast audio")
        print("Audio fast is playing: \(audioPlayer.playing)")
        
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
