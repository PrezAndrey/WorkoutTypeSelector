//
//  WorkoutType.swift
//  WorkoutTypePicker
//
//  Created by Андрей  on 24.03.2022.
//

import Foundation

enum WKType: String {
    case aerobic = "aerobic"
    case anaerobic = "anaerobic"
    case mixed = "mixed"
}

struct WorkoutType {
    
    var name: String
    var type: WKType
    
    
}
