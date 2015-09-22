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
    
    var retry: Int = 0
    
    var arryOfDatas:[SummaryData] = [SummaryData]()
    
    override func viewDidLoad() {
        
        UnityAds.sharedInstance().delegate = self
        UnityAds.sharedInstance().startWithGameId(adsId)
        
        super.viewDidLoad()
        
        missionStatus.topItem?.title = missionStatus2
        
        if defind.variable.currentLevel >= 14 || self.mode == self.challengeMode || self.mode == self.randomMode || self.missionStatus2 == "Game Over"{
            nextButton.setTitle("End", forState: .Normal)
        }
        
        if missionStatus2 == "Game Over" && mode == gameMode{
            if retry > 0 {
                UnityAds.sharedInstance().setViewController(self)
                UnityAds.sharedInstance().setZone("rewardedVideoZone")
                
                if UnityAds.sharedInstance().canShowAds(){
                    tryAgain.setTitle("Watch", forState: .Normal)
                }
            }
        }
        
        if tryAgain.titleLabel!.text == "Try again" {
            tryAgain.backgroundColor = UIColor.brownColor()
        }else if tryAgain.titleLabel!.text == "Watch" {
            tryAgain.backgroundColor = UIColor.blueColor()
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
        
        if sender.titleLabel?.text == "Watch" {
            
            if UnityAds.sharedInstance().canShowAds(){
                UnityAds.sharedInstance().show()
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
        
        // LV(life x 100 + sec x 10)
        let life = missionStatus2 == "Game Over" ? 0 : defind.variable.deadCouter
        let lifeScore: Int = life * 100
        
        self.lifeScr.text = String(lifeScore)
        
        if missionStatus2 == "Game Over" {
            timeCounting = 0
        }
        
        let timeScore: Int = timeCounting * 10
        
        self.timeCout.text = String(timeCounting)
        
        self.timeSCr.text = String(timeScore)
        
        let totleScore = defind.variable.currentMultiply * (lifeScore + timeScore)
        
        self.totalSCr.text = String(totleScore)
        
        
        let userSetting: NSUserDefaults! = NSUserDefaults.standardUserDefaults()
        let hightScore = userSetting.integerForKey("hiscore")
        
        if totleScore > hightScore && mode == gameMode {
            setScore(totleScore)
        }
    }
    
    
    func setScore(score: Int) {
        let userSetting: NSUserDefaults! = NSUserDefaults.standardUserDefaults()
        userSetting.setInteger(score, forKey: "hiscore")
    }
    
    func setUpDatas() {
        var key = defind.datas.storyKey
        
        if self.mode == self.challengeMode {
            key = defind.datas.challengeKey
        }
        
        let ansSet = SummaryData(title: "Correct", index1: Int(key[0])! + 10, index2: Int(key[1])! + 10, index3: Int(key[2])! + 10, index4: Int(key[3])! + 10)
        
        arryOfDatas.append(ansSet)
        
        
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
