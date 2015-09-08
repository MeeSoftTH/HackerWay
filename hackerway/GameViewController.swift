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
    
    var arrayKey = [Int]()
    var randomAnswer = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMissions()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        println("done")
    }
    
    func getMissions() {
        if defind.variable.missionNo == 1 {
            
            for var i: Int = 0; i < 1; i++ {
                var randomAnswer = randomIndex(12, start:1)
                self.arrayKey.append(randomAnswer)
            }
            
            for var i: Int = 0; i < 3; i++ {
                var randomAgain = Int(arc4random_uniform(UInt32(self.arrayKey.count)))
                self.arrayKey.append(randomAgain)
            }
            
            println("Summary Ans = \(self.arrayKey)")
        }
    }
    
    func randomIndex(end: Int, start: Int)-> Int {
        var randomNumber = arc4random_uniform(UInt32(end)) + UInt32(start)
        return Int(randomNumber)
    }
    
    func reset() {
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
            self.arrayKey.append(index)
        }else if box2.text == "" {
            box2.text = text
            self.arrayKey.append(index)
        }else if box3.text == "" {
            box3.text = text
            self.arrayKey.append(index)
        }else if box4.text == "" {
            box4.text = text
            self.arrayKey.append(index)
        }
    }
    
    func matching(){
        
        reset()
        
    }
    
    
    func keyPadIndex(index: Int){
        
        self.addLabel(index)
    }
}
