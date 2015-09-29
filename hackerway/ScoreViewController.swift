//
//  ScoreViewController.swift
//  hackerway
//
//  Created by Pawarit Bunrith on 9/7/2558 BE.
//  Copyright (c) 2558 Pawarit Bunrith. All rights reserved.
//

protocol UICheckProtocal {
    func UICheck(isClose: Bool)
}

import UIKit

class ScoreViewController: UIViewController, UnityAdsDelegate {
    
    var uiCheck: UICheckProtocal? = nil
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var endButton: UIButton!
    @IBOutlet var tryAgain: UIButton!
    @IBOutlet var missionStatus: UINavigationBar!
    
    var missionStatus2: String = ""
    var summaryDic = [String: [Int]]()
    
    var timeCounting: Int = 0
    var life: Int = 10
    var afterAds: Bool = false
    
    @IBOutlet var timeCout: UILabel!
    
    @IBOutlet var answer: UILabel!
    @IBOutlet var lifeCount: UILabel!
    @IBOutlet var lifeScr: UILabel!
    @IBOutlet var timeSCr: UILabel!
    @IBOutlet var totalSCr: UILabel!
    @IBOutlet var scrView: UIView!
    @IBOutlet var story: UILabel!
    
    @IBOutlet var hightScore: UILabel!
    @IBOutlet var yourScore: UILabel!
    
    var mode: String = defind.variable.currentMode
    var gameMode = "STORY"
    var challengeMode = "CHALLENGE"
    var randomMode = "RANDOM"
    
    var actionNext: String = "NEXT"
    var actionTry: String = "TRY"
    
    var adsId: String = "76395"
    var answerKey = [String]()
    
