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
    
    var inputType:inputType = .undefined
    var delegate:EditableUserComponentCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(forComponent component:String, withValue value:String, andInputType type:inputType) {
        self.componenNametLabel.text = component
        self.componentValueLabel.text = value
        self.textField.placeholder = component
        self.inputType = type
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch self.inputType {
        case .text:
            return true
        case .date:
            if let myDelegate = self.delegate {
                myDelegate.callDateSelector(forField: textField)
            }
            return false
        case .height:
            if let myDelegate = self.delegate {
                myDelegate.callHeightSelector(forField: textField)
            }
            return false
        case .weight:
            if let myDelegate = self.delegate {
                myDelegate.callWeihgtSelector(forField: textField)
            }
            return false
        default:
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}

enum inputType {
    case text
    case date
    case height
    case weight
    case undefined
}

protocol EditableUserComponentCellDelegate {

    func callDateSelector(forField field:UITextField)
    func callHeightSelector(forField field:UITextField)
    func callWeihgtSelector(forField field:UITextField)
    
//    func dateSelectorDismissed() -> String
//    func heightSelectorDismissed() -> String
//    func weightSelectorDismissed() -> String
}
