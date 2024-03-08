//
//  BabyStatus.swift
//  BabyTracker
//
//  Created by Nilgul Cakir on 18.01.2024.
//

import Foundation

struct BabyFeel {
    let id: String
    let timeOne: String
    let time: String
    let note: String
    let image: String
    let type: String
}
enum IllnessType : String {
    case all = "all"
    case feeding = "feed"
    case sleep = "sleep"
    case symptoms = "symptoms"
}
