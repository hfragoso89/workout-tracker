//
//  StartupWizardCollectionViewCell.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 4/10/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class StartupWizardCollectionViewCell: UICollectionViewCell, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    //Step1 Outlets
    @IBOutlet weak var connectWithHealthAppButton: UIButton!
    @IBOutlet weak var userTypeSegmentedController: UISegmentedControl!
    @IBOutlet weak var accountManagementStackView: UIStackView!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var connectWithFBButton: UIButton!
    @IBOutlet weak var connectWithGoogleButton: UIButton!
    @IBOutlet weak var connectToHealthAppView: UISegmentedControl!
    @IBOutlet weak var healthKitEnabledCheckmark: UIImageView!
    
    
    
    //Step2 Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ageDatePicker: UIDatePicker!
    
    //Step3 Outlets
    @IBOutlet weak var goalsCollectionView: UICollectionView!
    @IBOutlet weak var userModelImage: UIImageView!
    @IBOutlet weak var armsButton: UIButton!
    @IBOutlet weak var backMusclesButton: UIButton!
    @IBOutlet weak var legsMuscleButton: UIButton!
    @IBOutlet weak var chestMuscleButton: UIButton!
    @IBOutlet weak var absMuscleButton: UIButton!
    
    //Step4 Outlets
    @IBOutlet weak var photoActionButton: UIButton!
    @IBOutlet weak var photoActionImage: UIImageView!
    @IBOutlet weak var photoFrameImageView: UIImageView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    @IBOutlet weak var nextStepButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    var delegate:StartupWizardCollectionViewCellDelegate?
    var cellStep:StartupWizardStep?
    var newUser:User!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cellStep = .step1
    }
    
    func setupUI(for step:StartupWizardStep, with user:User) {
        self.cellStep = step
        self.newUser = user
        switch step {
        case .step1:
            print("Step 3")
        case .step2:
            self.nameTextField.delegate = self
            self.lastNameTextField.delegate = self
            self.ageDatePicker.maximumDate = Date()
            
            //Set values
            self.nameTextField.text = newUser.firstName
            self.lastNameTextField.text = newUser.lastName
            self.genderSegmentedControl.selectedSegmentIndex = newUser.gender == .female ? 0 : newUser.gender == .male ? 1 : 2
            self.ageDatePicker.date = newUser.birthdate
        case .step3:
            //initialize delegates
            self.goalsCollectionView.delegate = self
            self.goalsCollectionView.dataSource = self
            
            //Set values
            self.userModelImage.image = user.gender == .female ? UIImage(named: "female_silouette_dark") : UIImage(named: "male_silouette_dark")
        case .step4:
            self.photoImageView.image = newUser.image
            self.photoImageView.layer.cornerRadius = (self.photoImageView.frame.size.width) / 2 + 15
            self.photoFrameImageView.image = newUser.image != nil ? UIImage(named: "Ring") : UIImage(systemName: "person.crop.circle")
            self.photoActionImage.image = self.photoImageView.image == nil ? UIImage(systemName: "plus.circle") : UIImage(systemName: "pencil.circle")
        }
    }
    
    func setHealthKitEnabled() {
        self.connectWithHealthAppButton.isEnabled = false
        self.healthKitEnabledCheckmark.isHidden = false
        self.connectWithHealthAppButton.setTitle("Conectado", for: .normal)
    }
    
    // MARK: - CollectionViewDelegate/DataSource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataService.instance.getGoalsArray().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let goalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "goalCollectionCell", for: indexPath) as? GoalCollectionViewCell {
            goalCell.goalNameLabel.text = DataService.instance.getGoalsArray()[indexPath.row]
            return goalCell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - UITexfieldDelegate methods
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.nameTextField {
            self.newUser = User(withFirstName: textField.text ?? "", lastName: self.newUser.lastName, userName: self.newUser.userName, image: self.newUser.image, birthdate: self.ageDatePicker.date, height: self.newUser.height, weight: self.newUser.weight, andGender: self.newUser.gender)
        }
        if textField == self.lastNameTextField {
            self.newUser = User(withFirstName: self.newUser.firstName, lastName: textField.text ?? "", userName: self.newUser.userName, image: self.newUser.image, birthdate: self.ageDatePicker.date, height: self.newUser.height, weight: self.newUser.weight, andGender: self.newUser.gender)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    // MARK: - IBActions
    
    @IBAction func nextStepButtonPressed(_ sender: Any) {
        if validateFields(){
            self.delegate?.collectionViewCellNextStepButtonPressed(from: self.cellStep!, generating: self.newUser)
        }
    }
    
    @IBAction func finishButtonPressed(_ sender: Any) {
        if validateFields() {
            self.delegate?.collectionViewCellFinishButtonPressed(generating: self.newUser)
        }
    }
    
    @IBAction func genderSegmentedViewValueChanged(_ sender: UISegmentedControl) {
        self.newUser = User(withFirstName: self.newUser.firstName, lastName: self.newUser.lastName, userName: self.newUser.userName, image: self.newUser.image, birthdate: self.ageDatePicker.date, height: self.newUser.height, weight: self.newUser.weight, andGender: (sender.selectedSegmentIndex == 0 ? .female : sender.selectedSegmentIndex == 1 ? .male : .undefined))
        self.delegate?.collectionViewCellDidSelectGender(self.newUser)
    }
    
    @IBAction func goalButtonPressed(_ sender: UIButton) {
        if sender.backgroundColor == #colorLiteral(red: 0.1751382649, green: 0.7287599444, blue: 0.3227642179, alpha: 1) {
            sender.backgroundColor = UIColor(named: "Default")
            sender.titleLabel?.textColor = #colorLiteral(red: 0.1751382649, green: 0.7287599444, blue: 0.3227642179, alpha: 1)
        } else {
            sender.backgroundColor = #colorLiteral(red: 0.1751382649, green: 0.7287599444, blue: 0.3227642179, alpha: 0.8035637842)
            sender.titleLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
    }
    @IBAction func connectWithHealthAppButtonPressed(_ sender: UIButton) {
        self.delegate?.connectWithHealtApp()
    }
    
    @IBAction func userAccountTypeValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            showCreateAccountControl()
        } else {
            showSignInControl()
        }
    }
    
    @IBAction func photoButtonPressed(_ sender: Any) {
        self.delegate?.photoActionPressed()
    }
    
    
    // MARK: - HelperMethods
    
    func validateFields() -> Bool {
        //TODO: - Complete validation logic based on the type of cell
        return true
    }
    
    // MARK: - Animation Methods
    
    private func showCreateAccountControl() {
        if self.accountManagementStackView.isHidden == false {
            UIView.animate(withDuration: 0.3, animations: {
                self.accountManagementStackView.alpha = 0
            })
        }
        self.accountManagementStackView.alpha = 0
        self.accountManagementStackView.isHidden = false
        UIView.animate(withDuration: 0.6, animations: {
            self.accountManagementStackView.alpha = 1
            self.instructionLabel.text = "Crear cuenta:"
            self.usernameTextField.text = self.newUser.userName
        })
    }
    private func showSignInControl() {
        if self.accountManagementStackView.isHidden == false {
            UIView.animate(withDuration: 0.3, animations: {
                self.accountManagementStackView.alpha = 0
            })
        }
        self.accountManagementStackView.alpha = 0
        self.accountManagementStackView.isHidden = false
        UIView.animate(withDuration: 0.6, animations: {
            self.accountManagementStackView.alpha = 1
            self.instructionLabel.text = "Iniciar sesión:"
            self.usernameTextField.text = ""
        })
    }
}

protocol StartupWizardCollectionViewCellDelegate {
    func connectWithHealtApp()
    func collectionViewCellDidSelectGender(_ user:User)
    func collectionViewCellNextStepButtonPressed(from step:StartupWizardStep, generating user:User)
    func collectionViewCellFinishButtonPressed(generating user:User)
    func photoActionPressed()
}

enum StartupWizardStep:Int {
    case step1=0
    case step2
    case step3
    case step4
}
