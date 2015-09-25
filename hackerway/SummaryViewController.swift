//
//  SummaryViewController.swift
//  hackerway
//
//  Created by Pawarit Bunrith on 9/25/2558 BE.
//  Copyright © 2558 Pawarit Bunrith. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var myTableView: UITableView!
    var arryOfDatas:[SummaryData] = [SummaryData]()
    var summaryDic = [String: [Int]]()
    
    @IBOutlet var answer: UILabel!
    @IBOutlet var nosummary: UILabel!
    
    var mode: String = defind.variable.currentMode
    var gameMode = "STORY"
    var challengeMode = "CHALLENGE"
    var randomMode = "RANDOM"
    
    var answerKey = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var key = answerKey
        
        if self.mode == self.challengeMode {
            key = defind.datas.challengeKey
        }
        
        answer.text = "Answer is \(String(key[0]))\(String(key[1]))\(String(key[2]))\(String(key[3]))"
        
        if summaryDic .count > 0 {
            setUpDatas()
            
        }else{
            myTableView.hidden = true
            nosummary.hidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exit(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setUpDatas() {
        
        for var index: Int = 0; index < summaryDic.count; index++ {
            let keyDic = String(index + 1)
            
            if summaryDic[keyDic] != nil && summaryDic[keyDic]?.count == 4{
                var myArary = summaryDic[keyDic]!
                
                let dataSet = SummaryData(title: "Turn \(keyDic)", index1: myArary[0], index2: myArary[1], index3: myArary[2], index4: myArary[3])
                
                arryOfDatas.append(dataSet)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arryOfDatas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SummaryCell = tableView.dequeueReusableCellWithIdentifier("cell") as! SummaryCell
        
        let summaryDatas = arryOfDatas[indexPath.row]
        
        cell.setCell(summaryDatas.title, indexData1: summaryDatas.index1, indexData2: summaryDatas.index2, indexData3: summaryDatas.index3, indexData4: summaryDatas.index4)
        
        return cell
    }
}
