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
    
    @IBOutlet var heightScore: UILabel!
    @IBOutlet var yourScore: UILabel!
    
    var meterTimer:NSTimer!
    var counter: Int = defind.variable.timeCouter
    var playerCounting: Int = 0
    
    var isClose: Bool = false
    
    var summaryTitle: String = ""
    var isSummary: Bool = false
    
    var shotSound: String = "ding"
    var longSound: String = "ding2"
    
    var answerKey = [String]()
    var summaryDictGame = [String: [Int]]()
    
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
        summaryDictGame = [:]
        
        if isClose == true {
            defind.variable.currentLevel = 0
            defind.variable.score = 0
            self.dismissViewControllerAnimated(true, completion: nil)
        }else {
            self.hitLabel.text = ""
            counter = defind.variable.timeCouter
            defind.variable.deadCouter = 10
            time.text = "TIME : \(String(counter)) s"
            
            deadCouter.text = String(defind.variable.deadCouter)
            meterTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        }
        
        
        if mode == gameMode {
            
            self.yourScore.hidden = false
            self.heightScore.hidden = false
            
            let userSetting: NSUserDefaults! = NSUserDefaults.standardUserDefaults()
            var hightScore = userSetting.integerForKey("hiscore")
            
            if hightScore < defind.variable.score {
                userSetting.setInteger(defind.variable.score, forKey: "hiscore")
                hightScore = defind.variable.score
            }
            
            self.heightScore.text = "Hight score: \(String(hightScore))"
            self.yourScore.text = "Your score: \(String(defind.variable.score))"
            
        }else {
            self.yourScore.hidden = true
            self.heightScore.hidden = true
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func haveLife(currect: Int, answer: [String]) {
        
        if currect == 0 {
            self.hitLabel.text = ""
            
        }else if currect == 1 {
            self.hitLabel.text = "Correct •"
            
        }else if currect == 2 {
            self.hitLabel.text = "Correct ••"
            
        }else if currect == 3 {
            self.hitLabel.text = "Correct •••"
            
        }else if currect == 4 {
            self.hitLabel.text = "Answer is \(answer[0])\(answer[1])\(answer[2])\(answer[3])"
            
        }
        
        self.meterTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        self.reset()
    }
    
    func updateCounter() {
        
        if counter >= 0 {
            time.text = "TIME : \(String(counter--)) s"
        }else if counter < 0 {
            self.meterTimer.invalidate()
           
            answerKey = defind.datas.storyKey
            self.counter = 0
            if self.mode == self.challengeMode {
                answerKey = defind.datas.challengeKey
            }
            
            self.hitLabel.text = "Time UP!!"
            self.isSummary = true
            summaryTitle = "Game Over"
            
            self.playSound(longSound)
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
    
    func lifeCheck(rightP: Int, rightA: Int, answer: [String]) {
        meterTimer.invalidate()
        
        answerKey = answer
        
        if rightP < 4{
            self.isSummary = false
            let yourLife = defind.variable.deadCouter < 0 ? defind.variable.deadCouter : defind.variable.deadCouter - 1
            defind.variable.deadCouter = yourLife
            self.deadCouter.text = String(yourLife)
            
            delay(0.1) {
                if(yourLife > 0){
                    self.haveLife(rightP, answer: answer)
                    
                    if rightP > 0 && rightP != 4 {
                        self.playerCounting = rightP
                        self.delay(0.2){
                            self.playSound(self.shotSound)
                        }
                    }
                    
                }else {
                    if self.mode == self.randomMode {
                        defind.variable.currentLevel = 0
                        
                    }else {
                        self.hitLabel.text = ""
                    }
                    
                    self.summaryTitle = "Game Over"
                    
                    self.hitLabel.text = "Game Over"
                    
                    self.isSummary = true
                    self.playSound(self.longSound)
                    
                }
            }
            
        }else if rightP >= 4 {
            self.isSummary = true
            self.hitLabel.text = "Answer is \(answer[0])\(answer[1])\(answer[2])\(answer[3])"
            self.playerCounting = rightP
            
            summaryTitle = "Congraturation"
            
            self.playSound(longSound)
        }
    }
    
    func reset() {
        box1.text = ""
        box2.text = ""
        box3.text = ""
        box4.text = ""
    }
    
    func playSound(path: String) {
        
        let resourcePath = NSBundle.mainBundle().URLForResource(path, withExtension: "WAV")
        
        soundPlayer = try! AVAudioPlayer(contentsOfURL: resourcePath!)
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        
        do {
            try session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
        } catch let error as NSError {
            
            print("could not set output to speaker")
            print(error.localizedDescription)
        }
        
        soundPlayer.stop()
        soundPlayer.delegate = self
        soundPlayer.volume = 1.0
        soundPlayer.prepareToPlay()
        soundPlayer.play()
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        
        playerCounting -= 1
        if self.playerCounting > 0 && playerCounting < 3 && defind.variable.deadCouter > 0 {
            self.playSound(shotSound)
        }else {
            if self.isSummary == true {
                
                self.summaryView(self.summaryTitle)
            }
        }
    }
    
    func updateSummary(summaryDic: [String : [Int]]) {
        print("summaryDic.count game = \(summaryDic.count)")
        self.summaryDictGame = summaryDic
    }
    
    func summaryView(title: String) {
        sleep(2)
        
        print("summaryDictGame = \(summaryDictGame.count)")
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("calculateController") as! ScoreViewController
        vc.summaryDic = self.summaryDictGame
        vc.timeCounting = self.counter
        vc.missionStatus2 = title
        vc.life = defind.variable.deadCouter
        vc.uiCheck = self
        vc.answerKey = answerKey
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
