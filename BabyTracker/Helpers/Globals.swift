//
//  Globals.swift
//  BabyTracker
//
//  Created by Nilgul Cakir on 18.01.2024.
//

import Foundation
import FirebaseAuth
import Firebase

class Globals {
    
    static let shared = Globals()
    var selectedItem = [Symptoms]()
    var allStatus = [BabyFeel]()
    var userID = ""
}
