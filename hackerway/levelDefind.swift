//
//  levelDefind.swift
//  hackerway
//
//  Created by Pawarit Bunrith on 9/10/2558 BE.
//  Copyright (c) 2558 Pawarit Bunrith. All rights reserved.
//

import UIKit

class levelDefind {
    
    struct params{
        // Defind level [title(string), level(string), multiply(Int), strict(bool), arrayLength(Int), showfiger(bool), avalible button(default 10), shuffle button(bool)]
        static let level1 = ["Mission1", "หัดสังเกต", 1, true, 2, true, 10, false, "level1"] // index 0
        static let level2 = ["Mission2", "หัดสังเกต 2", 2, true, 3, true, 10, false, "level2"]
        static let level3 = ["Mission3", "หัดสังเกต 3", 3, true, 4, false, 10, false, "level3"]
        static let level4 = ["Mission4", "มีปุ่มเสียเยอะ", 4, true, 4, false, 4, false, "level4"]
        static let level5 = ["Mission5", "มีปุ่มเสียเยอะ 2", 5, true, 3, false, 4, false, "level5"]
        static let level6 = ["Mission6", "ซ้อม", 6, true, 5, false, 5, false, "level6"]
        static let level7 = ["Mission7", "ซ้อม 2", 7, true, 6, false, 6, false, "level7"]
        static let level8 = ["Mission8", "ซ้อม 3", 8, true, 7, false, 7, false, "level8"]
        static let level9 = ["Mission9", "Turn Pro", 9, true, 2, false, 10, false, "level9"]
        static let level10 = ["Mission10", "เริ่มงาน", 10, true, 4, false, 10, false, "level10"]
        
        static let level11 = ["Mission11", "งานเดิมๆ", 11, false, 4, false, 10, false, "level11"]
        static let level12 = ["Mission12", "งานเดิมๆ", 12, false, 4, false, 10, false, "level12"]
        static let level13 = ["Mission13", "งานเดิมๆ", 13, false, 4, false, 10, false, "level13"]
        static let level14 = ["Mission14", "งานเดิมๆ", 14, false, 4, false, 10, false, "level14"]
        
        static let level15 = ["Mission15", "งานยาก", 15, true, 4, true, 10, true, "level15"] // index 14
        
        
        static let levelList = [level1, level2, level3, level4, level5, level6, level7, level8, level9, level10, level11, level12, level13, level14, level15]
    }

}

