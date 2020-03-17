//
//  DayEditorCollectionCell.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/12/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class DayEditorCollectionCell: UICollectionViewCell, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var exerciseGroupsTable: UITableView!
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var pickerViewControl: UIPickerView!
    
    var dayRoutine: [ExerciseGroup]?
    var dayNumber:Int?
    var weekDay:Weekday?
    
    @IBAction func selectWeekdayButtonPressed(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pickerViewControl.delegate = self
        self.exerciseGroupsTable.delegate = self
        self.exerciseGroupsTable.dataSource = self
        
        self.dayNameLabel.text = "Día \(weekDay?.SpanishString() ?? String(dayNumber ?? 0) == "0" ? "" : String(dayNumber!))"
    }
    
    // MARK: - Prepare view for display
    
    func setContentsOfDayEditorCell(withDayRoutine day: [ExerciseGroup], weekDayString:Weekday?, andNumber number:Int?) {
        self.dayRoutine = day
        self.weekDay = weekDayString
        self.dayNumber = number
        
    }
    
    // MARK: - UITableViewDelegate/DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return /*dayRoutine?[section].drills.count? ??*/ 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let displayCell = tableView.dequeueReusableCell(withIdentifier: "DrillDisplayCell") as? ExcerciseCell {
            let currentDrill = dayRoutine?[indexPath.section].drills[indexPath.row]
            //            var variations = currentDrill.drill.exercise.description
                        var variations = ""
            if let equipment = currentDrill?.drill.exercise.equipment {
                            variations += " Equipo: \(equipment.name)"
                        }
            if let extras = currentDrill?.drill.exercise.variations {
                            variations += "\n"
                            for variation in extras {
                                variations += "\(variation) "
                            }
                        }
            displayCell.setContentOfCell(withExcerciseImage: currentDrill!.drill.exercise.image, excerciseName: currentDrill!.drill.exercise.name, exerciseDescription: variations, equipmentImage: currentDrill?.drill.exercise.equipment?.image, repsNumber: String(currentDrill!.drill.reps), andSeriesNumber: String(currentDrill?.numberOfDrills ?? 0))
            return displayCell
        }
        return UITableViewCell()
    }

    
    // MARK: - UIPickerViewDelegate/DataSource Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        5
    }
    
    
}
