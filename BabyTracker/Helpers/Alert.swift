//
//  Helpers.swift
//  BabyTracker
//
//  Created by Nilgul Cakir on 18.01.2024.
//

import Foundation
import UIKit

class Alerts {
    
    static func alertAction(title: String,message: String,vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        vc.present(alert, animated: true)
    }
}
