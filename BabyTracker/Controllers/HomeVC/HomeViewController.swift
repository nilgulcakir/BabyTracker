
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        constraintSetup()
        UserDefaults.standard.set(true, forKey: "Value")
    }
    override func viewWillAppear(_ animated: Bool) {
        Globals.shared.selectedItem.removeAll()
    }
    
    func constraintSetup(){
        view.backgroundColor = .white

        let settingsButton = UIButton()
        settingsButton.setImage(UIImage(named: "settings"), for: .normal)
        settingsButton.backgroundColor = .clear
        settingsButton.addTarget(self, action: #selector(settingsButtonClicked), for: .touchUpInside)
        view.addSubview(settingsButton)
        
        settingsButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(40)
        }

        let calendarButton = UIButton()
        calendarButton.setImage(UIImage(named: "calendar"), for: .normal)
        calendarButton.backgroundColor = .clear
        calendarButton.addTarget(self, action: #selector(calendarButtonClicked), for: .touchUpInside)
        view.addSubview(calendarButton)
        
        calendarButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(40)
        }

        let homeTitleLabel = UILabel()
        homeTitleLabel.text = "Home"
        homeTitleLabel.font = .systemFont(ofSize: 22)
        homeTitleLabel.textAlignment = .center
        view.addSubview(homeTitleLabel)
        
        homeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(9)
            make.centerX.equalToSuperview()
        }

        let feedButton = UIButton()
        feedButton.backgroundColor = .purple
        feedButton.setTitle("Feed", for: .normal)
        feedButton.setTitleColor(.white, for: .normal)
        feedButton.contentHorizontalAlignment = .left
        feedButton.backgroundColor = UIColor(red: 0.606, green: 0.392, blue: 1, alpha: 1)
        feedButton.layer.cornerRadius = 14
        feedButton.setImage(UIImage(named: "babybottle"), for: .normal)
        feedButton.addTarget(self, action: #selector(feedButtonClicked), for: .touchUpInside)
        view.addSubview(feedButton)
        
        feedButton.snp.makeConstraints { make in
            make.top.equalTo(homeTitleLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(22)
            make.height.equalTo(63)
        }

        let sleepButton = UIButton()
        sleepButton.backgroundColor = .blue
        sleepButton.setTitle("Sleep", for: .normal)
        sleepButton.setTitleColor(.white, for: .normal)
        sleepButton.contentHorizontalAlignment = .left
        sleepButton.backgroundColor = UIColor(red: 0.389, green: 0.354, blue: 1, alpha: 1)
        sleepButton.layer.cornerRadius = 14
        sleepButton.setImage(UIImage(named: "sleep"), for: .normal)
        sleepButton.addTarget(self, action: #selector(sleepButtonClicked), for: .touchUpInside)
        view.addSubview(sleepButton)
        
        sleepButton.snp.makeConstraints { make in
            make.top.equalTo(feedButton.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(22)
            make.height.equalTo(63)
        }

        let symptomsButton = UIButton()
        symptomsButton.backgroundColor = .orange
        symptomsButton.setTitle("Symptoms", for: .normal)
        symptomsButton.setTitleColor(.white, for: .normal)
        symptomsButton.contentHorizontalAlignment = .left
        symptomsButton.backgroundColor = UIColor(red: 1, green: 0.776, blue: 0.392, alpha: 1)
        symptomsButton.layer.cornerRadius = 14
        symptomsButton.setImage(UIImage(named: "symptoms"), for: .normal)
        symptomsButton.addTarget(self, action: #selector(symptomsButtonClicked), for: .touchUpInside)
        view.addSubview(symptomsButton)

        symptomsButton.snp.makeConstraints { make in
            make.top.equalTo(sleepButton.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(22)
            make.height.equalTo(63)
        }
    }
    @objc func settingsButtonClicked(){
        let settingsVC = SettingsVC()
        settingsVC.modalPresentationStyle = .fullScreen
        self.present(settingsVC, animated: true, completion: nil)
    }
    
    @objc func calendarButtonClicked(){
        if !Globals.shared.allStatus.isEmpty {
            FirebaseManager.fetchBabyValue(userId: Globals.shared.userID) { [self] in
                let calenderVC = CalendarVC()
                calenderVC.modalPresentationStyle = .fullScreen
                self.present(calenderVC, animated: true, completion: nil)
            }
        } else {
            let calenderVC = CalendarVC()
            calenderVC.modalPresentationStyle = .fullScreen
            self.present(calenderVC, animated: true, completion: nil)
        }
    }
    
    @objc func feedButtonClicked() {
        let feedVC = FeedVC()
        feedVC.modalPresentationStyle = .fullScreen
        self.present(feedVC, animated: true, completion: nil)
    }
    
    @objc func sleepButtonClicked() {
        let sleepVC = SleepVC()
        sleepVC.modalPresentationStyle = .fullScreen
        self.present(sleepVC, animated: true, completion: nil)
    }
    
    @objc func symptomsButtonClicked() {
        let symptompsVC = SymptomsVC()
        symptompsVC.modalPresentationStyle = .fullScreen
        self.present(symptompsVC, animated: true, completion: nil)
    }
}


 
