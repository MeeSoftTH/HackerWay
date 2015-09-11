//
//  MenuViewController
//  hackerway
//
//  Created by Pawarit Bunrith on 8/31/2558 BE.
//  Copyright (c) 2558 Pawarit Bunrith. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet var score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        score.text = getScore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func storyButton(sender: UIButton) {
        var vc = self.storyboard?.instantiateViewControllerWithIdentifier("gamingController") as! GameViewController
        vc.mode = "STORY"
        defind.variable.keyPadViewActivate = vc
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func challengeButton(sender: UIButton) {
        
        var vc = self.storyboard?.instantiateViewControllerWithIdentifier("setKey") as!SetKeyViewController
        defind.variable.keyPadViewActivate = vc
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func getScore()-> String {
        let userSetting: NSUserDefaults! = NSUserDefaults.standardUserDefaults()
        let hightScore = userSetting.integerForKey("hiscore")
        var scoreLabel: String = "Hight score : \(String(hightScore))"
        
        return scoreLabel
    }
}

