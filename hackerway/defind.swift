//
//  defind.swift
//  hackerway
//
//  Created by Pawarit Bunrith on 9/7/2558 BE.
//  Copyright (c) 2558 Pawarit Bunrith. All rights reserved.
//

import UIKit

class defind {
    
    struct variable {
        static var keyPadViewActivate: keyPadProtocal! = GameViewController()
        
        static var deadCouter: Int = 10
        static var currentMissionTitle: String = ""
        static var currentMissionLabel: String = ""
        static var currentMultiply: Int = 1
        static var currentLevel: Int = 0
        static let challengeTitle = "Challenge mode"
        static let challengeLabel = ""
    }
    
    struct datas {
        static var hightScore = 0
        static let defaultNumber = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        static var storyKey = [String]()
        static var challengeKey = [String]()
    }
}
