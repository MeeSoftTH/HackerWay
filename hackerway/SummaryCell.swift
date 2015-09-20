//
//  SummaryCell.swift
//  hackerway
//
//  Created by Pawarit Bunrith on 9/18/2558 BE.
//  Copyright © 2558 Pawarit Bunrith. All rights reserved.
//

import UIKit

class SummaryCell: UITableViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var index1: UILabel!
    @IBOutlet var index2: UILabel!
    @IBOutlet var index3: UILabel!
    @IBOutlet var index4: UILabel!
    
    func setCell(title: String, indexData1: Int, indexData2: Int, indexData3: Int, indexData4: Int) {
        
        var tempdata1 = indexData1
        var tempdata2 = indexData2
        var tempdata3 = indexData3
        var tempdata4 = indexData4
        
        if title == "Correct" {
            self.title.textColor = UIColor.blueColor()
        }else {
            self.title.textColor = UIColor.blackColor()
        }
        
        if indexData1 >= 10 {
            self.index1.textColor = UIColor.blueColor()
            tempdata1 = indexData1 - 10
        }else {
            self.index1.textColor = UIColor.blackColor()
        }
        
        if indexData2 >= 10 {
            self.index2.textColor = UIColor.blueColor()
            tempdata2 = indexData2 - 10
        }else {
            self.index2.textColor = UIColor.blackColor()
        }
        
        if indexData3 >= 10 {
            self.index3.textColor = UIColor.blueColor()
            tempdata3 = indexData3 - 10
        }else {
            self.index3.textColor = UIColor.blackColor()
        }
        
        if indexData4 >= 10 {
            self.index4.textColor = UIColor.blueColor()
            tempdata4 = indexData4 - 10
        }else {
            self.index4.textColor = UIColor.blackColor()
        }
        
        self.title.text = title
        
        self.index1.text = String(tempdata1)
        self.index2.text = String(tempdata2)
        self.index3.text = String(tempdata3)
        self.index4.text = String(tempdata4)
        
    }
}