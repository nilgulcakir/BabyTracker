//
//  SymptomsVC.swift
//  BabyTracker
//
//  Created by Nilgul Cakir on 17.01.2024.
//

import UIKit
import Lottie

class SymptomsVC: UIViewController {

    let firstTextField = UITextField()
    let secondTextField = UITextField()
    let textView = UITextView()
    let time = Date()
    let formatter = DateFormatter()
    let timePicker = UIDatePicker()
    let lottie = LottieAnimationView()
    var customView: CustomFeedController!

    override func viewDidLoad() {
        super.viewDidLoad()
        constraintSetup()
        timePickers()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        addedSelectedSymptoms()
    }
    func constraintSetup() {
        view.backgroundColor = .systemBackground

        customView = CustomFeedController(title: "Symptoms", textFieldPlaceHolderOne: "Time", textFieldPlaceHolderSecond: "Symptoms", textFieldOne: firstTextField, textFieldSecond: secondTextField,textViewLabel: "Note",textViewCustom: textView)
        customView.button.isHidden = false
        customView.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        customView.button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        customView.saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        view.addSubview(customView)
        customView.snp.makeConstraints({ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.height)
        })
    }

    func timePickers() {
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm a"
        firstTextField.text = formatter.string(from: time)
    }
    func addedSelectedSymptoms() {
        for (index, x) in Globals.shared.selectedItem.enumerated() {
            customView.textFieldValue.text?.append(x.title)
            
            if index < Globals.shared.selectedItem.count - 1 {
                customView.textFieldValue.text?.append(", ")
            }
        }
    }
    @objc func backButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func buttonClicked() {
        let symptompsVC = NextSymptomsVC()
        symptompsVC.modalPresentationStyle = .fullScreen
        self.present(symptompsVC, animated: true, completion: nil)
    }
    
    @objc func saveButtonClicked() {
        guard let time = firstTextField.text,
              let symptom = secondTextField.text,
              let note = textView.text else { return }
        
        FirebaseManager.uploadBabyValue(userId: Globals.shared.userID, timeOne: time, time: symptom, note: note, image: "orangeSymptomps", type: "symptoms") { [self] success in
            
            if success {
                view.blurEffects(lottie: lottie)
                lottie.play(completion: { [weak self] finished in
                    guard let self = self, finished else { return }
                    self.dismiss(animated: true)
                })
            } else {
                print("Failed to upload data.")
            }
        }
    }
}




