//
//  GameViewController.swift
//  hackerway
//
//  Created by Pawarit Bunrith on 9/7/2558 BE.
//  Copyright (c) 2558 Pawarit Bunrith. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, updateLabelProtocal {
    
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
    
    var meterTimer:NSTimer!
    var counter: Int = 180
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defind.variable.deadCouter = 10
    }
    
    @IBAction func exit(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        time.text = "Remaining: \(String(counter)) s"
        counter = 180
        deadCouter.text = String(defind.variable.deadCouter)
        delay(0.5){
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
    
    func youWin() {
        
        var alert = UIAlertController(title: "Congraturation", message: "You win!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            self.meterTimer.invalidate()
            self.delay(0.5){
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func haveLife(lLabel: Int, rLabel: Int) {
        self.hitLabel.text = "Current \(String(lLabel)) answer. \n Current \(String(rLabel)) positions."
        self.meterTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        self.reset()
        
    }
    
    func noHaveLife() {
        self.meterTimer.invalidate()
        var alert = UIAlertController(title: "You are dead", message: "Try again later", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: .Default, handler: { (action: UIAlertAction!) in
            
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
            noHaveLife()
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
        var text = String(index)
        
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
    
    func lifeCheck(rightP: Int, rightA: Int) {
        meterTimer.invalidate()
        if rightP < 4{
            var yourLife = defind.variable.deadCouter - 1
            defind.variable.deadCouter = yourLife
            self.deadCouter.text = String(yourLife)
            
            delay(0.1) {
                if(yourLife > 0){
                    self.haveLife(rightA, rLabel: rightP)
                }else {
                    self.noHaveLife()
                    self.hitLabel.text = ""
                }
            }
            
        }else if rightP >= 4 {
            youWin()
        }
    }
    
    func reset() {
        box1.text = ""
        box2.text = ""
        box3.text = ""
        box4.text = ""
    }
}
