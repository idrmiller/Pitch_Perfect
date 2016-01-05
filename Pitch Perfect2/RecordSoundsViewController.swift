//
//  RecordSoundsViewController.swift
//  Pitch Perfect2
//
//  Created by David Miller on 5/20/15.
//  Copyright (c) 2015 David Miller. All rights reserved.
//

import UIKit
import AVFoundation

//Made audioRecorder a global variable to be accessed by other viewControllers
var audioRecorder:AVAudioRecorder!
var filePath:NSURL!

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var recordedAudio:RecordedAudio!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        // hide the stop button
        stopButton.hidden = true
        
    }

    @IBAction func recordAudio(sender: UIButton) {
        //TODO: Show text "recording in progress"
        recordingInProgress.hidden = false
        
        //TODO: Record's the user's voice
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        
        /**
        We need to remove this section of code, since the storage is inefficient. Changed the code to use one file name.
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        **/
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
        
        //TODO: Show stop button
        stopButton.hidden = false
        recordButton.enabled = false
        
        
        
        func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool){
            
            if (flag) {
                //TODO: - Save recorded audio
                recordedAudio = RecordedAudio()
                recordedAudio.filePathUrl = recorder.url
                recordedAudio.title = recorder.url.lastPathComponent
                
                //TODO: - Move to second scene of the app (perform) segue
                self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            } else {
                print("Recording was not succesful")
                recordButton.enabled = true
                stopButton.hidden = true
            }
            
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        //TODO: Hide text "recording in progress"
        recordingInProgress.hidden = true
        
        //TODO: Recording is stopped
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        print("Recording has stopped")
        
        //TODO: hide stop button
        stopButton.hidden = true
        recordButton.enabled = true
        
    }
    

}

