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
    
    private var dayRoutine:[ExerciseGroup]!
    private let exercises = ["Sentadilla Perfecta", "Desplante caminando C/P", "Sentadilla Zorro C/K", "Abductor-Aductor", "Extensión Ind-Sim", "Flex Rodilla 20-10"]
    private let reps = ["12", "20", "15", "15", "12", "20-10"]
    private let drills = ["4", "4", "4", "4", "4", "4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        self.dayRoutine = DataService.instance.getRoutine().days![0]
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
        return 110
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dayRoutine[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RepsSeries") as? ExcerciseCell {
            print(exercises[indexPath.row])
            let currentDrill = dayRoutine[indexPath.section].drills[indexPath.row]
            cell.setContentOfCell(withExcerciseImage: currentDrill.drill.exercise.image, excerciseName: currentDrill.drill.exercise.name, repsNumber: "\(currentDrill.drill.reps)", andSeriesNumber: "\(currentDrill.numberOfDrills ?? 0)")
            return cell
        } else { return ExcerciseCell() }
           
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
