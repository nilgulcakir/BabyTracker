//
//  CustomFeedController.swift
//  BabyTracker
//
//  Created by Nilgul Cakir on 17.01.2024.
//

import Foundation
import UIKit
import SnapKit

class CustomFeedController: UIView {

    let backButton = UIButton()
    let titleLabel = UILabel()
    var textFieldTime = UITextField()
    var textFieldValue = UITextField()
    var textView = UITextView()
    var saveButton = CustomButton(title: "Save")
    let button = UIButton()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String,textFieldPlaceHolderOne: String,textFieldPlaceHolderSecond: String,textFieldOne: UITextField,textFieldSecond: UITextField,textViewLabel: String,textViewCustom: UITextView) {
        super.init(frame: .zero)
        constraintSetup(titleLabels: title, textFieldTimePlaceHolder: textFieldPlaceHolderOne, textFieldValuePlaceHolder: textFieldPlaceHolderSecond, textFieldOne: textFieldOne, textFieldSecond: textFieldSecond,textViewLabel: textViewLabel,textViewCustom: textViewCustom)
    }

    func constraintSetup(titleLabels: String,textFieldTimePlaceHolder: String,textFieldValuePlaceHolder: String,textFieldOne: UITextField,textFieldSecond: UITextField,textViewLabel: String,textViewCustom: UITextView) {
        backgroundColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 27)
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor(red: 0.275, green: 0.147, blue: 0.767, alpha: 1)
        titleLabel.text = titleLabels
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.centerX.equalToSuperview()
        }

        backButton.setImage(UIImage(named: "back btn"), for: .normal)
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.height.equalTo(50)
        }

        textFieldTime = textFieldOne
        textFieldTime.placeholder = textFieldTimePlaceHolder
        textFieldTime.backgroundColor = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
        textFieldTime.layer.cornerRadius = 25
        textFieldTime.leftViewMode = .always
        textFieldTime.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        addSubview(textFieldTime)
        textFieldTime.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(60)
        }
        
        textFieldValue = textFieldSecond
        textFieldValue.placeholder = textFieldValuePlaceHolder
        textFieldValue.backgroundColor = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
        textFieldValue.layer.cornerRadius = 25
        textFieldValue.leftViewMode = .always
        textFieldValue.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        addSubview(textFieldValue)
        textFieldValue.snp.makeConstraints { make in
            make.top.equalTo(textFieldTime.snp.bottom).offset(29)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(60)
        }

        button.setImage(.next, for: .normal)
        addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(textFieldTime.snp.bottom).offset(35)
            make.right.equalToSuperview().offset(-36)
            make.width.height.equalTo(50)
        }
        
        textView = textViewCustom
        textView.backgroundColor = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
        textView.layer.cornerRadius = 18
        textView.font = .systemFont(ofSize: 15)
        textView.textAlignment = .left
        addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalTo(textFieldValue.snp.bottom).offset(29)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(264)
        }
        
        addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(70)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(64)
        }
    }
}
