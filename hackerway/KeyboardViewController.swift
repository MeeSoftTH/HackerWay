//
//  KeyboardViewController.swift
//  hackerway
//
//  Created by Pawarit Bunrith on 9/7/2558 BE.
//  Copyright (c) 2558 Pawarit Bunrith. All rights reserved.
//

import UIKit
import AVFoundation

protocol updateLabelProtocal {
    func keyPadIndex(index: Int)
    func lifeCheck(rightP: Int, rightA: Int, answer: [String])
    func missionLabel(title: String, description: String)
    func updateSummary(summaryDic: [String: [Int]])
    func reset()
}

protocol setKeyLabelProtocal {
    func keyPadIndex(index: Int)
}

class KeyboardViewController: UIViewController, AVAudioPlayerDelegate {
    
    var updateLabel: updateLabelProtocal? = defind.variable.keyPadViewActivate
    var setKeyLabel: setKeyLabelProtocal? = defind.variable.setKeyViewActivate
    
    @IBOutlet var button00: UIButton!
    @IBOutlet var button01: UIButton!
    @IBOutlet var button02: UIButton!
    @IBOutlet var button03: UIButton!
    @IBOutlet var button04: UIButton!
    @IBOutlet var button05: UIButton!
    @IBOutlet var button06: UIButton!
    @IBOutlet var button07: UIButton!
    @IBOutlet var button08: UIButton!
    @IBOutlet var button09: UIButton!
    
    var soundPlayer:AVAudioPlayer = AVAudioPlayer()
    
    var brokenImage: String = "broken"
    var fingerImage: String = "fingerprint"
    
    var userKey = [String]()
    var ansKey = [String]()
    var summaryDic = [String: [Int]]() // dicionary
    
    var multiply: Int = 1
    var strict: Bool = false
    var showFinger: Bool = false
    var buttonOn: Int = 10
    var isShuffle: Bool = false
    
    var updateText: Bool = true
    
    var pNaRight: Int = 0
    var aRight: Int = 0
    
    var mode: String = defind.variable.currentMode
    var inputCouting: Int = 0
    var isStart: Bool = true
    
    var defaultNumber = defind.datas.defaultNumber
    
    var guideMode = "GUIDE"
    var matchMode = "MATCH"
    
    var gameViewMode = "GAMECONTROL"
    var setKeyViewMode = "SETKEY"
    
    var gameMode = "STORY"
    var challengeMode = "CHALLENGE"
    var randomMode = "RANDOM"
    
    var currentView: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentView = defind.variable.currentView
        
        if mode != gameMode {
            viewIsPresent()
        }
        
