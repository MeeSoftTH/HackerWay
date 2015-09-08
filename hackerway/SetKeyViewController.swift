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

    func addLabel(index: String) {
        
        if box1.text == "" {
            box1.text = index
        }else if box2.text == "" {
            box2.text = index
        }else if box3.text == "" {
            box3.text = index
        }else if box4.text == "" {
            box4.text = index
        }
    }
    
    func keyPadIndex(index: Int){
        
        println("index is = \(index)")
        
        var addText = String(index)
        
        if index == 11 {
            addText = "*"
        }else if index == 12 {
            addText = "#"
        }else if index == 10 {
            addText = "0"
        }
        
        self.addLabel(addText)
    }

}
