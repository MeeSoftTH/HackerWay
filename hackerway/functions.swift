//
//  functions.swift
//  hackerway
//
//  Created by Pawarit Bunrith on 9/7/2558 BE.
//  Copyright (c) 2558 Pawarit Bunrith. All rights reserved.
//

import UIKit

class functions {
    
    func mission() {
        
        if defind.variable.missionNo == 1 {
            defind.variable.strAns = [String]()
            for var i: Int = 0; i < 2; i++ {
                var randomAnswer = randomIndex(12, start:1)
                defind.variable.intAns.append(randomAnswer)
            }
            
            for var i: Int = 1; i < 5; i++ {
                var randomAgain = Int(arc4random_uniform(UInt32(defind.variable.intAns.count)))
                
                if defind.variable.intAns[randomAgain] == 11 {
                    defind.variable.strAns.append("*")
                }else if defind.variable.intAns[randomAgain] == 12 {
                    defind.variable.strAns.append("#")
                }else if defind.variable.intAns[randomAgain] == 10 {
                    defind.variable.strAns.append("0")
                }else {
                    defind.variable.strAns.append(String(defind.variable.intAns[randomAgain]))
                }
            }
            
            println("Summary Ans = \(defind.variable.strAns)")
        }
    }
    
    func randomIndex(end: Int, start: Int)-> Int {
        var randomNumber = arc4random_uniform(UInt32(end)) + UInt32(start)
        return Int(randomNumber)
    }
    
}
