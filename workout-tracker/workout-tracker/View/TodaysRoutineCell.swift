//
//  TodaysRoutineCell.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/27/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class TodaysRoutineCell: UITableViewCell {

    @IBOutlet weak var todaysRoutineImageView: UIImageView!
    @IBOutlet weak var routineNameShadowLabel: UILabel!
    @IBOutlet weak var routineNameLabel: UILabel!
    @IBOutlet weak var todaysRoutineDescriptionShadowLabel: UILabel!
    @IBOutlet weak var todaysRoutineDescriptionLabel: UILabel!
    @IBOutlet weak var secondaryTitleLabel: UILabel!
    @IBOutlet weak var secondaryDescriptionLabel: UILabel!
    
    
    @IBOutlet weak var starRoutinetButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(withTitle title:String, todaysDescription:String, equipmentDescription: String, routineImage image: UIImage) {
        self.routineNameLabel.text = title
        self.routineNameShadowLabel.text = title
        self.todaysRoutineDescriptionLabel.text = todaysDescription
        self.todaysRoutineDescriptionShadowLabel.text = todaysDescription
        self.secondaryDescriptionLabel.text = equipmentDescription
        self.todaysRoutineImageView.image = image
        setLanguage()
    }
    
    func setTint(_ color:UIColor) {
        self.todaysRoutineDescriptionShadowLabel.backgroundColor = color
        self.starRoutinetButton.tintColor = color
    }
    
    private func setLanguage() {
        self.starRoutinetButton.setTitle("Iniciar", for: .normal)
        self.secondaryTitleLabel.text = "Equipo"
    }

    @IBAction func startButtonPressed(_ sender: Any) {
    }
}
