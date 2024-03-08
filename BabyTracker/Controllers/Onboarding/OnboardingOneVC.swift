import UIKit

class OnboardingOneVC: UIViewController {

    let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        constraintSetup()
        UserDefaults.standard.set(false, forKey: "Value")
    }

    func constraintSetup() {
        view.backgroundColor = .white

        let imageView = UIImageView()
        imageView.image = UIImage(named: "onboardingOne")
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5 * view.bounds.height)
        }
        let customView = UIView()
        customView.backgroundColor = .white
        customView.layer.cornerRadius = 30
        customView.clipsToBounds = true
        view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(0.6 * view.bounds.height)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Track Your Baby's Activities with Ease"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textColor = .black
        customView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.right.left.equalToSuperview().inset(60)
        }

        let descriptionsLabel = UILabel()
        descriptionsLabel.text = "Get started with tracking your baby's feedings, diaper changes, sleep patterns, and more..."
        descriptionsLabel.textAlignment = .center
        descriptionsLabel.numberOfLines = 0
        descriptionsLabel.font = .systemFont(ofSize: 17)
        descriptionsLabel.textColor = .black
        customView.addSubview(descriptionsLabel)
        descriptionsLabel.snp.makeConstraints { make in
            make.centerX.equalTo(titleLabel.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.right.left.equalToSuperview().inset(40)
        }

        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor =  UIColor(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 20
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        customView.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.layoutMarginsGuide).offset(-8)
            make.right.left.equalToSuperview().inset(27)
            make.height.equalTo(64)
        }

        let sliderImageView = UIImageView()
        sliderImageView.image = UIImage(named: "img_slider1")
        customView.addSubview(sliderImageView)
        sliderImageView.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.top).offset(-40)
            make.centerX.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(3)
        }
    }
    @objc func nextButtonClicked() {
        let secondVC = OnboardingTwoVC()
        secondVC.modalPresentationStyle = .fullScreen
        self.present(secondVC, animated: true, completion: nil)
    }
}

