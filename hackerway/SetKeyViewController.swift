//
//  SetKeyViewController.swift
//  hackerway
//
//  Created by Pawarit Bunrith on 9/7/2558 BE.
//  Copyright (c) 2558 Pawarit Bunrith. All rights reserved.
//

import UIKit

class SetKeyViewController: UIViewController, keyPadProtocal {
    
    @IBOutlet var box1: UILabel!
    @IBOutlet var box2: UILabel!
    @IBOutlet var box3: UILabel!
    @IBOutlet var box4: UILabel!
    
    var chaKey = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        println("done")
    }
    
    @IBAction func setBunnon(sender: UIButton) {
        setKey()
        reset()
        
        var vc = self.storyboard?.instantiateViewControllerWithIdentifier("gamingController") as! GameViewController
        defind.variable.keyPadViewActivate = vc
        
        delay(1.0){
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func clearButton(sender: UIButton) {
        reset()
    }
    
    func addLabel(index: Int) {
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
        defind.variable.chaKey = chaKey
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
