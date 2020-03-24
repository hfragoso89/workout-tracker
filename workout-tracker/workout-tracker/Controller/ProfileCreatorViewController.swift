//
//  ProfileCreatorViewController.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/6/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class ProfileCreatorViewController: UITableViewController {

    var user:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let photoCell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? ChangePhotoCell {
            photoCell.photo = user.image
            return photoCell
            }
        case 1:
            if let sectionCell = tableView.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath) as? SectionCell {
                sectionCell.updateUI(with: "Información personal")
                return sectionCell
            }
        case 2:
            if let componentCell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? EditableUserComponentCell {
                componentCell.setupUI(forComponent:"Primer nombre", withValue: user.firstName)
                return componentCell
            }
        case 3:
            if let componentCell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? EditableUserComponentCell {
                componentCell.setupUI(forComponent:"Apellidos", withValue: user.lastName)
                return componentCell
            }
        case 4:
            if let componentCell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? EditableUserComponentCell {
                componentCell.setupUI(forComponent:"Edad", withValue: "\(user.getAge())")
                return componentCell
            }
        case 5:
            if let componentCell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? EditableUserComponentCell {
                componentCell.setupUI(forComponent:"Peso", withValue: user.weight.stringValue(for: .kg, withPrecision: 1))
                return componentCell
            }
        case 6:
            if let componentCell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? EditableUserComponentCell {
                componentCell.setupUI(forComponent:"Estatura", withValue: user.height.stringValue(for: .m, withPrecision: 2))
                return componentCell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
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
