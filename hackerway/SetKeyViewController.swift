//
//  SetKeyViewController.swift
//  hackerway
//
//  Created by Pawarit Bunrith on 9/7/2558 BE.
//  Copyright (c) 2558 Pawarit Bunrith. All rights reserved.
//

import UIKit

class SetKeyViewController: UIViewController, setKeyLabelProtocal {
    
    @IBOutlet var box1: UILabel!
    @IBOutlet var box2: UILabel!
    @IBOutlet var box3: UILabel!
    @IBOutlet var box4: UILabel!
    
    var chaKey = [String]()
    
    var gameView: String = "GAMECONTROL"
    var setView: String = "SETKEY"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
       defind.variable.currentView = setView
        
    }
    
    @IBAction func setBunnon(sender: UIButton) {
        setKey()
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("gamingController") as! GameViewController
        defind.variable.currentView = gameView
        defind.variable.keyPadViewActivate = vc
        delay(1.0){
            self.reset()
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func clearButton(sender: UIButton) {
        reset()
    }
    
    func addLabel(index: Int) {
        let text = String(index)
        
        if box1.text == "" {
            box1.text = text
            self.chaKey.append(text)
        }else if box2.text == "" {
            box2.text = text
            self.chaKey.append(text)
        }else if box3.text == "" {
            box3.text = text
            self.chaKey.append(text)
        }else if box4.text == "" {
            box4.text = text
            self.chaKey.append(text)
        }
    }
    
    func setKey() {
        defind.datas.challengeKey = chaKey
    }
    
    func reset() {
        chaKey = [String]()
        box1.text = ""
        box2.text = ""
        box3.text = ""
        box4.text = ""
    }
    
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
    }
    
    func keyPadIndex(index: Int){
        self.addLabel(index)
    }
    
}
