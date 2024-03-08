

import UIKit
import RevenueCat

class InAppVC: UIViewController {

    let backButton = UIButton()
    let startButton = CustomButton(title: "Start")
    let buyPremium = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        constraintSetup()
        arrangeSubscription()
    }
    func constraintSetup() {
        view.backgroundColor = .systemBackground
        
        backButton.setImage(UIImage(named: "exit"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-23)
            make.top.equalToSuperview().offset(50)
            make.width.height.equalTo(50)

        }
        
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-17)
            make.left.right.equalToSuperview().inset(26)
            make.height.equalTo(64)
        }

        buyPremium.backgroundColor = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
        buyPremium.layer.cornerRadius = 25
        view.addSubview(buyPremium)
        buyPremium.snp.makeConstraints { make in
            make.bottom.equalTo(startButton.snp.top).offset(-64)
            make.left.right.equalToSuperview().inset(27)
            make.height.equalTo(82)
        }
     
        let annualLabel = UILabel()
        annualLabel.text = "Annual"
        annualLabel.font = .boldSystemFont(ofSize: 18)
        annualLabel.sizeToFit()
        buyPremium.addSubview(annualLabel)
        annualLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(22)
            make.centerY.equalToSuperview()
        }
 
        let priceLabel = UILabel()
        priceLabel.text = "$30"
        priceLabel.font = .boldSystemFont(ofSize: 18)
        priceLabel.sizeToFit()
        buyPremium.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-22)
            make.centerY.equalToSuperview()
        }

        let imageViews = UIImageView()
        imageViews.image = UIImage(named: "premiumbaby")
        imageViews.contentMode = .scaleAspectFill
        view.addSubview(imageViews)
        imageViews.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(100)
            make.height.equalTo(0.2 * view.bounds.height)
        }

        let titleLabel = UILabel()
        titleLabel.text = "Get Premium!"
        titleLabel.font = .boldSystemFont(ofSize: 27)
        titleLabel.textColor = UIColor(red: 0.275, green: 0.147, blue: 0.767, alpha: 1)
        titleLabel.sizeToFit()
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageViews.snp.bottom).offset(44)
            make.centerX.equalToSuperview()
        }

        let planTitle = PlanTitleCustomView()
        view.addSubview(planTitle)
        planTitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.left.right.equalToSuperview().inset(85)
            make.height.equalTo(120)

        }
    }
    func arrangeSubscription() {
        Purchases.shared.getCustomerInfo { [weak self ] info, error in
            guard let info = info , error == nil else { return }
            
            
            if info.entitlements.all["Monthly"]?.isActive == true {
                DispatchQueue.main.async {
                    let homeVC = HomeViewController()
                    homeVC.modalPresentationStyle = .fullScreen
                    self?.present(homeVC, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    self?.startButton.isHidden = false
                }
            }
        }
    }
    
    func purchase(package: RevenueCat.Package) {
        Purchases.shared.purchase(package: package) { transection, info, error, userCancelled in
            guard let transection = transection , let info = info , error == nil , !userCancelled else { return }
            
            if info.entitlements.all["Monthly"]?.isActive == true {
                let homeVC = HomeViewController()
                homeVC.modalPresentationStyle = .fullScreen
                self.present(homeVC, animated: true, completion: nil)
            }
            print(transection.transactionIdentifier)
        }
    }
    func fetchOfferings(completion: @escaping (RevenueCat.Package)-> Void ) {
        Purchases.shared.getOfferings { offering, error in
            
            guard let offering = offering, error == nil else { return }
            guard let package = offering.all.first?.value.availablePackages.first else {
                return
            }
            completion(package)
        }
    }
    @objc func backButtonClicked() {
        let homeVC = HomeViewController()
        homeVC.modalPresentationStyle = .fullScreen
        self.present(homeVC, animated: true, completion: nil)
        
    }

    @objc func startButtonClicked() {
        fetchOfferings { package in
            self.purchase(package: package)
        }
    }
}


