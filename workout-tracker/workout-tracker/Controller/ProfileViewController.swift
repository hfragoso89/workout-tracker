//
//  ProfileViewController.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/6/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //Labels
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    //textFields
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    
    
    @IBOutlet weak var displayStackView: UIStackView!
    @IBOutlet weak var editStackView: UIStackView!
    
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var pickerControl: UIPickerView!
    @IBOutlet weak var pickerViewLabel: UILabel!
    
    @IBOutlet weak var dateSelectorView: UIView!
    @IBOutlet weak var datePickerControl: UIDatePicker!
    
    @IBOutlet weak var barButtonItem: UIBarButtonItem!
    
    var imagePicker = UIImagePickerController()
    
    var user:User?
    
    var editMode:Bool = false
    
    var pickerViewType:PickerViewType = .gender
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userNameTextField.delegate = self
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.genderTextField.delegate = self
        self.ageTextField.delegate = self
        self.weightTextField.delegate = self
        self.heightTextField.delegate = self
        
        self.pickerControl.delegate = self
        self.pickerControl.dataSource = self
        
        self.imagePicker.modalPresentationStyle = UIModalPresentationStyle.currentContext
        self.imagePicker.delegate = self
        
        editMode = false
        if user == nil {
            // create the alert
            self.user = User()
            let alert = UIAlertController(title: "Advertencia", message: "No se encontró usuario, ¿Desea crear su perfil?", preferredStyle: UIAlertController.Style.alert)

            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Sí", style: UIAlertAction.Style.default, handler: { action in
                self.editMode = true
                self.loadUI()
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
        // Do any additional setup after loading the view.
        loadUI()
    }
    
    
    @IBAction func barButtonItemPressed(_ sender: Any) {
        saveChangesToProfile()
        self.editMode = !self.editMode
        loadUI()
    }
    
    @IBAction func photoButtonPressed(_ sender: Any) {
        showImagePickerView()
    }
    
    private func loadUI() {
        if let myUser = user {
            self.firstNameLabel.text = myUser.firstName
            self.lastNameLabel.text = myUser.lastName
            self.genderLabel.text = myUser.gender == Gender.male ? "Hombre" : myUser.gender == Gender.female ? "Mujer" : ""
            self.ageLabel.text = "\(myUser.getAge())"
            self.weightLabel.text = myUser.weight?.stringValue(for: .kg, withPrecision: 1) ?? ""
            self.heightLabel.text = myUser.height?.stringValue(for: .m, withPrecision: 2) ?? ""
            
            self.firstNameTextField.text = myUser.firstName
            self.lastNameTextField.text = myUser.lastName
            self.genderTextField.text = myUser.gender == Gender.male ? "Hombre" : myUser.gender == Gender.female ? "Mujer" : ""
            self.ageTextField.text = "\(myUser.getAge())"
            self.weightTextField.text = myUser.weight?.stringValue(for: .kg, withPrecision: 1) ?? ""
            self.heightTextField.text = myUser.height?.stringValue(for: .m, withPrecision: 2) ?? ""
        }
        if editMode {
            displayStackView.isHidden = true
            editStackView.isHidden = false
            barButtonItem.title = "Guardar"
        } else {
            displayStackView.isHidden = false
            editStackView.isHidden = true
            barButtonItem.title = "Editar"
        }
        self.tabBarController?.setNeedsStatusBarAppearanceUpdate()
    }
    
    
    // TODO: - Create functionality
    func saveChangesToProfile() {
        
    }
    
    @IBAction func editProfilePressed(_ sender: Any) {
        performSegue(withIdentifier: "createProfileSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createProfileSegue" {
            if let destination = segue.destination as? ProfileCreatorViewController {
                destination.user = self.user ?? User()
            }
        }
    }
    
    // MARK: - Pickers IBActions
    
    @IBAction func selectDateButtonPressed(_ sender: Any) {
        self.user!.birthdate = self.datePickerControl.date
        self.ageTextField.text = "\(self.user!.getAge())"
        self.ageLabel.text = "\(self.user!.getAge())"
        self.dismissDatePickerView(animated: true)
    }
    @IBAction func selectOptionButtonPressed(_ sender: Any) {
        self.dismissPickerView(animated: true)
    }
    
    // MARK: - TextFieldDelegate Methods

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case self.ageTextField:
            self.showDatePickerView(animated: true)
            return false
        case self.genderTextField:
            self.pickerViewLabel.text = "Género"
            preparePickerView(for: .gender)
            self.showPickerView(animated: true)
            return false
        case self.heightTextField:
            self.pickerViewLabel.text = "Estatura"
            preparePickerView(for: .heightM)
            self.showPickerView(animated: true)
            return false
        case self.weightTextField:
            self.pickerViewLabel.text = "Peso"
            preparePickerView(for: .weight)
            self.showPickerView(animated: true)
            return false
        default:
            return true
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case self.ageTextField:
            self.dismissDatePickerView(animated: true)
        default:
            textField.resignFirstResponder()
            return true
        }
        textField.resignFirstResponder()
        return true
    }
    
      
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func preparePickerView(for type:PickerViewType) {
        self.pickerViewType = type
        self.pickerControl.reloadAllComponents()
        switch self.pickerViewType {
        case .heightFt:
            self.pickerControl.selectRow(
                self.user?.height?.ftInchRawValue().ft ?? 5,
                inComponent: 0,
                animated: false)
            self.pickerControl.selectRow(
            self.user?.height?.ftInchRawValue().inch ?? 0,
            inComponent: 1,
            animated: false)
        case .heightM:
            self.pickerControl.selectRow(
                self.user?.height?.mCmRawValue().m ?? 1,
                inComponent: 0,
                animated: false)
            self.pickerControl.selectRow(
                self.user?.height?.mCmRawValue().cm ?? 70,
                inComponent: 1,
                animated: false)
        case .weight:
            self.pickerControl.selectRow(
                self.user?.weight?.intValue(for: .kg) ?? 75,
                inComponent: 0,
                animated: false)
            self.pickerControl.selectRow(
                0,
                inComponent: 1,
                animated: false)
            self.pickerControl.selectRow(
                0,
                inComponent: 2,
                animated: false)
        default:
            return
        }
    }
    
    
    // MARK: - AnimationMethods
    
