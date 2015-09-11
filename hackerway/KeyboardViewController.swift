//
//  KeyboardViewController.swift
//  hackerway
//
//  Created by Pawarit Bunrith on 9/7/2558 BE.
//  Copyright (c) 2558 Pawarit Bunrith. All rights reserved.
//

import UIKit

protocol keyPadProtocal {
    func keyPadIndex(index: Int)
}

class KeyboardViewController: UIViewController {
    
    var keyIndex: keyPadProtocal? = defind.variable.keyPadViewActivate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Controller = \(keyIndex)")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button0(sender: UIButton) {
        self.keyIndex?.keyPadIndex(0)
    }
    
    @IBAction func button1(sender: UIButton) {
        //println("Touched")
        self.keyIndex?.keyPadIndex(1)
    }
    
    @IBAction func button2(sender: UIButton) {
        self.keyIndex?.keyPadIndex(2)
    }
    
    @IBAction func button3(sender: UIButton) {
        self.keyIndex?.keyPadIndex(3)
    }
    
    @IBAction func button4(sender: UIButton) {
        self.keyIndex?.keyPadIndex(4)
    }
    
    @IBAction func button5(sender: UIButton) {
        self.keyIndex?.keyPadIndex(5)
    }
    
    @IBAction func button6(sender: UIButton) {
        self.keyIndex?.keyPadIndex(6)
    }
    
    @IBAction func button7(sender: UIButton) {
        self.keyIndex?.keyPadIndex(7)
    }
    
    @IBAction func button8(sender: UIButton) {
        self.keyIndex?.keyPadIndex(8)
    }
    
    @IBAction func button9(sender: UIButton) {
        self.keyIndex?.keyPadIndex(9)
    }
    
    @IBAction func buttonStar(sender: UIButton) {
        self.keyIndex?.keyPadIndex(10)
    }
    
    @IBAction func buttonSharp(sender: UIButton) {
        self.keyIndex?.keyPadIndex(11)
    }
    

}
