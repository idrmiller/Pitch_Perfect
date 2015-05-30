//
//  PlaySoundsViewController.swift
//  Pitch Perfect2
//
//  Created by David Miller on 5/23/15.
//  Copyright (c) 2015 David Miller. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow(sender: UIButton) {
        
       
        //get path of file on local drive
        let path = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!)
        println("audio file path: \(path)")
        
        //setup audio player
        var audio = AVAudioPlayer()
        
        //Initialize auido player
        audio = AVAudioPlayer(contentsOfURL: path!, error:nil)
        
        //Play audio file
        audio.prepareToPlay()
        println("\(audio.prepareToPlay())")
        
        audio.play()
        println("playing slow audio")
        
        println("Audio is playing: \(audio.playing)")
        
        
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
