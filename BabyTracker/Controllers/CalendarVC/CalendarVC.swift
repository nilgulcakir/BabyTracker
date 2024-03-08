//
//  CalendarVC.swift
//  BabyTracker
//
//  Created by Nilgul Cakir on 17.01.2024.
//

import UIKit
import Lottie

class CalendarVC: UIViewController {
    
    let backButton = UIButton()
    let allButton = UIButton()
    let sleepButton = UIButton()
    let feedingButton = UIButton()
    let symtomsButton = UIButton()
    let tableView = UITableView()
    var selectedEventType : IllnessType!
    let lottie = LottieAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constraintSetup()
        selectedEventType = .all

    }
    override func viewWillAppear(_ animated: Bool) {
        FirebaseManager.fetchBabyValue(userId: Globals.shared.userID) { [self] in
            tableView.reloadData()
        }
    }
    
    func dateFormat(completion: @escaping(String) -> Void) {
         let currentDate = Date()
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "EE MMM d"
         let formatDate = dateFormatter.string(from: currentDate)
         completion(formatDate)
     }
    
    func constraintSetup() {
        view.backgroundColor = .systemBackground

        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 27)
        titleLabel.sizeToFit()
        titleLabel.textColor = .purple
        titleLabel.text = "Calender"
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(9)
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

        let timeLabel = UILabel()
        dateFormat { value in
            timeLabel.text = value
        }
        
        timeLabel.textColor = UIColor(red: 0.004, green: 0.004, blue: 0.004, alpha: 1)
        timeLabel.font = .systemFont(ofSize: 20)
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        allButton.setTitle("All", for: .normal)
        allButton.setTitleColor(.purple, for: .normal)
        allButton.titleLabel?.font = UIFont.systemFont(ofSize: 27)
        allButton.addTarget(self, action: #selector(allButtonClicked), for: .touchUpInside)
        view.addSubview(allButton)
        allButton.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(75)
            make.width.equalTo(30)
            make.height.equalTo(20)
        }

        feedingButton.setImage(UIImage(named: "feed3"), for: .normal)
        feedingButton.addTarget(self, action: #selector(feedingButtonClicked), for: .touchUpInside)
        view.addSubview(feedingButton)
        feedingButton.snp.makeConstraints { make in
            make.left.equalTo(allButton.snp.right).offset(22)
            make.centerY.equalTo(allButton.snp.centerY)
            make.width.height.equalTo(50)
        }

        sleepButton.setImage(UIImage(named: "sleeping"), for: .normal)
        sleepButton.addTarget(self, action: #selector(sleepButtonClicked), for: .touchUpInside)
        view.addSubview(sleepButton)
        sleepButton.snp.makeConstraints { make in
            make.left.equalTo(feedingButton.snp.right).offset(22)
            make.centerY.equalTo(feedingButton.snp.centerY)
            make.width.height.equalTo(50)
        }

        symtomsButton.setImage(UIImage(named: "symptomps"), for: .normal)
        symtomsButton.addTarget(self, action: #selector(symtomsButtonClicked), for: .touchUpInside)
        view.addSubview(symtomsButton)
        symtomsButton.snp.makeConstraints { make in
            make.left.equalTo(sleepButton.snp.right).offset(22)
            make.centerY.equalTo(allButton.snp.centerY)
            make.width.height.equalTo(50)
        }
        
        tableView.register(CalendarTableVC.self, forCellReuseIdentifier: CalendarTableVC.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(timeLabel.snp.bottom).offset(98)
            make.bottom.equalToSuperview()
        }
        tableView.reloadData()
    }
    @objc func backButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func allButtonClicked() {
        feedingButton.setImage(UIImage(named: "feed3"), for: .normal)
        sleepButton.setImage(UIImage(named: "sleeping"), for: .normal)
        symtomsButton.setImage(UIImage(named: "symptomps"), for: .normal)
        selectedEventType = .all
        allButton.setTitleColor(.purple, for: .normal)
        tableView.reloadData()
    }
    
    @objc func sleepButtonClicked() {
        allButton.setTitleColor(UIColor(red: 0.762, green: 0.762, blue: 0.762, alpha: 1), for: .normal)
        feedingButton.setImage(UIImage(named: "feed3"), for: .normal)
        selectedEventType = .sleep
        sleepButton.setImage(UIImage(named: "purpleSleep"), for: .normal)
        symtomsButton.setImage(UIImage(named: "symptomps"), for: .normal)
        tableView.reloadData()
    }
    
    @objc func feedingButtonClicked() {
        allButton.setTitleColor(UIColor(red: 0.762, green: 0.762, blue: 0.762, alpha: 1), for: .normal)
        selectedEventType = .feeding
        feedingButton.setImage(UIImage(named: "purpleFeed"), for: .normal)
        sleepButton.setImage(UIImage(named: "sleeping"), for: .normal)
        symtomsButton.setImage(UIImage(named: "symptomps"), for: .normal)
        tableView.reloadData()
    }

    @objc func symtomsButtonClicked() {
        allButton.setTitleColor(UIColor(red: 0.762, green: 0.762, blue: 0.762, alpha: 1), for: .normal)
        feedingButton.setImage(UIImage(named: "feed3"), for: .normal)
        sleepButton.setImage(UIImage(named: "sleeping"), for: .normal)
        selectedEventType = .symptoms
        symtomsButton.setImage(UIImage(named: "orangeSymptomps"), for: .normal)
        tableView.reloadData()
    }
}

extension CalendarVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedEventType {
        case .all:
            return Globals.shared.allStatus.count
        case .feeding :
            let filtered = Globals.shared.allStatus.filter { $0.type == "feeding" }
            return filtered.count
        case .sleep:
            let filtered = Globals.shared.allStatus.filter { $0.type == "sleep" }
            
            return filtered.count
        case .symptoms:
            let symptoms = Globals.shared.allStatus.filter { $0.type == "symptoms" }
            return symptoms.count
        case .none:
            return 0
        }        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = Globals.shared.allStatus[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CalendarTableVC.identifier, for: indexPath) as! CalendarTableVC
        
        switch selectedEventType {
        case .all:
            cell.configure(with: index)
            
        case .feeding:
            let filtered = Globals.shared.allStatus.filter { $0.type == "feeding" }
            let feed = filtered[indexPath.row]
            cell.configure(with: feed)
            
        case .sleep:
            let filtered = Globals.shared.allStatus.filter { $0.type == "sleep" }
            let sleep = filtered[indexPath.row]
            cell.configure(with: sleep)
            
        case .symptoms:
            let filtered = Globals.shared.allStatus.filter { $0.type == "symptoms" }
            let symptoms = filtered[indexPath.row]
            cell.configure(with: symptoms)
            
        case .none:
            print("error")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let index = Globals.shared.allStatus[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { action, view, completion in
            FirebaseManager.deleteBabyValue(userId: Globals.shared.userID, documentId: index.id) {
                FirebaseManager.fetchBabyValue(userId: Globals.shared.userID) {
                    tableView.reloadData()
                }
            }
            Alerts.alertAction(title: "Delete", message: "Delete is successed", vc: self)
            completion(true)
        }
        deleteAction.backgroundColor = UIColor.red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
