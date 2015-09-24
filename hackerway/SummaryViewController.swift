//
//  SummaryViewController.swift
//  hackerway
//
//  Created by Pawarit Bunrith on 9/7/2558 BE.
//  Copyright (c) 2558 Pawarit Bunrith. All rights reserved.
//

protocol UICheckProtocal {
    func UICheck(isClose: Bool)
}

import UIKit

class SummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UnityAdsDelegate {
    
    var uiCheck: UICheckProtocal? = nil
    
    @IBOutlet var myTableView: UITableView!
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var tryAgain: UIButton!
    @IBOutlet var missionStatus: UINavigationBar!
    
    var missionStatus2: String = ""
    var summaryDic = [String: [Int]]()
    
    var timeCounting: Int = 0
    var afterAds: Bool = false
    
    @IBOutlet var timeCout: UILabel!
    
    @IBOutlet var answer: UILabel!
    @IBOutlet var lifeCount: UILabel!
    @IBOutlet var lifeScr: UILabel!
    @IBOutlet var timeSCr: UILabel!
    @IBOutlet var totalSCr: UILabel!
    @IBOutlet var scrView: UIView!
    
    var mode: String = defind.variable.currentMode
    var gameMode = "STORY"
    var challengeMode = "CHALLENGE"
    var randomMode = "RANDOM"
    
    var actionNext: String = "NEXT"
    var actionTry: String = "TRY"
    
    var adsId: String = "76395"
    
    var statusLabel: String = ""
    var overMode: String = ""
    
    var arryOfDatas:[SummaryData] = [SummaryData]()
    
    override func viewDidLoad() {
        
        UnityAds.sharedInstance().delegate = self
        UnityAds.sharedInstance().startWithGameId(adsId)
        
        super.viewDidLoad()
        
        missionStatus.topItem?.title = missionStatus2
        
        if defind.variable.currentLevel >= 14 || self.mode == self.challengeMode || self.mode == self.randomMode || self.missionStatus2 == "Game Over"{
            nextButton.setTitle("End", forState: .Normal)
        }
        
        print("Show ads == \(defind.variable.adsOn)")
        
        if missionStatus2 == "Game Over" && mode == gameMode {
            print("Show ads == \(defind.variable.adsOn)")
            if defind.variable.adsOn == true {
                UnityAds.sharedInstance().setViewController(self)
                UnityAds.sharedInstance().setZone("rewardedVideoZone")
                
                if UnityAds.sharedInstance().canShowAds(){
                    tryAgain.setTitle("Watch to try again", forState: .Normal)
                }
            }else {
                defind.variable.adsOn = true
            }
        }else {
            defind.variable.adsOn = false
        }
        
        
        if tryAgain.titleLabel!.text == "Try again" {
            tryAgain.backgroundColor = UIColor.brownColor()
        }else if tryAgain.titleLabel!.text == "Watch to try again" {
            tryAgain.backgroundColor = UIColor.blueColor()
        }
        
        if overMode == "WIN" {
            if mode == gameMode {
                tryAgain.hidden = true
            }else {
                tryAgain.hidden = false
            }
            
        }
        
        calculateScore()
        setUpDatas()
        
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
    
    @IBAction func segmentControl(sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            showScore()
        case 1:
            showSummary()
        default:
            break;
        }
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
    
    func showSummary() {
        scrView.hidden = true
        myTableView.hidden = false
        
    }
    
    func showScore() {
        
        scrView.hidden = false
        myTableView.hidden = true
        
    }
    
    func calculateScore() {
        
        var key = defind.datas.storyKey
        
        if self.mode == self.challengeMode {
            key = defind.datas.challengeKey
        }
        
        if overMode == "WIN" {
            statusLabel = "Answer is"
            
        }else if overMode == "TIME" {
            statusLabel = "Time UP!!"
            answer.text = "????"
            
        }else if overMode == "LIFE" {
            statusLabel = "Game over"
            answer.text = "????"
            
        }
        
        answer.text = "\(String(key[0]))\(String(key[1]))\(String(key[2]))\(String(key[3]))"
        
        // LV(life x 100 + sec x 10)
        let life =  overMode == "LIFE" ? 0 : defind.variable.deadCouter
        
        self.lifeCount.text = String(life)
        
        self.lifeCount.textColor = overMode == "LIFE" ? UIColor.redColor() : UIColor.blackColor()
        
        self.lifeScr.textColor = UIColor.blackColor()
        
        var lifeScore: Int = life * 100
        
        if missionStatus2 == "Game Over" {
            timeCounting = 0
            lifeScore = 0
        }
        
        self.lifeScr.text = String(lifeScore)
        
        let timeScore: Int = timeCounting * 10
        
        self.timeCout.textColor = overMode == "TIME" ? UIColor.redColor() : UIColor.blackColor()
        
        self.timeCout.text = String(timeCounting)
        
        self.timeSCr.text = String(timeScore)
        
        let totleScore = defind.variable.currentMultiply * (lifeScore + timeScore)
        
        self.totalSCr.text = String(totleScore)
        
        if mode == gameMode {
            setScore(totleScore)
        }
    }
    
    
    func setScore(score: Int) {
        defind.variable.score += score
    }
    
    func setUpDatas() {
        var key = defind.datas.storyKey
        
        if self.mode == self.challengeMode {
            key = defind.datas.challengeKey
        }
        
        let winSet = SummaryData(title: statusLabel, index1: Int(key[0])! + 10, index2: Int(key[1])! + 10, index3: Int(key[2])! + 10, index4: Int(key[3])! + 10)
        arryOfDatas.append(winSet)
        
        for var index: Int = 0; index < summaryDic.count; index++ {
            let keyDic = String(index + 1)
            
            if summaryDic[keyDic] != nil && summaryDic[keyDic]?.count == 4{
                var myArary = summaryDic[keyDic]!
                
                let dataSet = SummaryData(title: "Turn \(keyDic)", index1: myArary[0], index2: myArary[1], index3: myArary[2], index4: myArary[3])
                
                arryOfDatas.append(dataSet)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arryOfDatas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SummaryCell = tableView.dequeueReusableCellWithIdentifier("cell") as! SummaryCell
        
        let summaryDatas = arryOfDatas[indexPath.row]
        
        cell.setCell(summaryDatas.title, indexData1: summaryDatas.index1, indexData2: summaryDatas.index2, indexData3: summaryDatas.index3, indexData4: summaryDatas.index4)
        
        return cell
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