//    func disableButton(_ button:UIButton, animated: Bool) {
//        button.isEnabled = !button.isEnabled
//    }
    
    func showDatePickerView(animated: Bool){
        if !self.dateSelectorView.isHidden {return}
        self.dateSelectorView.isHidden = false
        self.dateSelectorView.alpha = 0
        self.dateSelectorView.frame = CGRect(x: 0, y: (self.parent?.view.frame.height ?? 800 + self.dateSelectorView.frame.height), width: self.dateSelectorView.frame.width, height: self.dateSelectorView.frame.height)
        UIView.animate(withDuration: 0.6, animations: {
            self.dateSelectorView.frame = CGRect(x: 0, y: (self.dateSelectorView.frame.minY - self.dateSelectorView.frame.height - 49), width: self.dateSelectorView.frame.width, height: self.dateSelectorView.frame.height)
            self.dateSelectorView.alpha = 1.0
        })
    }
    
    func dismissDatePickerView(animated: Bool){
        if self.dateSelectorView.isHidden {return}
        self.dateSelectorView.isHidden = true
        self.dateSelectorView.alpha = 1.0
        //self.datePickerView.frame = CGRect(x: 0, y: (self.datePickerView.frame.minY - self.datePickerView.frame.height), width: self.datePickerView.frame.width, height: self.datePickerView.frame.height)
        UIView.animate(withDuration: 0.6, animations: {
            self.dateSelectorView.frame = CGRect(x: 0, y: (self.parent?.view.frame.height ?? 800 + self.dateSelectorView.frame.height), width: self.dateSelectorView.frame.width, height: self.dateSelectorView.frame.height)
            self.dateSelectorView.alpha = 0
        })
    }
    
    func showPickerView(animated: Bool){
        if !self.pickerView.isHidden {return}
        self.pickerView.isHidden = false
        self.pickerView.alpha = 0
        self.pickerView.frame = CGRect(x: 0, y: (self.parent?.view.frame.height ?? 800 + self.pickerView.frame.height), width: self.pickerView.frame.width, height: self.pickerView.frame.height)
        UIView.animate(withDuration: 0.6, animations: {
            self.pickerView.frame = CGRect(x: 0, y: (self.pickerView.frame.minY - self.pickerView.frame.height - 49), width: self.pickerView.frame.width, height: self.pickerView.frame.height)
            self.pickerView.alpha = 1.0
        })
    }
    
    func dismissPickerView(animated: Bool){
        if self.pickerView.isHidden {return}
        self.pickerView.isHidden = true
        self.pickerView.alpha = 1.0
        //self.datePickerView.frame = CGRect(x: 0, y: (self.datePickerView.frame.minY - self.datePickerView.frame.height), width: self.datePickerView.frame.width, height: self.datePickerView.frame.height)
        UIView.animate(withDuration: 0.6, animations: {
            self.pickerView.frame = CGRect(x: 0, y: (self.parent?.view.frame.height ?? 800 + self.pickerView.frame.height), width: self.pickerView.frame.width, height: self.pickerView.frame.height)
            self.pickerView.alpha = 0
        })
    }
    
    // MARK: - PickerViewDelegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch self.pickerViewType {
        case .gender:
            return 1
        case .heightFt:
            return 2
        case .heightM:
            return 2
        case .weight:
            return 3
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch self.pickerViewType {
        case .gender:
            return 2
        case .heightFt:
            if component == 0 {
                return 6
            } else {
                return 12
            }
        case .heightM:
            if component == 0 {
                return 3
            } else {
                return 100
            }
        case .weight:
            if component == 0 {
                return 200
            } else if component == 1 {
                return 9
            } else {
                return 2
            }
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch self.pickerViewType {
        case .gender:
            return row == 0 ? "Hombre" : "Mujer"
        case .heightM:
            if component == 0 {
                return row == 0 ? "" : "\(row)"
            } else {
                return ".\(row)"
            }
        case .heightFt:
            if component == 0 {
                return row == 0 ? "" : "\(row)'"
            } else {
                return row == 0 ? "" : "\(row)''"
            }
        case .weight:
            if component == 0 {
                return row == 0 ? "" : "\(row)"
            } else if component == 1 {
                return ".\(row)"
            } else {
                return row == 0 ? "Kg." : "Lb."
            }
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch self.pickerViewType {
            case .gender:
                self.genderTextField.text = row == 0 ? "Hombre" : "Mujer"
                self.genderLabel.text = row == 0 ? "Hombre" : "Mujer"
            case .heightM:
                self.heightTextField.text = "\(pickerView.selectedRow(inComponent:0)).\(pickerView.selectedRow(inComponent:1)) m."
            case .heightFt:
                self.heightTextField.text = "\(pickerView.selectedRow(inComponent:0))'  \(pickerView.selectedRow(inComponent:1))''"
            case .weight:
                self.weightTextField.text = "\(pickerView.selectedRow(inComponent:0)).\(pickerView.selectedRow(inComponent:1)) \(pickerView.selectedRow(inComponent:2) == 0 ? "Kg." : "Lb.")"
            }
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func showImagePickerView() {
            var mediaTypes:[String]? = []
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                mediaTypes! += UIImagePickerController.availableMediaTypes(for: .camera)!
                print("camera")
                for types in mediaTypes! {
                    print(types)
                }
            }
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                mediaTypes! += UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                print("photo library")
                for types in mediaTypes! {
                    print(types)
                }
            }
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                mediaTypes! += UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum)!
                print("savedphotosAlbum")
                for types in mediaTypes! {
                    print(types)
                }
            }
            
    //        self.imagePicker.mediaTypes = (mediaTypes)!
            self.present(imagePicker, animated: true, completion: nil)
        }
    
    private func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info:NSDictionary!) {
        var tempImage:UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        picker.dismiss(animated: true, completion: nil)
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

enum PickerViewType {
    case gender
    case heightM
    case heightFt
    case weight
}
