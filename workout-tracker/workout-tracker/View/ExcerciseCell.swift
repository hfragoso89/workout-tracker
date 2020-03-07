//
//  ExcerciseCell.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/7/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class ExcerciseCell: UITableViewCell {

    
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var excersiceNameLabel: UILabel!
    @IBOutlet weak var repsNumberLabel: UILabel!
    @IBOutlet weak var seriesNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setContentOfCell(withExcerciseImage image:UIImage, excerciseName name:String, repsNumber reps:String, andSeriesNumber series:String) {
        print("Received: \(name) for \(reps) reps - through \(series) drills")
        self.exerciseImage.image = image
        self.excersiceNameLabel.text = name
        self.repsNumberLabel.text = reps
        self.seriesNumberLabel.text = series
    }

}
