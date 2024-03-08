//
//  SymptomsCollectionVC.swift
//  BabyTracker
//
//  Created by Nilgul Cakir on 18.01.2024.
//

import UIKit

class SymptomsCollectionVC: UICollectionViewCell {
    static let identifier = "cell"
    let imageView = UIImageView()
    var symptom: Symptoms!
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureUI() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
    }
}
