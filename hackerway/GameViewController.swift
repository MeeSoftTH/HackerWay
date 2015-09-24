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
    var playerCounting: Int = 0
    
    var isClose: Bool = false
    
    var summaryTitle: String = ""
    var summaryOverMode: String = ""
    var isSummary: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func exit(sender: UIBarButtonItem) {
        self.meterTimer.invalidate()
        defind.variable.currentLevel = 0
        
        if mode == gameMode {
            
            let userSetting: NSUserDefaults! = NSUserDefaults.standardUserDefaults()
            let hightScore = userSetting.integerForKey("hiscore")
            if hightScore < defind.variable.score {
                userSetting.setInteger(defind.variable.score, forKey: "hiscore")
            }
        }
        
        defind.variable.score = 0
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.isSummary = false
        
        if isClose == true {
            defind.variable.currentLevel = 0
            defind.variable.score = 0
            self.dismissViewControllerAnimated(true, completion: nil)
        }else {
            
            self.hitLabel.text = ""
            counter = 180
            defind.variable.deadCouter = 10
            time.text = "TIME : \(String(counter)) s"
            
            deadCouter.text = String(defind.variable.deadCouter)
            meterTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func updateCounter() {
        
        if counter >= 0 {
            time.text = "TIME : \(String(counter--)) s"
        }else if counter < 0 {
            self.meterTimer.invalidate()
            //noHaveLife()
            counter = 0
            
            self.isSummary = true
            summaryTitle = "Game Over"
            summaryOverMode = "TIME"
            
            self.playSound()
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
            self.isSummary = false
            let yourLife = defind.variable.deadCouter < 0 ? defind.variable.deadCouter : defind.variable.deadCouter - 1
            defind.variable.deadCouter = yourLife
            self.deadCouter.text = String(yourLife)
            
            delay(0.1) {
                if(yourLife > 0){
                    self.haveLife(rightP)
                    
                    if rightP > 0 {
                        self.playerCounting = rightP
                        self.delay(0.2){
                            self.playSound()
                        }
                    }
                    
                }else {
                    if self.mode == self.randomMode {
                        defind.variable.currentLevel = 0
                        
                    }else {
                        self.hitLabel.text = ""
                    }
                    
                    self.summaryTitle = "Game Over"
                    self.summaryOverMode = "LIFE"
                    
                    self.isSummary = true
                    self.playSound()
                    
                }
            }
            
        }else if rightP >= 4 {
            self.isSummary = true
            self.hitLabel.text = "Correct ••••"
            self.playerCounting = rightP
            
            summaryTitle = "Congraturation"
            summaryOverMode = "WIN"
            
            self.playSound()
        }
    }
    
    func reset() {
        box1.text = ""
        box2.text = ""
        box3.text = ""
        box4.text = ""
    }
    
    func playSound() {
        
        let resourcePath = NSBundle.mainBundle().URLForResource("ding", withExtension: "WAV")
        
        soundPlayer = try! AVAudioPlayer(contentsOfURL: resourcePath!)
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        
        do {
            try session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
        } catch let error as NSError {
            
            print("could not set output to speaker")
            print(error.localizedDescription)
        }
        
        print("AVAudioPlayer Play: \(resourcePath)")
        soundPlayer.stop()
        soundPlayer.delegate = self
        soundPlayer.volume = 1.0
        soundPlayer.prepareToPlay()
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        soundPlayer.play()
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        
        playerCounting -= 1
        if self.playerCounting > 0 {
            self.playSound()
        }else {
            if self.isSummary == true {
                
                self.summaryView(summaryAns, title: self.summaryTitle, overMode: self.summaryOverMode)
            }
        }
    }
    
    
    func summaryView(summary: [String: [Int]], title: String, overMode: String) {
        sleep(2)
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("calculateController") as! SummaryViewController
        vc.summaryDic = summary
        vc.timeCounting = self.counter
        vc.missionStatus2 = title
        vc.overMode = overMode
        vc.uiCheck = self
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func  UICheck(isClose: Bool) {
        
        if isClose == true {
            
            if mode == gameMode {
                let userSetting: NSUserDefaults! = NSUserDefaults.standardUserDefaults()
                let hightScore = userSetting.integerForKey("hiscore")
                
                if hightScore < defind.variable.score {
                    userSetting.setInteger(defind.variable.score, forKey: "hiscore")
                }
            }
            defind.variable.score = 0
            
            self.isClose = true
        }
    }
}
