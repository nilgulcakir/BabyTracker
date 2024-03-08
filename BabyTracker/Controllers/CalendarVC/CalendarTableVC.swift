//
//  CalendarTableVC.swift
//  BabyTracker
//
//  Created by Nilgul Cakir on 18.01.2024.
//

import UIKit

class CalendarTableVC: UITableViewCell {

    let titleLabel = UILabel()
    let timeLabel = UILabel()
    let customView = UIView()
    let imageViews = UIImageView()
    let note = UILabel()
    static let identifier = "tableCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureUI()
    }
    
    func configure(with data: BabyFeel) {
        timeLabel.text = data.timeOne
        titleLabel.text = data.note
        note.text = data.time
        imageViews.image = UIImage(named: data.image)
    }
    
    func configureUI() {

        contentView.layer.cornerRadius = 25
        contentView.backgroundColor = .clear
        customView.layer.cornerRadius = 25
        customView.backgroundColor = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
        contentView.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.top.bottom.equalToSuperview().inset(8)
        }

        customView.addSubview(imageViews)
        imageViews.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(3)
            make.width.height.equalTo(50)
        }

        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor(red: 0.275, green: 0.147, blue: 0.767, alpha: 1)
        customView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(imageViews.snp.right).offset(5)
        }

        timeLabel.sizeToFit()
        timeLabel.textColor = UIColor(red: 0.004, green: 0.004, blue: 0.004, alpha: 1)
        timeLabel.font = .systemFont(ofSize: 16)
        customView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-23)
        }
    }
}