        print("KeyPad ready")
        print("Current view = \(currentView)")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        reset()
        summaryDic = [:]
        print("summaryDic.count = \(summaryDic.count)")
        if mode == gameMode{
            resetState()
            viewIsPresent()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewIsPresent() {
        
        print("Tune pro Mode is \(mode)")
        
        if mode == gameMode || mode == randomMode {
            functions().createMission()
            ansKey = defind.datas.storyKey
            multiply = defind.variable.multi
            showFinger = defind.variable.showFinger
            buttonOn = defind.variable.buttonOn
            isShuffle = defind.variable.isShuffle
            
            self.updateLabel?.missionLabel(defind.variable.currentMissionTitle, description: defind.variable.currentMissionLabel)
            
            if showFinger == true && isShuffle == false {
                matching(guideMode)
            }
            
            if buttonOn < 10 {
                randomButtonOn(buttonOn)
            }
            
            if isShuffle  == true{
                shuffle(defaultNumber)
            }
            
        }else if  mode == challengeMode {
            ansKey = defind.datas.challengeKey
            self.updateLabel?.missionLabel(defind.variable.challengeTitle, description: defind.variable.challengeLabel)
        }
    }
    
    @IBAction func button0(sender: UIButton) {
        switchMode(0)
    }
    
    @IBAction func button1(sender: UIButton) {
        switchMode(1)
    }
    
    @IBAction func button2(sender: UIButton) {
        switchMode(2)
    }
    
    @IBAction func button3(sender: UIButton) {
        switchMode(3)
    }
    
    @IBAction func button4(sender: UIButton) {
        switchMode(4)
    }
    
    @IBAction func button5(sender: UIButton) {
        switchMode(5)
    }
    
    @IBAction func button6(sender: UIButton) {
        switchMode(6)
    }
    
    @IBAction func button7(sender: UIButton) {
        switchMode(7)
    }
    
    @IBAction func button8(sender: UIButton) {
        switchMode(8)
    }
    
    @IBAction func button9(sender: UIButton) {
        switchMode(9)
    }
    
    @IBAction func buttonStar(sender: UIButton) {
        switchMode(10)
    }
    
    @IBAction func buttonSharp(sender: UIButton) {
        switchMode(11)
    }
    
    
    func switchMode(index: Int) {
        if updateText == true {
            playSound()
            if currentView == gameViewMode {
                self.updateLabel?.keyPadIndex(index)
                appendData(index)
            }else if currentView == setKeyViewMode {
                self.setKeyLabel?.keyPadIndex(index)
            }
        }
    }
    
    func appendData(index: Int) {
        
        if inputCouting < self.ansKey.count {
            inputCouting += 1
            let text = String(index)
            self.userKey.append(text)
        }
        
        if inputCouting == self.ansKey.count {
            updateText = false
            delay(0.5) {
                self.validateKey()
                self.updateText = true
            }
        }
    }
    
    func validateKey(){
        matching(matchMode)
        
        print("user Key = \(self.userKey)")
        print("ans Key = \(self.ansKey)")
        
        self.updateLabel?.lifeCheck(pNaRight, rightA: aRight, answer: self.ansKey)
        
        
        self.reset()
    }
    
    func matching(mode: String) {
        
        var tempAnsKey = [String]()
        var tempUserKey = [String]()
        
        var tempSumKey = [Int]()
        
        if mode == matchMode {
            tempAnsKey = self.ansKey
            tempUserKey = self.userKey
            
        }else if mode == guideMode {
            tempAnsKey = self.ansKey
            tempUserKey = self.ansKey
        }
        
        for var i: Int = 0; i < tempAnsKey.count; i++ {
            if tempUserKey.count == 4 {
                if mode == matchMode {
                    if tempUserKey[i].lowercaseString.rangeOfString(tempAnsKey[i]) != nil {
                        tempSumKey.append(Int(tempUserKey[i])! + 10)
                        pNaRight += 1
                    }else {
                        tempSumKey.append(Int(tempUserKey[i])!)
                    }
                }
                
                for var j: Int = 0; j < tempAnsKey.count; j++ {
                    if tempUserKey[i].lowercaseString.rangeOfString(tempAnsKey[j]) != nil {
                        if isShuffle == false {
                        self.rebuildFinger(Int(tempAnsKey[j])!)
                        }
                    }
                }
            }
        }
        
        if mode == matchMode {
            let turnCheck = 11 - defind.variable.deadCouter
            if summaryDic.count < 11 {
                summaryDic[String(turnCheck)] = tempSumKey
                self.updateLabel?.updateSummary(summaryDic)
            }
        }
    }
    
    func reset() {
        self.pNaRight = 0
        self.aRight = 0
        
        self.inputCouting = 0
        
        
        delay(0.1){
            self.updateLabel?.reset()
        }
        self.userKey = [String]()
    }
    
    func rebuildFinger(index: Int){
        changeBackgroundButton("FINGER", index: index)
        
    }
    
    func randomButtonOn(numOn: Int) {
        var ansButton = ansKey
        let randomForFill = defind.datas.defaultNumber.count - numOn
        
        
        // remove ans key
        
        for var i: Int = 0; i < ansButton.count; i++ {
            let indexOfArray = findIndexOfArry(defaultNumber, dataNumber: Int(ansButton[i])!)
            defaultNumber.removeAtIndex(indexOfArray)
        }
        
        // random for disable button
        for var i: Int = 0; i < randomForFill; i++ {
            let randomArray = Int(arc4random_uniform(UInt32(defaultNumber.count)))
            let index = defaultNumber[randomArray]
            
            let indexOfArray = findIndexOfArry(defaultNumber, dataNumber: index)
            defaultNumber.removeAtIndex(indexOfArray)
            
            let button = getButtonUI(index)
            button.enabled = false
            changeBackgroundButton("BROKEN", index: index)
        }
        
        defaultNumber = defind.datas.defaultNumber
    }
    
    func shuffle(number: [Int]) {
        var tempNumber = number
        
        for var i: Int = 0; i < number.count; i++ {
            let randomArray = Int(arc4random_uniform(UInt32(tempNumber.count)))
            let index = tempNumber[randomArray]
            
            
            
            let indexOfArray = findIndexOfArry(tempNumber, dataNumber: index)
            tempNumber.removeAtIndex(indexOfArray)
            
            let button = getButtonUI(i)
            
            button.setTitle(String(index), forState: .Normal)
            print(index)
            print(button.titleLabel?.text)
            
            for var j: Int = 0; j < self.ansKey.count; j++ {
                if index == Int(self.ansKey[j]) {
                    print("\(index) = TRUE")
                    rebuildFinger(i)
                }
            }
        }
        
        defaultNumber = defind.datas.defaultNumber
    }
    
    func findIndexOfArry(arrayNumber: NSArray, dataNumber: Int) -> Int {
        var index = 0
        for var i: Int = 0; i < arrayNumber.count; i++ {
            let currentInt: Int = arrayNumber[i] as! Int
            
            if dataNumber == currentInt {
                index = i
            }
        }
        
        return index
    }
    
    func changeBackgroundButton(mode: String, index: Int) {
        let button = getButtonUI(index)
        
        var image: String = ""
        if mode == "FINGER" {
            image = fingerImage
        }else if mode == "BROKEN" {
            image = brokenImage
            button.enabled = false
        }
        
        print("Button Mode = \(mode)")
        print("Image = \(image)")
        
        button.setBackgroundImage(UIImage(named: image), forState: UIControlState.Normal)
    }
    
    func getButtonUI(index: Int) -> UIButton {
        var buttonUI = UIButton()
        
        if index == 0 {
            buttonUI = button00
        }else if index == 1 {
            buttonUI = button01
        }else if index == 2 {
            buttonUI = button02
        }else if index == 3 {
            buttonUI = button03
        }else if index == 4 {
            buttonUI = button04
        }else if index == 5 {
            buttonUI = button05
        }else if index == 6 {
            buttonUI = button06
        }else if index == 7 {
            buttonUI = button07
        }else if index == 8 {
            buttonUI = button08
        }else if index == 9 {
            buttonUI = button09
        }
        return buttonUI
    }
    
    func playSound() {
        
        let resourcePath = NSBundle.mainBundle().URLForResource("click", withExtension: "WAV")
        
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
    }
    
    
    func resetState() {
        for var i: Int = 0; i < defind.datas.defaultNumber.count; i++ {
            let button = getButtonUI(i)
            button.enabled = true
            button.setBackgroundImage(UIImage(named: ""), forState: UIControlState.Normal)
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
    }
}
