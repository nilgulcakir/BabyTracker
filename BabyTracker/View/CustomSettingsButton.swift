
import Foundation
import UIKit
import SnapKit

class CustomSettingsButton : UIButton {
    
    var image = UIImageView()
    var label = UILabel()
    var button = UIButton()
    
    init(image: String, labelText: String) {
        super.init(frame: .zero)
        configureUI(title: image,labels: labelText)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureUI(title: String, labels: String) {
        addSubview(image)
        image.image = UIImage(named: title)
        image.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(11)
            make.width.height.equalTo(50)
        }
    
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.text = labels
        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(image.snp.right).offset(4)
        }
        
        button.setImage(UIImage(named: "next"), for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        addSubview(button)
        button.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(13)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
    
    @objc func buttonClicked() {
        print("Butona tıklandı!")
    }
}
class CustomButton : UIButton {
    init(title: String) {
        super.init(frame: .zero)
        configureUI(titles: title)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureUI(titles: String) {
        let title = titles
        setTitle(title, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 20)
        backgroundColor = UIColor(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        layer.cornerRadius = 25
    }
}

