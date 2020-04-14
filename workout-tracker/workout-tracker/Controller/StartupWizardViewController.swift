//
//  WizardViewController.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 4/9/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit
import CoreData
import HealthKit

class StartupWizardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, StartupWizardCollectionViewCellDelegate, UINavigationControllerDelegate, ImagePickerDelegate {

    @IBOutlet weak var wizardCollectionView: UICollectionView!
    @IBOutlet weak var welcomeLabel: UILabel!
    let healthStore = HKHealthStore()
    
    var container:NSPersistentContainer? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    var newUser:User!
    var customImagePicker: ImagePickerViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.wizardCollectionView.delegate = self
        self.wizardCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        self.wizardCollectionView.frame = self.view.frame
        
        self.newUser = User()

        self.customImagePicker = ImagePickerViewController(presentationController: self, delegate: self)
    }
    
    // MARK: - CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        print("Cell \(indexPath.row) size: \(collectionView.frame.width), \(collectionView.frame.height)")
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            if let stepOneCell = collectionView.dequeueReusableCell(withReuseIdentifier: "stepOneCell", for: indexPath) as? StartupWizardCollectionViewCell {
                stepOneCell.delegate = self
                stepOneCell.setupUI(for: .step1, with: self.newUser)
                if self.healthStore.authorizationStatus(for: HKCharacteristicType.characteristicType(forIdentifier: .biologicalSex)!).rawValue == 1 {
                    stepOneCell.setHealthKitEnabled()
                    
                }
                return stepOneCell
            }
        case 1:
            if let stepTwoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "stepTwoCell", for: indexPath) as? StartupWizardCollectionViewCell {
                stepTwoCell.delegate = self
                stepTwoCell.setupUI(for: .step2, with: self.newUser)
                return stepTwoCell
            }
        case 2:
            if let stepThreeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "stepThreeCell", for: indexPath) as? StartupWizardCollectionViewCell {
                stepThreeCell.delegate = self
                stepThreeCell.setupUI(for: .step3, with: self.newUser)
                return stepThreeCell
            }
        case 3:
            if let stepFourCell = collectionView.dequeueReusableCell(withReuseIdentifier: "stepFourCell", for: indexPath) as? StartupWizardCollectionViewCell {
                stepFourCell.delegate = self
                stepFourCell.setupUI(for: .step4, with: self.newUser)
                return stepFourCell
            }
        default:
            return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func didSelect(image: UIImage?) {
        if let selectedImage = image {
            self.newUser?.changePhoto(with: selectedImage)
            self.wizardCollectionView.reloadData()
        }
    }
    
    // MARK: - StartupWizardCollectionViewCellDelegate methods
    
    func photoActionPressed() {
        self.customImagePicker.present(from: self.view)
    }
    
    func collectionViewCellNextStepButtonPressed(from step:StartupWizardStep, generating user:User) {
        
        self.newUser = user
        self.wizardCollectionView.reloadData()
        
        self.wizardCollectionView.scrollToItem(
            at: IndexPath(row: (step.rawValue + 1), section: 0),
            at: UICollectionView.ScrollPosition.centeredHorizontally , animated: true)
    }
    
    func collectionViewCellFinishButtonPressed(generating user: User) {
        self.newUser = user
        print("Saving user...\n  \(newUser.firstName) \(newUser.lastName), \(newUser.birthdate), \(newUser.gender), \(newUser.userName)")
        saveUserInformation()
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionViewCellDidSelectGender(_ user: User) {
        self.newUser = user
        let gender = self.newUser.gender
        switch gender {
        case .female:
            self.welcomeLabel.text = "Bienvenida"
        case .male:
            self.welcomeLabel.text = "Bienvenido"
        case .undefined:
            self.welcomeLabel.text = "Bienvenid@"
        default:
            self.welcomeLabel.text = "Bienvenidx"
        }
        self.wizardCollectionView.reloadData()
    }
    
    func connectWithHealtApp() {
        let typesToShare: Set = [
            HKQuantityType.workoutType()
        ]
        
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!,
            HKCharacteristicType.characteristicType(forIdentifier: .biologicalSex)!,
            HKCharacteristicType.characteristicType(forIdentifier: .dateOfBirth)!
        ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            // Handle error
            if success {
                print("HealthKit enabled!")
                if let hkdateOfBirthComponents = try?self.healthStore.dateOfBirthComponents() {
                    self.newUser.birthdate = hkdateOfBirthComponents.date ?? Date()
                    print("birthdate: \(self.newUser.birthdate)")
                }
                if let hkGender = try?self.healthStore.biologicalSex() {
                    print("Gender: \(hkGender)")
                    self.newUser.gender = hkGender.biologicalSex == HKBiologicalSex.male ? Gender.male : hkGender.biologicalSex == HKBiologicalSex.female ? Gender.female : Gender.undefined
                    DispatchQueue.main.async {
                        let gender = self.newUser.gender
                        switch gender {
                        case .female:
                            self.welcomeLabel.text = "Bienvenida"
                        case .male:
                            self.welcomeLabel.text = "Bienvenido"
                        case .undefined:
                            self.welcomeLabel.text = "Bienvenid@"
                        default:
                            self.welcomeLabel.text = "Bienvenidx"
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.wizardCollectionView.reloadData()
                }
            } else {
                print("Error trying to initialize HealtApp: \(error?.localizedDescription)")
                
            }
        }
    }
    
    // MARK: - CoreData management
    
    func saveUserInformation() {
        let context = self.container?.viewContext
        context?.perform {
            do {
                let newUser = try ManagedUser.findOrCreateUser(matching: self.newUser, in: context!)
                newUser.me = true
            } catch {
                print(print("StartupWizard.saveUserInformation(): findOrCreateUserError.\n\(error.localizedDescription)"))
            }
            do{
                try context?.save()
                print("Save Succesfull! :D\n\(self.newUser)")
            } catch {
                print("StartupWizard.saveUserInformation(): Saving error.\n\(error.localizedDescription)")
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "startUpWizard" {
            return false
        }
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
