//
//  SleepVC.swift
//  BabyTracker
//
//  Created by Nilgul Cakir on 17.01.2024.
//

import UIKit
import Lottie

class SleepVC: UIViewController {

    let firstTextField = UITextField()
    let secondTextField = UITextField()
    let textView = UITextView()
    let timePicker = UIDatePicker()
    let wokeUpPicker = UIDatePicker()
    let formatter = DateFormatter()
    var customView: CustomFeedController!
    let lottie = LottieAnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        constraintSetup()
    }

    func dateFormatter() {
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm a"
    }
    func constraintSetup(){
        view.backgroundColor = .systemBackground

        customView = CustomFeedController(title: "Sleep", textFieldPlaceHolderOne: "Fell Sleep", textFieldPlaceHolderSecond: "Woke Up", textFieldOne: firstTextField, textFieldSecond: secondTextField,textViewLabel: "Note",textViewCustom: textView)
        customView.button.isHidden = true
        customView.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        customView.saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        view.addSubview(customView)
        customView.snp.makeConstraints({ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.height)
        })

        timePicker.datePickerMode = .time
        timePicker.backgroundColor = .clear
        firstTextField.inputView = timePicker
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.frame.size = CGSize(width: 0, height: 250)
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: .valueChanged)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([doneButton, flexSpace], animated: true)
        firstTextField.inputAccessoryView = toolBar

        wokeUpPicker.datePickerMode = .time
        wokeUpPicker.backgroundColor = .clear
        wokeUpPicker.preferredDatePickerStyle = .wheels
        secondTextField.inputView = wokeUpPicker
        wokeUpPicker.frame.size = CGSize(width: 0, height: 250)
        secondTextField.inputAccessoryView = toolBar
        wokeUpPicker.addTarget(self, action: #selector(wokeUpPickerValueChanged(sender:)), for: .valueChanged)
    }
    
    @objc func doneClicked(){
        view.endEditing(true)
    }
    
    @objc func backButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func timePickerValueChanged(sender : UIDatePicker) {
        dateFormatter()
        firstTextField.text = formatter.string(from: sender.date)
        view.endEditing(true)
    }
    @objc func wokeUpPickerValueChanged(sender: UIDatePicker) {
        dateFormatter()
        secondTextField.text = formatter.string(from: sender.date)
        view.endEditing(true)
    }
    
    @objc func saveButtonClicked() {
        
        guard let fellSleep = firstTextField.text,
              let wokeUp = secondTextField.text,
              let note = textView.text else { return }
        
        FirebaseManager.uploadBabyValue(userId: Globals.shared.userID, timeOne: fellSleep, time: wokeUp, note: note, image: "purpleSleep", type: "sleep") { [self] success in
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


