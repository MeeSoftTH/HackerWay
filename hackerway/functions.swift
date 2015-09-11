//
//  functions.swift
//  hackerway
//
//  Created by Pawarit Bunrith on 9/7/2558 BE.
//  Copyright (c) 2558 Pawarit Bunrith. All rights reserved.
//

import UIKit

class functions {
    
    func createMission() {
        // defind datas
        var randomNumber = [Int]()
        let currentData = getLevelDatas()
        var defaultNumber = defind.datas.defaultNumber
        
        println("Array Datas = \(currentData)")
        
        let title: String = currentData[0] as! String
        let label: String = currentData[1] as! String
        let multi: Int = currentData[2] as! Int
        let strict: Bool = currentData[3] as! Bool
        let randomLength: Int = currentData[4] as! Int
        let isFinger: Bool = currentData[5] as! Bool
        let buttonOn: Int = currentData[6] as! Int
        let isShuffle: Bool = currentData[7] as! Bool
        
        //defind label
        defind.variable.currentMissionTitle = title
        defind.variable.currentMissionLabel = label
        
        for var i: Int = 0; i < randomLength; i++ {
            let randomArray = Int(arc4random_uniform(UInt32(defaultNumber.count)))
            let newData = defaultNumber[randomArray]
            
            if strict == true {
                let indexOfArray = findIndexOfArry(defaultNumber, dataNumber: newData)
                defaultNumber.removeAtIndex(indexOfArray)
            }
            
            randomNumber.append(newData)
        }
        
        if randomLength < 4 {
            let loopTurn: Int = 4 - randomLength
            
            for var i: Int = 0; i < loopTurn; i++ {
                let randomArray = Int(arc4random_uniform(UInt32(randomNumber.count)))
                let newData = randomNumber[randomArray]
                randomNumber.append(newData)
                println("Fill int = \(randomNumber)")
            }
        }
        
        // Convert In to String and save to global datas
        defind.datas.storyKey = [String]()
        
        for var i: Int = 0; i < 4; i++ {
            let randomArray2 = Int(arc4random_uniform(UInt32(randomNumber.count)))
            let newData2 = randomNumber[randomArray2]
            defind.datas.storyKey.append(String(newData2))
            println("Push data = \(newData2)")
            let indexOfArray = findIndexOfArry(randomNumber, dataNumber: newData2)
            randomNumber.removeAtIndex(indexOfArray)
        }
        println("Mission created = \(defind.datas.storyKey)")
    }
    
    func findIndexOfArry(arrayNumber: NSArray, dataNumber: Int) -> Int {
        var index = 0
        for var i: Int = 0; i < arrayNumber.count; i++ {
            var currentInt: Int = arrayNumber[i] as! Int
            
            if dataNumber == currentInt {
                index = i
            }
        }
        
        return index
    }
    
    func getLevelDatas() -> NSArray{
        var data: NSArray = setData()
        return data
    }
    
    func checkCurrent()-> Int {
        var currentLevel = defind.variable.currentLevel
        return currentLevel
    }
    
    func setData() -> NSArray {
        var dataList = levelDefind.params.levelList
        var levelIndex: Int = checkCurrent()
        var data = dataList[levelIndex]
        
        return data
    }
    
    func randomIndex(end: Int, start: Int)-> Int {
        var randomNumber = arc4random_uniform(UInt32(end)) + UInt32(start)
        return Int(randomNumber)
    }
}
