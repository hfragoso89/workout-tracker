//
//  RoutineCollectionViewCell.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/27/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class RoutineCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var routineImageView: UIImageView!
    @IBOutlet weak var routineDetailsLabel: UILabel!
    @IBOutlet weak var routineNameShadowLabel: UILabel!
    @IBOutlet weak var routineNameLabel: UILabel!
    
    @IBOutlet weak var bookmarkView: UIView!
    @IBOutlet weak var bookmarkImageView: UIImageView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    func setUpUI(withRoutineName name:String, routineDetails details:String, andBackGroundImage image: UIImage) {
        self.routineNameLabel.text = name
        self.routineNameShadowLabel.text = name
        self.routineDetailsLabel.text = details
        routineImageView.image = image
    }
    
    func setCellTint(_ color:UIColor){
        self.routineDetailsLabel.backgroundColor = color
        self.bookmarkImageView.tintColor = color
    }
    
    func showDateBookmark(with date:Date) {
        let formater = DateFormatter()
        formater.locale = Locale.current
        formater.dateStyle = .medium
        self.numberLabel.text = formater.calendar.dateComponents([Calendar.Component.day], from: date).description
        self.numberLabel.text = formater.calendar.dateComponents([Calendar.Component.month], from: date).description
        self.bookmarkView.isHidden = false
    }
    
    
    
}
