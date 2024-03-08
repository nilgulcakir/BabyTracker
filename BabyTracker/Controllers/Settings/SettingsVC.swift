
import UIKit
import SnapKit
import RevenueCat
import SafariServices

class SettingsVC: UIViewController {
 
    let backButton = UIButton()
    let premiumButton = UIButton()
    let titleLabel = UILabel()
    let rateUsButton = CustomSettingsButton(image:"rate", labelText: "Rate Us")
    let contactButton = CustomSettingsButton(image: "contact", labelText: "Contact Us")
    let termsOfUseButton = CustomSettingsButton(image: "terms", labelText: "Terms of Use")
    let privacyButton = CustomSettingsButton(image: "privacy", labelText: "Privacy Policy")
    let restoreButton = CustomSettingsButton(image:  "restore", labelText: "Restore Purchase")

    override func viewDidLoad() {
        super.viewDidLoad()
        constraintSetup()
        checkPremiumStatus()
    }

    func constraintSetup(){
        view.backgroundColor = .systemBackground

        titleLabel.text = "Settings"
        titleLabel.font = .boldSystemFont(ofSize: 27)
        titleLabel.textColor = UIColor(red: 0.275, green: 0.147, blue: 0.767, alpha: 1)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(9)
            make.centerX.equalToSuperview()
        }
      
        backButton.setImage(UIImage(named: "back btn"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.leading.equalTo(titleLabel.snp.leading).inset(-120)
            make.width.height.equalTo(50)
        }
    
        premiumButton.setImage(UIImage(named: "Frame"), for: .normal)
        premiumButton.addTarget(self, action: #selector(GetPremium), for: .touchUpInside)
        view.addSubview(premiumButton)
        premiumButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(28)
            make.height.equalTo(80)
        }

        rateUsButton.backgroundColor = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
        rateUsButton.layer.cornerRadius = 25
        rateUsButton.addTarget(self, action: #selector(rateUsButtonClicked), for: .touchUpInside)
        view.addSubview(rateUsButton)
        rateUsButton.snp.makeConstraints { make in
            make.top.equalTo(premiumButton.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(28)
            make.height.equalTo(60)
        }
        
        termsOfUseButton.backgroundColor = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
        termsOfUseButton.layer.cornerRadius = 25
        termsOfUseButton.addTarget(self, action: #selector(termsOfUseButtonClicked), for: .touchUpInside)
        view.addSubview(termsOfUseButton)
        termsOfUseButton.snp.makeConstraints { make in
            make.top.equalTo(rateUsButton.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(28)
            make.height.equalTo(60)
        }
        
        privacyButton.backgroundColor = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
        privacyButton.layer.cornerRadius = 25
        privacyButton.addTarget(self, action: #selector(privacyButtonClicked), for: .touchUpInside)
        view.addSubview(privacyButton)
        privacyButton.snp.makeConstraints { make in
            make.top.equalTo(termsOfUseButton.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(28)
            make.height.equalTo(60)
        }

        contactButton.backgroundColor = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
        contactButton.layer.cornerRadius = 25
        contactButton.addTarget(self, action: #selector(contactButtonClicked), for: .touchUpInside)
        view.addSubview(contactButton)
        contactButton.snp.makeConstraints { make in
            make.top.equalTo(privacyButton.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(28)
            make.height.equalTo(60)
        }

        restoreButton.backgroundColor = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
        restoreButton.layer.cornerRadius = 25
        restoreButton.addTarget(self, action: #selector(restoreButtonClicked), for: .touchUpInside)
        view.addSubview(restoreButton)
        restoreButton.snp.makeConstraints { make in
            make.top.equalTo(contactButton.snp.bottom).offset(20)
            make.leading.right.equalToSuperview().inset(28)
            make.height.equalTo(60)
        }
    }
    func checkPremiumStatus() {
        Purchases.shared.getCustomerInfo { [weak self] info, error in
            guard let info = info, error == nil else {
                return
            }
            DispatchQueue.main.async {
                if info.entitlements.all["Monthly"]?.isActive == true {
                    self?.premiumButton.isHidden = true
                    self?.rateUsButton.snp.remakeConstraints { make in
                        make.top.equalTo((self?.titleLabel.snp.bottom)!).offset(30)
                        make.centerX.equalToSuperview()
                        make.left.right.equalToSuperview().inset(28)
                        make.height.equalTo(60)
                    }
                    self?.restoreButton.isHidden = true
                } else {
                    self?.restoreButton.isHidden = false
                }
            }
        }
    }
    @objc func rateUsButtonClicked() {
        openURL("https://neonapps.co/")
    }
    
    @objc func termsOfUseButtonClicked() {
        openURL("https://neonapps.co/")
    }
    
    @objc func privacyButtonClicked() {
        openURL("https://neonapps.co/")
    }
    
    @objc func contactButtonClicked() {
        openURL("https://neonapps.co/")
    }
    
    @objc func restoreButtonClicked() {
        openURL("https://neonapps.co/")
    }
    @objc func backButtonClicked() {
        let homeVC = HomeViewController()
        homeVC.modalPresentationStyle = .fullScreen
        self.present(homeVC, animated: true, completion: nil)
    }
    
    @objc func GetPremium(){
        let paywallVC = InAppVC()
        paywallVC.modalPresentationStyle = .fullScreen
        self.present(paywallVC, animated: true, completion: nil)
    }
    
    private func openURL(_ urlString: String) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

