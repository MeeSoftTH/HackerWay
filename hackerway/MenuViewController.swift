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
    
    var gameView: String = "GAMECONTROL"
    var setView: String = "SETKEY"
    
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
        defind.variable.currentMode = "STORY"
        
        var vc = self.storyboard?.instantiateViewControllerWithIdentifier("gamingController") as! GameViewController
        defind.variable.keyPadViewActivate = vc
        defind.variable.currentView = gameView
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func challengeButton(sender: UIButton) {
        defind.variable.currentMode = "CHALLENGE"
        defind.variable.currentView = setView
        var vc = self.storyboard?.instantiateViewControllerWithIdentifier("setKey") as! SetKeyViewController
        defind.variable.setKeyViewActivate = vc
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getScore()-> String {
        let userSetting: NSUserDefaults! = NSUserDefaults.standardUserDefaults()
        let hightScore = userSetting.integerForKey("hiscore")
        var scoreLabel: String = "Hight score : \(String(hightScore))"
        
        return scoreLabel
    }
}

