//
//  DailyRoutineViewController.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/7/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class DailyRoutineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var startRoutineButton: UIButton!
    
    
    private var isRoutineinProgress:Bool = false
    
    private var dayRoutine:[ExerciseGroup]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        self.dayRoutine = DataService.instance.getRoutine().peekNextRoutine()
        var barTitle = ""
        for element in self.dayRoutine {
            barTitle += element.name + " "
        }
        self.navigationItem.title = barTitle
        // Do any additional setup after loading the view.
    }
    
    // MARK: TableViewMethods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayRoutine[section].drills.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dayRoutine.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dayRoutine[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RepsSeries2") as? ExcerciseCell {
            let currentDrill = dayRoutine[indexPath.section].drills[indexPath.row]
//            var variations = currentDrill.drill.exercise.description
            var variations = ""
            if let equipment = currentDrill.drill.exercise.equipment {
                variations += " Equipo: \(equipment.name)"
            }
            if let extras = currentDrill.drill.exercise.variations {
                variations += "\n"
                for variation in extras {
                    variations += "\(variation) "
                }
            }
            
            //V1
            //cell.setContentOfCell(withExcerciseImage: currentDrill.drill.exercise.image, excerciseName: currentDrill.drill.exercise.name, exerciseDescription: variations, repsNumber: "\(currentDrill.drill.reps)", weight: "\(currentDrill.drill.weight ?? 0)", andSeriesNumber: "\(currentDrill.numberOfDrills ?? 0)")
            //V2
            //cell.setContentOfCell(withExcerciseImage: currentDrill.drill.exercise.image, excerciseName: currentDrill.drill.exercise.name, exerciseDescription: variations, repsNumber: "\(currentDrill.drill.reps)", andSeriesNumber: "\(currentDrill.numberOfDrills ?? 0)")
            //V3
            cell.setContentOfCell(withExcerciseImage: currentDrill.drill.exercise.image, excerciseName: currentDrill.drill.exercise.name, exerciseDescription: variations, equipmentImage: currentDrill.drill.exercise.equipment?.image, repsNumber: "\(currentDrill.drill.reps)", andSeriesNumber: "\(currentDrill.numberOfDrills ?? 0)")

            return cell
        } else { return ExcerciseCell() }
           
    }
    
    //MARK: - IBActions
    
    @IBAction func barButtonItemPressed(_ sender: Any) {
        if !isRoutineinProgress{
            startRoutine()
        } else {
            finishRoutine()
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        if !isRoutineinProgress{
            navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Advertencia", message: "Te encuentras en medio de una sesión de ejercicio. ¿Deseas concluirla?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Sí", style: .default, handler: { action in
                self.finishRoutine()
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Routine managemend & log
    
    private func startRoutine() {
        isRoutineinProgress = true
        toggleBarButtonItem()
    }
    
    private func finishRoutine() {
        //DataService.instance.getRoutine().popNextRoutine()
        logProgress()
        isRoutineinProgress = false
        navigationController?.popViewController(animated: true)
        toggleBarButtonItem()
    }
    
    func toggleBarButtonItem() {
        if !isRoutineinProgress {
            
        } else {
            
        }
    }

    
    private func logProgress() {
        print("Routine logged")
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
