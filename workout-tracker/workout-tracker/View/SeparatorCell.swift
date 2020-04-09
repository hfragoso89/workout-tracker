//
//  SeparatorCell.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/27/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class SeparatorCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUI(withTitle title:String, andCellType type:SeparatorCellType) {
        self.titleLabel.text = title
        self.iconImageView.image = UIImage(systemName: type.rawValue)
    }
    
    func setCellTint(_ color:UIColor){
        iconImageView.tintColor = color
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

enum SeparatorCellType:String {
    case downArrow="down.arrow"
    case upArrow="up.arrow"
    case person="person.crop.circle"
    case personFilled="person.crop.circle.fill"
}
