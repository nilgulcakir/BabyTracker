//
//  BabyTrackerManager.swift
//  BabyTracker
//
//  Created by Nilgul Cakir on 18.01.2024.
//

import Foundation
import UIKit
import Firebase
import Lottie
import FirebaseFirestore


class FirebaseManager {
    
    static func uploadBabyValue(userId: String, timeOne: String, time: String, note: String, image: String, type: String, completion: @escaping (Bool) -> Void) {
        
        let doctRef = Firestore.firestore().collection("babyFeel\(userId)").document()
        doctRef.setData([
            "timeOne": timeOne,
            "time": time,
            "note": note,
            "image": image,
            "type": type
        ]) { error in
            if let error = error {
                print("Error uploading data: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Data uploaded successfully")
                completion(true)
            }
        }
    }

    static func fetchBabyValue(userId: String,completion: @escaping()-> Void){
            let doctRef = Firestore.firestore().collection("babyFeel\(userId)")
            doctRef.getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    Globals.shared.allStatus.removeAll()
                    NotificationCenter.default.post(name: Notification.Name("baby"), object: nil)
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        let documentId = document.documentID
                        guard let timeOne = data["timeOne"] as? String ,
                              let time = data["time"] as? String,
                              let note = data["note"] as? String,
                              let image = data["image"] as? String,
                              let type = data["type"] as? String else{return}
                        let status = BabyFeel(id: documentId, timeOne: timeOne, time: time, note: note, image: image, type: type)
                        
                        Globals.shared.allStatus.append(status)
                        completion()
                    }
                }
            }
        }
    
    static func deleteBabyValue(userId: String,documentId: String,completion: @escaping()-> Void){
        let collectionRef = Firestore.firestore().collection("babyFeel\(userId)")
        let doctRef = collectionRef.document(documentId)
        
        doctRef.delete { error in
            if let error = error {
                print("error : \(error.localizedDescription)")
            } else {
                print("deleted")
                completion()
            }
        }
    }
}
