
import UIKit
import Lottie

class NextSymptomsVC: UIViewController{

    var collectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    var symptomsList = [Symptoms]()
    let saveButton = UIButton()
    let backButton = UIButton()
    let lottie = LottieAnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        symptompsData()
        constraintSetup()
    }
  
    func symptompsData() {
        let symptoms1 = Symptoms(title: "Runny Nose", imageTitle: "runnyNose")
        let symptoms2 = Symptoms(title: "Heart Burn", imageTitle: "heartBurn")
        let symptoms3 = Symptoms(title: "Not Appetite", imageTitle: "notAppetite")
        let symptoms4 = Symptoms(title: "Rush", imageTitle: "rush")
        let symptoms5 = Symptoms(title: "Low Energy", imageTitle: "lowEnergy")
        let symptoms6 = Symptoms(title: "Nausea", imageTitle: "nausea")
        let symptoms7 = Symptoms(title: "Coucgh", imageTitle: "cough")
        let symptoms8 = Symptoms(title: "Fever", imageTitle: "fever")

        symptomsList.append(contentsOf: [symptoms1, symptoms2, symptoms3, symptoms4, symptoms5, symptoms6, symptoms7, symptoms8])
    }

    func constraintSetup() {
        view.backgroundColor = .systemBackground
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 27)
        titleLabel.sizeToFit()
        titleLabel.textColor = .purple
        titleLabel.text = "Symptoms"
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
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 40, bottom: 5, right: 40)
        collectionView?.layer.cornerRadius = 10
        collectionView?.isScrollEnabled = true
        layout.scrollDirection = .vertical
        
        collectionView?.showsVerticalScrollIndicator = false
        guard let collectionView = collectionView else{
            return
        }
        collectionView.register(SymptomsCollectionVC.self, forCellWithReuseIdentifier: SymptomsCollectionVC.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        saveButton.isHidden = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = UIColor(red: 0.275, green: 0.147, blue: 0.767, alpha: 1)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 20
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
            make.right.left.equalToSuperview().inset(24)
            make.height.equalTo(64)
        }
    }
    
    @objc func backButtonClicked() {
        dismiss(animated: true)
    }
    @objc func saveButtonClicked() {
        
        view.blurEffects(lottie: lottie)
        lottie.play(completion: { [weak self] (finished) in
            guard let self = self else { return }

            if finished {
                self.dismiss(animated: true)
            }
        })
    }
}

extension NextSymptomsVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return symptomsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = symptomsList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  SymptomsCollectionVC.identifier, for: indexPath) as! SymptomsCollectionVC
        cell.imageView.image = UIImage(named: index.imageTitle )
        cell.symptom = index
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SymptomsCollectionVC else { return }
        
        if let indexToRemove = Globals.shared.selectedItem.firstIndex(of: cell.symptom) {
            // Kullanıcı tekrar bastığı durumda seçimden çıkar
            Globals.shared.selectedItem.remove(at: indexToRemove)
            cell.layer.borderColor = UIColor.clear.cgColor
            cell.layer.borderWidth = 0
        } else {
            // Yeni bir eleman seçildi
            if Globals.shared.selectedItem.count < 3 {
                Globals.shared.selectedItem.append(cell.symptom)
                cell.layer.cornerRadius = 25
                cell.layer.borderColor = UIColor.purple.cgColor
                cell.layer.borderWidth = 3
            } else {
                Alerts.alertAction(title: "Error", message: "Please select only 2 symptoms", vc: self)
                collectionView.deselectItem(at: indexPath, animated: true)
            }
        }
        updateSaveButtonVisibility()
    }
    
    func updateCellSelectionState(cell: SymptomsCollectionVC) {
        if Globals.shared.selectedItem.contains(cell.symptom) {
            cell.layer.cornerRadius = 25
            cell.layer.borderColor = UIColor.purple.cgColor
            cell.layer.borderWidth = 3
        } else {
            cell.layer.borderColor = UIColor.clear.cgColor
            cell.layer.borderWidth = 0
        }
    }
    
    func updateSaveButtonVisibility() {
        saveButton.isHidden = Globals.shared.selectedItem.isEmpty
    }
}

