//
//  JumbledTableViewCell.swift
//  Pradeep-SecondTask
//
//  Created by Pradeep on 04/07/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit

protocol QuestionCellDelegate:class {
    func customCell(cell:JumbledTableViewCell, didTappedDropDown button:UIButton)
}
class JumbledTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jumbledLbl: UILabel!
    weak var delegate:QuestionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onDropDownBtnClicked(_ sender: Any) {
        print("btn pressed")
        let button = sender as! UIButton
        self.delegate?.customCell(cell: self, didTappedDropDown: button)
    }
}
