//
//  EditableUserComponentCell.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/21/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class EditableUserComponentCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var componenNametLabel: UILabel!
    @IBOutlet weak var componentValueLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var editImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(forComponent component:String, withValue value:String) {
        self.componenNametLabel.text = component
        self.componentValueLabel.text = value
    }
    
    @IBAction func editComponent(_ sender: Any) {
        componentValueLabel.isHidden = true
        textField.text = componentValueLabel.text
        textField.isHidden = false
        editImage.isHidden = true
        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        componentValueLabel.isHidden = false
        componentValueLabel.text = textField.text
        self.textField.isHidden = true
        editImage.isHidden = false
    }
    
}
