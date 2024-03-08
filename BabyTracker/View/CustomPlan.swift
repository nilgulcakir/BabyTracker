//
//  CustomPlan.swift
//  BabyTracker
//
//  Created by Nilgul Cakir on 17.01.2024.
//

import Foundation
import UIKit


class CustomPlanLabel : UILabel {
    init(title: String) {
        super.init(frame: .zero)
        configureUI(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureUI(title: String) {
        text = title
        font = .systemFont(ofSize: 16)
        textColor = .black
        sizeToFit()
    }
}

class PlanTitleCustomView: UIView {
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {

        let imageOne = UIImageView()
        imageOne.image = UIImage(named: "btn")
        addSubview(imageOne)
        imageOne.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.height.equalTo(40)
        }

        let imageTwo = UIImageView()
        imageTwo.image = UIImage(named: "btn")
        addSubview(imageTwo)
        imageTwo.snp.makeConstraints { make in
            make.top.equalTo(imageOne.snp.bottom)
            make.width.height.equalTo(40)
        }

        let imageTherd = UIImageView()
        imageTherd.image = UIImage(named: "btn")
        addSubview(imageTherd)
        imageTherd.snp.makeConstraints { make in
            make.top.equalTo(imageTwo.snp.bottom)
            make.width.height.equalTo(40)
        }

        let titleOne = CustomPlanLabel(title: "Share the care")
        addSubview(titleOne)
        titleOne.snp.makeConstraints { make in
            make.centerY.equalTo(imageOne.snp.centerY)
            make.left.equalTo(imageOne.snp.right)
        }

        let titleTwo = CustomPlanLabel(title: "All-in-one baby tracke")
        addSubview(titleTwo)
        titleTwo.snp.makeConstraints { make in
            make.centerY.equalTo(imageTwo.snp.centerY)
            make.left.equalTo(imageTwo.snp.right)
        }

        let titleThird = CustomPlanLabel(title: "Watch your babys growth")
        addSubview(titleThird)
        titleThird.snp.makeConstraints { make in
            make.centerY.equalTo(imageTherd.snp.centerY)
            make.left.equalTo(imageTherd.snp.right)
        }
    }
}
