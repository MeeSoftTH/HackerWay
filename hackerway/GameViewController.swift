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
    @IBOutlet var timeLeft: UILabel!
    @IBOutlet var deadCouter: UILabel!
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var keyPad: UIView!
    @IBOutlet var hitLabel: UILabel!
    
    var userKey = [String]()
    
    var meterTimer:NSTimer!
    var counter: Int = 180
    var statrd: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deadCouter.text = String(defind.variable.yourLife)
        startMission()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startButton(sender: UIButton) {
        counter = 180
        statrd = true
        meterTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        startButton.hidden = true
    }
    
    func startMission() {
        timeLeft.text = "Time left: \(String(counter)) s"
        functions().mission()
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
        
        if index == 11 {
            text = "*"
        }else if index == 12 {
            text = "#"
        }else if index == 10 {
            text = "0"
        }
        
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
        
        for var i: Int = 0; i < defind.variable.strAns.count; i++ {
            
            for var j: Int = 0; j < userKey.count; j++ {
                
                if defind.variable.strAns[i] == userKey[i] {
                    pNaRight += 1
                    j = userKey.count
                }else if defind.variable.strAns[i] == userKey[j] {
                    aRight += 1
                    j = userKey.count
                }
            }
        }
        
        println("Summary Ans = \(defind.variable.strAns)")
        println("User Ans = \(self.userKey)")
        
        println("Summary ans : current answer = \(pNaRight); Right answer = \(aRight)")
        
        meterTimer.invalidate()
        if pNaRight >= 4 {
            
            var alert = UIAlertController(title: "Congraturation", message: "Your agent is win!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                self.meterTimer.invalidate()
                self.delay(2.0){
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }else if pNaRight < 4{
            var alert = UIAlertController(title: "Your agent is die", message: "Current answer: \(aRight)\n Current answer and position: \(pNaRight)", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Get new agent to unlock", style: .Default, handler: { (action: UIAlertAction!) in
                self.hitLabel.text = "hit: \(pNaRight)A\(aRight)P"
                self.reset()
                defind.variable.yourLife--
                self.deadCouter.text = String(defind.variable.yourLife)
                
                self.meterTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        if defind.variable.yourLife < 0 {
        
            var alert = UIAlertController(title: "Your agent is 0", message: "Try again later", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Close", style: .Default, handler: { (action: UIAlertAction!) in
                self.meterTimer.invalidate()
                self.delay(2.0){
                    defind.variable.yourLife = 10
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func updateCounter() {
        timeLeft.text = "Time left: \(String(counter--)) s"
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
