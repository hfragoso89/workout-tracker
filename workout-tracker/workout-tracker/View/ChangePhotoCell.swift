//
//  ChangePhotoCell.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/21/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class ChangePhotoCell: UITableViewCell {
    
    @IBOutlet weak var photoPlaceHolder: UIImageView!
    @IBOutlet weak var photoActionImage: UIImageView!
    @IBOutlet weak var photoImage: UIImageView!
    
    var photo:UIImage? {
        didSet {
            if self.photo != nil {
                photoImage.image = nil
                photoImage.isHidden = true
                photoPlaceHolder.image = UIImage(named: "camera.circle")
                photoActionImage.image = UIImage(named: "plus.circle.fill")
            } else {
                photoImage.image = photo
                photoImage.isHidden = false
                photoPlaceHolder.image = UIImage(named: "Ring")
                photoActionImage.image = UIImage(named: "pencil.circle.fill")
            }
            self.setNeedsDisplay()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photoImage.layer.cornerRadius = 45.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func photoActionPressed(_ sender: UIButton) {
    }
    
    
}
