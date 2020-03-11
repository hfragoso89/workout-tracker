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
    @IBOutlet weak var StopRoutine: UIBarButtonItem!
    @IBOutlet weak var StartRoutine: UIBarButtonItem!
    
    private var isRoutineinProgress:Bool = false
    
    private var dayRoutine:[ExerciseGroup]!
    private let exercises = ["Sentadilla Perfecta", "Desplante caminando C/P", "Sentadilla Zorro C/K", "Abductor-Aductor", "Extensión Ind-Sim", "Flex Rodilla 20-10"]
    private let reps = ["12", "20", "15", "15", "12", "20-10"]
    private let drills = ["4", "4", "4", "4", "4", "4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        self.dayRoutine = DataService.instance.getRoutine().peekNextRoutine()
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
            print(exercises[indexPath.row])
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
    
    
    // Routine managemend & log
    
    private func startRoutine() {
        isRoutineinProgress = true
        toggleBarButtonItem()
    }
    
    private func finishRoutine() {
        DataService.instance.getRoutine().popNextRoutine()
        logProgress()
        isRoutineinProgress = false
        navigationController?.popViewController(animated: true)
        toggleBarButtonItem()
    }
    
    func toggleBarButtonItem() {
        if !isRoutineinProgress {
            StartRoutine.setBackgroundImage(UIImage(named: "play.fill"), for: .normal, style: .plain, barMetrics: .default)
//            StartRoutine.setBackButtonBackgroundImage(UIImage(named: "play.fill"), for: .normal, barMetrics: .default)
        } else {
            StartRoutine.setBackgroundImage(UIImage(named: "stop.fill"), for: .normal, style: .plain, barMetrics: .default)
//            StartRoutine.setBackButtonBackgroundImage(UIImage(named: "stop.fill"), for: .normal, barMetrics: .default)
        }
    }

    
    private func logProgress() {
        print("Routine logged")
//        let alert = UIAlertController(title: "Felicidades", message: "¡Has completado tu rutina de hoy!", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Finalizar", style: .default, handler: nil))
//        present(alert, animated: true, completion: {
//            self.navigationController?.popViewController(animated: true)
//        })
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
