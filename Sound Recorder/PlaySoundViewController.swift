//
//  PlaySoundViewController.swift
//  Sound Recorder
//
//  Created by Cory McNeil on 3/9/15.
//  Copyright (c) 2015 Cory McNeil. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var recievedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioEngine = AVAudioEngine()
        audioPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowSound(sender: UIButton) {
       //Calls func playSound with rate of .5
        playSound(0.5)
        
    }

    @IBAction func playFastSound(sender: UIButton) {
        //Calls func playSound with rate of 2.0
       playSound(2.0)
    }
    
    func playSound(rate: Float) {
        //Gets rate from playSlowSound or playFastSound and plays audio
        //Stops audioEngine to stop from playing at same time
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = rate
        audioPlayer.play()
        
    }
    
    @IBAction func chipMunk(sender: UIButton) {
        //Calls class to play recorded audio at pitch.1000
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderSound(sender: UIButton) {
        //Calls cass to play recorded audio at pitch -1000
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        //Takes in pitch variable and plays recorded audio
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    @IBAction func stopSound(sender: UIButton) {
        //Stop button to stop sounds
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
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
