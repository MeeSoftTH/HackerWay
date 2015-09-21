//
//  GameViewController.swift
//  hackerway
//
//  Created by Pawarit Bunrith on 9/7/2558 BE.
//  Copyright (c) 2558 Pawarit Bunrith. All rights reserved.
//

import UIKit
import AVFoundation

protocol updateScoreProtocal {
    func updateScore()
}

class GameViewController: UIViewController, AVAudioPlayerDelegate, updateLabelProtocal, UICheckProtocal {
    
    var update: updateScoreProtocal? = nil
    
    @IBOutlet var box1: UILabel!
    @IBOutlet var box2: UILabel!
    @IBOutlet var box3: UILabel!
    @IBOutlet var box4: UILabel!
    
    @IBOutlet var yourMission: UINavigationBar!
    @IBOutlet var status: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var deadCouter: UILabel!
    
    @IBOutlet var keyPad: UIView!
    @IBOutlet var hitLabel: UILabel!
    
    var soundPlayer:AVAudioPlayer = AVAudioPlayer()
    var mode: String = defind.variable.currentMode
    var gameMode = "STORY"
    var challengeMode = "CHALLENGE"
    var randomMode = "RANDOM"
    
    var meterTimer:NSTimer!
    var counter: Int = 180
    var summaryAns = [String: [Int]]()
    
    var isClose: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func exit(sender: UIBarButtonItem) {
        self.meterTimer.invalidate()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if isClose == true {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        self.hitLabel.text = ""
        counter = 180
        defind.variable.deadCouter = 10
        time.text = "Remaining: \(String(counter)) s"
        
        deadCouter.text = String(defind.variable.deadCouter)
        meterTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func youWin() {
        self.hitLabel.text = "Correct ••••"
        let alert = UIAlertController(title: "Congraturation", message: "You win!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction) in
            self.meterTimer.invalidate()
            self.delay(0.5){
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func haveLife(currect: Int) {
        
        if currect == 0 {
            self.hitLabel.text = ""
            
        }else if currect == 1 {
            self.hitLabel.text = "Correct •"
            
        }else if currect == 2 {
            self.hitLabel.text = "Correct ••"
            
        }else if currect == 3 {
            self.hitLabel.text = "Correct •••"
            
        }else if currect == 4 {
            self.hitLabel.text = "Correct ••••"
            
        }
        
        self.meterTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        self.reset()
    }
    
    func noHaveLife() {
        self.meterTimer.invalidate()
        playSound()
        
        var text: String = "Try again later"
        
        if mode == challengeMode {
            text = "Your friend is win!"
        }
        
        let alert = UIAlertController(title: "GAME OVER", message: text, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: .Default, handler: { (action: UIAlertAction) in
            
            self.delay(0.5){
                defind.variable.deadCouter = 10
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func updateCounter() {
        if counter >= 0 {
            time.text = "Remaining: \(String(counter--)) s"
        }else if counter < 0 {
            self.meterTimer.invalidate()
            //noHaveLife()
            self.summaryView(summaryAns, title: "Game Over")
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
    }
    
    func missionLabel(title: String, description: String) {
        
        yourMission.topItem?.title = title
        status.text = description
        
    }
    
    
    func keyPadIndex(index: Int){
        let text = String(index)
        
        if box1.text == "" {
            box1.text = text
        }else if box2.text == "" {
            box2.text = text
        }else if box3.text == "" {
            box3.text = text
        }else if box4.text == "" {
            box4.text = text
        }
    }
    
    func lifeCheck(rightP: Int, rightA: Int, summary: [String: [Int]]) {
        meterTimer.invalidate()
        summaryAns = summary
        if rightP < 4{
            let yourLife = defind.variable.deadCouter - 1
            defind.variable.deadCouter = yourLife
            self.deadCouter.text = String(yourLife)
            
            delay(0.1) {
                if(yourLife > 0){
                    self.haveLife(rightP)
                }else {
                    if self.mode == self.randomMode {
                        defind.variable.currentLevel = 0
                        //self.noHaveLife()
                        
                    }else {
                        //self.noHaveLife()
                        self.hitLabel.text = ""
                    }
                    self.summaryView(summary, title: "Game Over")
                }
                
            }
            
        }else if rightP >= 4 {
            self.summaryView(summary, title: "Congraturation")
            //youWin()
        }
    }
    
    func reset() {
        box1.text = ""
        box2.text = ""
        box3.text = ""
        box4.text = ""
    }
    
    func playSound() {
        
        var error: NSError?
        
        let resourcePath = NSBundle.mainBundle().URLForResource("ding", withExtension: "WAV")
        
        soundPlayer = try! AVAudioPlayer(contentsOfURL: resourcePath!)
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        
        do {
            try session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
        } catch let error1 as NSError {
            error = error1
            print("could not set output to speaker")
            if let e = error {
                print(e.localizedDescription)
            }
        }
        
        if let err = error {
            print("AVAudioPlayer error: \(err.localizedDescription)")
        } else {
            print("AVAudioPlayer Play: \(resourcePath)")
            soundPlayer.stop()
            soundPlayer.delegate = self
            soundPlayer.volume = 1.0
            soundPlayer.prepareToPlay()
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            soundPlayer.play()
        }
    }
    
    func summaryView(summary: [String: [Int]], title: String) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("calculateController") as! SummaryViewController
        vc.summaryDic = summary
        vc.timeCounting = counter
        vc.missionStatus2 = title
        vc.uiCheck = self
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func  UICheck(isClose: Bool) {
        
        if isClose == true {
            self.isClose = true
        }
    }
}
