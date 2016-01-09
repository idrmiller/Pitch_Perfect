//
//  RecordSoundsViewController.swift
//  Pitch Perfect2
//
//  Created by David Miller on 5/20/15.
//  Copyright (c) 2015 David Miller. All rights reserved.
//

import UIKit
import AVFoundation




class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var pressRecord: UILabel!
    
    
    var audioRecorder:AVAudioRecorder!
    var filePath:NSURL!
    
   
    
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
        pressRecord.hidden = false
        
    }

    @IBAction func recordAudio(sender: UIButton) {
        //TODO: Show text "recording in progress"
        pressRecord.hidden = true
        recordingInProgress.hidden = false
        
        
        //TODO: Record's the user's voice
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        filePath = NSURL.fileURLWithPathComponents(pathArray)
        print("This is the location of the file --------------- \(filePath)")
        
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        print("Recording started")
        
        
        //TODO: Show stop button
        stopButton.hidden = false
        recordButton.enabled = false
        
        
    }
    
    //Purpose: This function is check to ensure that teh recording completed successfully, if true it will then change to the playsoundsview controller
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool){
        if (flag == true) {
            //TODO: Save recorded audio
            let recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            print("This is the 2nd location of the file --------------- \(recordedAudio.filePathUrl)")
            
            //TODO: Move to second scene of the app (perform) segue
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            print("Recording was not succesful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
        
    }
    
    //Purpose: this function lets us access the PlaysoundsViewControl and now we can send data to it programmatically.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receievedAudio = data
            print("Prepare for Segue Data ======= \(data)")
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
        pressRecord.enabled = true
        recordButton.enabled = true
        
        
    }
    

}