    override func viewDidLoad() {
        
        UnityAds.sharedInstance().delegate = self
        UnityAds.sharedInstance().startWithGameId(adsId)
        
        super.viewDidLoad()
        calculateScore()
        
        missionStatus.topItem?.title = missionStatus2
        
        let userSetting: NSUserDefaults! = NSUserDefaults.standardUserDefaults()
        let turnPro = userSetting.boolForKey("turnpro")
        
        
        print("Mode = \(turnPro)")
        var gameLength = 9
        
        if turnPro == true {
            gameLength = 14
        }
        
        if defind.variable.currentLevel >= gameLength || self.mode == self.challengeMode || self.mode == self.randomMode || self.missionStatus2 == "Game Over"{
            nextButton.setTitle("End", forState: .Normal)
            
            if self.mode == self.gameMode {
                saveScore()
                userSetting.setBool(true, forKey: "turnpro")
                
            }
        }
        
        print("Show ads == \(defind.variable.adsOn)")
        
        if missionStatus2 == "Game Over" && mode == gameMode {
            nextButton.hidden = true
            tryAgain.hidden = false
            endButton.hidden = false
            
            if defind.variable.adsOn == true {
                UnityAds.sharedInstance().setViewController(self)
                UnityAds.sharedInstance().setZone("rewardedVideoZone")
                
                if UnityAds.sharedInstance().canShowAds(){
                    tryAgain.setTitle("Watch to try again", forState: .Normal)
                }
            }else {
                defind.variable.adsOn = true
            }
        }else if missionStatus2 == "Congraturation"{
            
            nextButton.hidden = false
            
            if defind.variable.currentLevel >= 14 {
                nextButton.setTitle("End", forState: .Normal)
            }
            
            tryAgain.hidden = true
            endButton.hidden = true
            defind.variable.adsOn = false
        }
        
        if tryAgain.titleLabel!.text == "Try again" {
            tryAgain.backgroundColor = UIColor.brownColor()
        }else if tryAgain.titleLabel!.text == "Watch to try again" {
            tryAgain.backgroundColor = UIColor.blueColor()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if afterAds == true {
            let refreshAlert = UIAlertController(title: "Ready", message: "Ready for try again", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                self.summaryAction(self.actionTry, mode: self.gameMode)
                self.afterAds = false
            }))
            
            self.presentViewController(refreshAlert, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func summaryButton(sender: UIButton) {
        print("SUMMARY = \(summaryDic)")
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("summary") as! SummaryViewController
        vc.summaryDic = summaryDic
        vc.answerKey = answerKey
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func nextAction(sender: UIButton) {
        if sender.titleLabel?.text == "Next" {
            defind.variable.currentLevel += 1
            summaryAction(actionNext, mode: gameMode)
        }else {
            summaryAction(actionNext, mode: randomMode)
        }
    }
    
    @IBAction func tryAgainButton(sender: UIButton) {
        if sender.titleLabel?.text == "Watch to try again" {
            
            if UnityAds.sharedInstance().canShowAds(){
                
                let refreshAlert = UIAlertController(title: "Watch", message: "Watch ads for enable try again", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Watch", style: .Default, handler: { (action: UIAlertAction!) in
                    print("WATCH")
                    UnityAds.sharedInstance().show()
                    
                }))
                
                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
                    print("CANCEL")
                }))
                
                presentViewController(refreshAlert, animated: true, completion: nil)
                
            }else {
                tryAgain.setTitle("Try again", forState: .Normal)
                tryAgain.backgroundColor = UIColor.brownColor()
            }
            
        }else {
            if mode == gameMode {
                summaryAction(actionTry, mode: gameMode)
            }else {
                summaryAction(actionTry, mode: randomMode)
            }
            
        }
    }
    
    func calculateScore() {
        
        var key = answerKey
        self.story.text = String(defind.variable.levelMsg)
        
        if self.mode == self.challengeMode {
            key = defind.datas.challengeKey
            self.story.text = "Challenge mode"
        }
        
        answer.text = "\(String(key[0]))\(String(key[1]))\(String(key[2]))\(String(key[3]))"
        
        // LV(life x 100 + sec x 10)
        let life = self.life
        
        self.lifeCount.text = String(life)
        
        self.lifeCount.textColor = life <= 0 ? UIColor.redColor() : UIColor.blackColor()
        
        self.lifeScr.textColor = UIColor.blackColor()
        
        let lifeScore: Int = life * 100
        
        self.lifeScr.text = String(lifeScore)
        
        let timeScore: Int = timeCounting * 10
        
        self.timeCout.textColor = timeCounting <= 0 ? UIColor.redColor() : UIColor.blackColor()
        
        self.timeCout.text = String(timeCounting)
        
        self.timeSCr.text = String(timeScore)
        
        var totleScore = defind.variable.currentMultiply * (lifeScore + timeScore)
        
        if timeCounting <= 0 || life <= 0 {
            totleScore = 0
        }
        
        self.totalSCr.text = String(totleScore)
        
        if mode == gameMode {
            setScore(totleScore)
        }
    }
    
    
    func setScore(score: Int) {
        defind.variable.score += score
        
        let userSetting: NSUserDefaults! = NSUserDefaults.standardUserDefaults()
        let topScore = userSetting.integerForKey("hiscore")
        
        self.hightScore.text = "Hight score: \(String(topScore))"
        self.yourScore.text = "Your score: \(String(defind.variable.score))"
        
    }
    
    func saveScore() {
        if mode == gameMode {
            let userSetting: NSUserDefaults! = NSUserDefaults.standardUserDefaults()
            let hightScore = userSetting.integerForKey("hiscore")
            
            if hightScore < defind.variable.score {
                userSetting.setInteger(defind.variable.score, forKey: "hiscore")
            }
        }
    }
    
    func summaryAction(action: String, mode: String) {
        if mode != gameMode {
            if action != actionTry {
                defind.variable.currentLevel = 0
                self.uiCheck?.UICheck(true)
            }
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func unityAdsVideoCompleted(rewardItemKey: String, skipped: Bool) -> Void{
        if !skipped {
            afterAds = true
            tryAgain.setTitle("Try again", forState: .Normal)
            
            if tryAgain.titleLabel!.text == "Try again" {
                tryAgain.backgroundColor = UIColor.brownColor()
            }
            
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
    }
}
