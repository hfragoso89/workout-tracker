//
//  TodaysRoutineViewController.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/27/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class TodaysRoutineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
       

    @IBOutlet weak var mainContentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainContentTableView.delegate = self
        self.mainContentTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
//    MARK - TableView DataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let todaysRoutineCell = tableView.dequeueReusableCell(withIdentifier: "todayRoutine", for: indexPath) as? TodaysRoutineCell {
                return todaysRoutineCell
            }
        case 1:
            if let separatorCell = tableView.dequeueReusableCell(withIdentifier: "separatorCell", for: indexPath) as? SeparatorCell {
                return separatorCell
            }
        case 2:
            if let titleCell = tableView.dequeueReusableCell(withIdentifier: "routineSelectorTitle", for: indexPath) as? TitleForSectionCell {
                return titleCell
            }
        case 3:
            if let routineSelectorCell = tableView.dequeueReusableCell(withIdentifier: "routineSelector", for: indexPath) as? CollectionViewCell {
                return routineSelectorCell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 610
        case 1:
            return 50
        case 2:
            return 50
        case 3:
            return 400
        default:
            return 42
        }
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
