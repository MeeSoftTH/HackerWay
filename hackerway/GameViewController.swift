//
//  GameViewController.swift
//  hackerway
//
//  Created by Pawarit Bunrith on 9/7/2558 BE.
//  Copyright (c) 2558 Pawarit Bunrith. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, keyPadProtocal {
    
    @IBOutlet var box1: UILabel!
    @IBOutlet var box2: UILabel!
    @IBOutlet var box3: UILabel!
    @IBOutlet var box4: UILabel!
    
    @IBOutlet var yourMission: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var deadCouter: UILabel!
    
    @IBOutlet var keyPad: UIView!
    @IBOutlet var hitLabel: UILabel!
    
    var userKey = [String]()
    var ansKey = [String]()
    
    var meterTimer:NSTimer!
    var counter: Int = 180
    var statrd: Bool = false
    var mode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("Mode is \(mode)")
        
        deadCouter.text = String(defind.variable.deadCouter)
        time.text = "Remaining: \(String(counter)) s"
        
        if mode == "STORY" {
            functions().createMission()
            ansKey = defind.datas.storyKey
            yourMission.text = defind.variable.currentMissionLabel
            status.text = defind.variable.currentMissionTitle
        
        }else if  mode == "CHALLENGE" {
            ansKey = defind.datas.challengeKey
            yourMission.text = defind.variable.challengeTitle
            status.text = defind.variable.challengeLabel
        }
        
        delay(0.5){
            self.statrd = true
            self.start()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func start() {
        meterTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
    }
    
    @IBAction func exitButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        println("done")
    }
    
    func reset() {
        userKey = [String]()
        box1.text = ""
        box2.text = ""
        box3.text = ""
        box4.text = ""
    }
    
    func addLabel(index: Int) {
        
        //println("box.text = \(text)")
        var text = String(index)
        
        if box1.text == "" {
            box1.text = text
            self.userKey.append(text)
        }else if box2.text == "" {
            box2.text = text
            self.userKey.append(text)
        }else if box3.text == "" {
            box3.text = text
            self.userKey.append(text)
        }else if box4.text == "" {
            box4.text = text
            self.userKey.append(text)
        }
        
        if box4.text != ""{
            matching()
        }
    }
    
    func matching(){
        
        var pNaRight: Int = 0
        var aRight: Int = 0
        
        for var i: Int = 0; i < ansKey.count; i++ {
            
            for var j: Int = 0; j < userKey.count; j++ {
                
                if ansKey[i] == userKey[i] {
                    pNaRight += 1
                    aRight += 1
                    j = userKey.count
                }else if ansKey[i] == userKey[j] {
                    aRight += 1
                    j = userKey.count
                }
            }
        }
        
        println("Ans Key = \(ansKey)")
        println("User Key = \(self.userKey)")
        
        //println("Summary ans : current answer = \(pNaRight); Right answer = \(aRight)")
        
        meterTimer.invalidate()
        
        if pNaRight < 4{
            var yourLife = defind.variable.deadCouter - 1
            defind.variable.deadCouter = yourLife
            
            hitLabel.text = ""
            
            delay(2.0) {
                if(yourLife > 0){
                    self.haveLife(yourLife, lLabel: aRight, rLabel: pNaRight)
                }else {
                    self.noHaveLife()
                }
            }
            
        }else if pNaRight >= 4 {
            
            hitLabel.text = ""
            
            var alert = UIAlertController(title: "Congraturation", message: "You win!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                self.meterTimer.invalidate()
                self.delay(1.0){
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func haveLife(lifeNum: Int, lLabel: Int, rLabel: Int) {
        self.hitLabel.text = "Current \(String(lLabel)) answer. \n Current \(String(rLabel)) positions."
        self.deadCouter.text = String(lifeNum)
        
        self.meterTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        self.reset()
        
    }
    
    func noHaveLife() {
        self.meterTimer.invalidate()
        var alert = UIAlertController(title: "You are dead", message: "Try again later", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: .Default, handler: { (action: UIAlertAction!) in
            
            
            
            self.delay(1.0){
                defind.variable.deadCouter = 10
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func updateCounter() {
        if counter > 0 {
            time.text = "Remaining: \(String(counter--)) s"
        }else if counter <= 0 {
            self.meterTimer.invalidate()
            noHaveLife()
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
    }
    
    
    func keyPadIndex(index: Int){
        if statrd == true {
            self.addLabel(index)
        }
    }
}
