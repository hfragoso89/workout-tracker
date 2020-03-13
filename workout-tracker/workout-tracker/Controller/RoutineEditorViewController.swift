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
    
    @IBOutlet weak var pickerViewControl: UIPickerView!
    @IBOutlet weak var datePickerViewControl: UIDatePicker!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var numberOfDays:Int = 0 {
        willSet {
            if newValue <= 1 {
                self.numberOfDays = 1
                disableButton(self.removeDaysButton, animated: true)
            } else {
                let startDate = Date(self.startDateField.text ?? "2020-01-01")
                let endDate = Date((self.endDateField.text ?? "2020-01-02") == "" ? "2020-01-02" : self.endDateField.text!)
                self.numberOfDays = Int(abs(endDate.distance(to: startDate))/86400) <= newValue ? newValue : Int(abs(endDate.distance(to: startDate))/86400)
            }
            self.collectionView.reloadData()
        }
    }
    
    var isNewRoutine:Bool = true {
        didSet{
            if self.isNewRoutine {
                numberOfDays = 1
                
            } else {
                
            }
        }
    }
    
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
        setSelectedDate(date: self.datePickerViewControl.date, inField: self.startDateField)
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
            showDatePickerView(animated: true)
            return false
        }
        return true
    }
    
    // MARK: - AnimationMethods
    
    func disableButton(_ button:UIButton, animated: Bool) {
        button.isEnabled = !button.isEnabled
    }
    
    func showDatePickerView(animated: Bool){
        self.datePickerView.isHidden = false
    }
    
    func dismissDatePickerView(animated: Bool){
        self.datePickerView.isHidden = true
    }
    
    func setSelectedDate(date: Date, inField field: UITextField){
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.locale = Locale.current
        field.text = formatter.string(from: date)
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
