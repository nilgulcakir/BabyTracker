//
//  FeedVC.swift
//  BabyTracker
//
//  Created by Nilgul Cakir on 17.01.2024.
//

import UIKit
import Lottie

class FeedVC: UIViewController {

    let firstTextField = UITextField()
    let secondTextField = UITextField()
    let textView = UITextView()
    let formatter = DateFormatter()
    let timePicker = UIDatePicker()
    var customView: CustomFeedController!
    let lottie = LottieAnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        constraintSetup()
    }
    func constraintSetup(){
        view.backgroundColor = .systemBackground

        customView = CustomFeedController(title: "Feeding", textFieldPlaceHolderOne: "Time", textFieldPlaceHolderSecond: "Amount (ml)", textFieldOne: firstTextField, textFieldSecond: secondTextField,textViewLabel: "Note",textViewCustom: textView)
        customView.saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        customView.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        customView.button.isHidden = true
        view.addSubview(customView)
        customView.snp.makeConstraints({ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.height)
        })

        timePicker.datePickerMode = .time
        timePicker.backgroundColor = .clear
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.frame.size = CGSize(width: 0, height: 250)
        firstTextField.inputView = timePicker
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender: )), for: .valueChanged)

        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([doneButton, flexSpace], animated: true)
        firstTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneClicked(){
        view.endEditing(true)
    }
    
    @objc func backButtonClicked() {
        dismiss(animated: true)
    }
    @objc func timePickerValueChanged(sender : UIDatePicker) {
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm a"
        firstTextField.text = formatter.string(from: sender.date)
        view.endEditing(true)
    }
    
    @objc func saveButtonClicked() {
        
        guard let time = firstTextField.text,
              let amount = secondTextField.text,
              let note = textView.text else { return }
        
        FirebaseManager.uploadBabyValue(userId: Globals.shared.userID, timeOne: time, time: amount, note: note, image: "purpleFeed", type: "feeding") { [self] success in
            
            if success {
                view.blurEffects(lottie: lottie)
                self.lottie.play(completion: { [weak self] finished in
                    guard let self = self, finished else { return }
                    self.dismiss(animated: true)
                })
            } else {
                print("Failed to upload data.")
            }
        }
    }
}
