//
//  RoutineViewController.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/6/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class RoutineViewController: UIViewController {

    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/MMM"
        startDateLabel.text = "Inicio: \(dateformatter.string(from: DataService.instance.getRoutine().startDate))"
        endDateLabel.text = "Fin: \(dateformatter.string(from: DataService.instance.getRoutine().endDate!))"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startRoutine(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        segue.destination as? DailyRoutineViewController
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
