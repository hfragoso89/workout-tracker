//
//  RoutineEditorViewController.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/12/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class RoutineEditorViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    //Outlets
    @IBOutlet weak var controllerTitleLabel: UILabel!
    @IBOutlet weak var routineNameField: UITextField!
    @IBOutlet weak var startDateField: UITextField!
    @IBOutlet weak var endDateField: UITextField!
    @IBOutlet weak var daysNumberLabel: UILabel!
    @IBOutlet weak var addDaysButton: UIButton!
    @IBOutlet weak var removeDaysButton: UIButton!
    
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var datePickerViewLabel: UILabel!
    
    @IBOutlet weak var pickerViewControl: UIPickerView!
    @IBOutlet weak var datePickerViewControl: UIDatePicker!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var numberOfDays:Int = 0 {
        willSet {
            if newValue <= 1 {
                self.numberOfDays = 1
                disableButton(self.removeDaysButton, animated: true)
            } else {
                let placeHolderDate = Date("2020-01-01")
                
                let startDate = Date(self.startDateField.text ?? placeHolderDate.generateString(withDateStyle: .short, timeStyle: .none, andLocale: Locale.current), withStyle: .short, andLocale: Locale.current)
                let endDate = Date(self.endDateField.text ?? placeHolderDate.generateString(withDateStyle: .short, timeStyle: .none, andLocale: Locale.current), withStyle: .short, andLocale: Locale.current)
                print("\n\nStart: \(startDate)\nEnd: \(endDate)")
                self.numberOfDays = Int(abs(endDate.distance(to: startDate))/86400) <= newValue ? newValue : Int(abs(endDate.distance(to: startDate))/86400)
            }
            self.collectionView.reloadData()
        }
    }
    
    var isNewRoutine:Bool = true {
        didSet{
            if self.isNewRoutine {
                numberOfDays = 1
                self.controllerTitleLabel.text = "Nueva Rutina"
            } else {
                self.controllerTitleLabel.text = "Editar Rutina"
            }
        }
    }
    var dateFieldCurrentlyInEdition:DatePickerOptions = .none
    
    var routine:Routine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.pickerViewControl.delegate = self
        self.pickerViewControl.dataSource = self
        self.routineNameField.delegate = self
        self.startDateField.delegate = self
        self.endDateField.delegate = self
        // Do any additional setup after loading the view.
        
        if self.routine == nil {
            self.routine = Routine(withName: "Nueva Rutina", image: UIImage(), startDate: Date(), endDate: nil, owner: DataService.instance.getUser(), days:
                [[ExerciseGroup(withName: "Nuevo", andDrills: [])]], andWeekdays: nil)
        }
    }
    
    // MARK: - IBAction methods
    
    @IBAction func addDaysButtonPressed(_ sender: UIButton) {
        numberOfDays += 1
    }
    
    @IBAction func removeDaysButtonPressed(_ sender: UIButton) {
        numberOfDays -= 1
    }
    
    @IBAction func selectDateButtonPressed(_ sender: Any) {
        setSelectedDate(date: self.datePickerViewControl.date, inField: self.dateFieldCurrentlyInEdition == .startDateField ?  self.startDateField : self.endDateField)
        dismissDatePickerView(animated: true)
    }
    
    
    // MARK: - CollectionViewControllerDelegate & CollectionViewControllerDataSource Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.routine?.days?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let dayEditorCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayEditorCell", for: indexPath) as? DayEditorCollectionCell {
            dayEditorCell.setContentsOfDayEditorCell(withDayRoutine: (routine?.days?[indexPath.row])!, weekDayString: nil, andNumber: indexPath.row)
            return dayEditorCell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - UIPickerViewDelegate Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        10
    }
    
    // MARK: - UITextFielddelegate Methods
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.startDateField || textField == self.endDateField {
            self.datePickerViewLabel.text = textField == self.startDateField ? "Fecha de inicio" : "Fecha de fin"
            self.dateFieldCurrentlyInEdition = textField == self.startDateField ? .startDateField : .endDateField
            showDatePickerView(animated: true)
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.routineNameField {
            textField.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - AnimationMethods
    
    func disableButton(_ button:UIButton, animated: Bool) {
        button.isEnabled = !button.isEnabled
    }
    
    func showDatePickerView(animated: Bool){
        if !self.datePickerView.isHidden {return}
        self.datePickerView.isHidden = false
        self.datePickerView.alpha = 0
        self.datePickerView.frame = CGRect(x: 0, y: (self.parent?.view.frame.height ?? 800 + self.datePickerView.frame.height), width: self.datePickerView.frame.width, height: self.datePickerView.frame.height)
        UIView.animate(withDuration: 0.6, animations: {
            self.datePickerView.frame = CGRect(x: 0, y: (self.datePickerView.frame.minY - self.datePickerView.frame.height), width: self.datePickerView.frame.width, height: self.datePickerView.frame.height)
            self.datePickerView.alpha = 0.9
        })
    }
    
    func dismissDatePickerView(animated: Bool){
        if self.datePickerView.isHidden {return}
        self.datePickerView.isHidden = true
        self.datePickerView.alpha = 0.9
        //self.datePickerView.frame = CGRect(x: 0, y: (self.datePickerView.frame.minY - self.datePickerView.frame.height), width: self.datePickerView.frame.width, height: self.datePickerView.frame.height)
        UIView.animate(withDuration: 0.6, animations: {
            self.datePickerView.frame = CGRect(x: 0, y: (self.parent?.view.frame.height ?? 800 + self.datePickerView.frame.height), width: self.datePickerView.frame.width, height: self.datePickerView.frame.height)
            self.datePickerView.alpha = 0
        })
    }
    
    func setSelectedDate(date: Date, inField field: UITextField){
        field.text = date.generateString(withDateStyle: .short, timeStyle: .none, andLocale: Locale.current)
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

enum DatePickerOptions {
    case startDateField
    case endDateField
    case none
}
