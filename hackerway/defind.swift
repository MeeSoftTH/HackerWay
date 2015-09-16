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
        static var keyPadViewActivate: updateLabelProtocal! = nil
        static var setKeyViewActivate: setKeyLabelProtocal! = nil
        static var currentView: String = ""
        
        static var deadCouter: Int = 10
        static var currentMissionTitle: String = ""
        static var currentMissionLabel: String = ""
        static var multi: Int = 1
        static var strict: Bool = false
        static var showFinger: Bool = false
        static var buttonOn: Int = 10
        static var isShuffle: Bool = false
        
        static var currentMultiply: Int = 1
        static var currentLevel: Int = 0
        
        static var currentMode: String = ""
        
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
