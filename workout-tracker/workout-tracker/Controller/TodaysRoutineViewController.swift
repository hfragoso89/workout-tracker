//
//  TodaysRoutineViewController.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/27/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit
import CoreData

class TodaysRoutineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
       

    @IBOutlet weak var mainContentTableView: UITableView!
    
    // UIElements
    var elementsArray:[(type:TodaysRoutineComponentType,component:Any?)]?
    var routine:Routine?
    var topWorkouts:[WorkoutDay]?
    var routinesHistory:[WorkoutDay]?
    
     var container:NSPersistentContainer? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainContentTableView.delegate = self
        self.mainContentTableView.dataSource = self
        
        // Do any additional setup after loading the view.
        self.elementsArray = []
        
        topWorkouts = DataService.instance.getTopWorkouts()
        routine = DataService.instance.getRoutine()
//        print("Routine: \(routine?.name)")
        if let myCurrentSavedRoutine = try?ManagedRoutine.findMyCurrentRoutine(in: container!.viewContext) {
            print("Current routineFound")
            routine = Routine(withManagedRoutine: myCurrentSavedRoutine)
        } else {
            print("Assigning routine to myUser")
            let context = container!.viewContext
            context.perform { [weak self] in
                if let myUser = try?ManagedUser.findMyUser(in: context){
                    print("Current User = \(myUser.firstName) \(myUser.lastName)")
                    do{
                        myUser.currentRoutine = try ManagedRoutine.findOrCreateRoutine(matching: self!.routine!, in: context)
                    } catch {
                        print("\n:(\nRoutine assignment error:\(error.localizedDescription)")
                    }
                    print("\(myUser.firstName) \(myUser.lastName)'s new current routine is: \(myUser.currentRoutine?.name)")
                    do {
                        try context.save()
                    } catch {
                        print("\n:(\nSaving error:\(error.localizedDescription)")
                    }
                    print("assignment Succesful! :)")
                    self!.updateUI()
                } else {
                    self?.parent?.parent?.performSegue(withIdentifier: "startUpWizard", sender: self?.parent?.parent)
                }
            }
            
            
        }
        print("Routine to show: \(routine?.name)")
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Today: \(self.routine?.getTodaysRoutineName())")
        updateUI()
    }
    
//    MARK: - UIHandler
    
    private func updateUI() {
        if  routine != nil {
            elementsArray?.append((TodaysRoutineComponentType.todaysRoutine,routine))
            elementsArray?.append((TodaysRoutineComponentType.separator,"Más rutinas"))
        } else {
            elementsArray?.append((TodaysRoutineComponentType.title, "Selecciona tu primera rutina"))
            elementsArray?.append((TodaysRoutineComponentType.routineCollection, topWorkouts))
            return
        }
        if routinesHistory != nil {
            elementsArray?.append((TodaysRoutineComponentType.title, "Historial de rutinas"))
            elementsArray?.append((TodaysRoutineComponentType.routineCollection, routinesHistory))
        }
        if topWorkouts != nil {
            elementsArray?.append((TodaysRoutineComponentType.title, "Rutinas destacadas"))
            elementsArray?.append((TodaysRoutineComponentType.routineCollection, topWorkouts))
        }
        
    }
    
//    MARK - TableView DataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elementsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = elementsArray![indexPath.row]
        switch element.type {
        case .todaysRoutine:
            if let todaysRoutineCell = tableView.dequeueReusableCell(withIdentifier: "todayRoutine", for: indexPath) as? TodaysRoutineCell {
                let todaysRoutine = element.component as! Routine
                todaysRoutineCell.setupUI(withTitle: todaysRoutine.name, todaysDescription: "Hoy: \(todaysRoutine.getTodaysRoutineName())", equipmentDescription: todaysRoutine.equipmentDescription, routineImage: todaysRoutine.image ?? UIImage(named: "reach_goal")!)
                return todaysRoutineCell
            }
        case .separator:
            if let separatorCell = tableView.dequeueReusableCell(withIdentifier: "separatorCell", for: indexPath) as? SeparatorCell {
                let separatorTitle = element.component as! String
                separatorCell.setupUI(withTitle: separatorTitle, andCellType: .downArrow)
                return separatorCell
            }
        case .title:
            if let titleCell = tableView.dequeueReusableCell(withIdentifier: "routineSelectorTitle", for: indexPath) as? TitleForSectionCell {
                titleCell.setTitle(element.component as! String)
                return titleCell
            }
        case .routineCollection:
            if let routineSelectorCell = tableView.dequeueReusableCell(withIdentifier: "routineSelector", for: indexPath) as? CollectionViewTableCell {
                
                routineSelectorCell.routinesArray = element.component as! [WorkoutDay]
                return routineSelectorCell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let element = elementsArray![indexPath.row]
        switch element.type {
        case .todaysRoutine:
            return 610
        case .separator:
            return 50
        case .title:
            return 50
        case .routineCollection:
            return 400
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

enum TodaysRoutineComponentType {
    case todaysRoutine
    case title
    case separator
    case routineCollection
}
