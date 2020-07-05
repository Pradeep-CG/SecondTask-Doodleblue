//
//  JumbledTableViewCell.swift
//  Pradeep-SecondTask
//
//  Created by Pradeep on 04/07/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit

protocol QuestionCellDelegate:class {
    func selectedQuestionCell(cell:JumbledTableViewCell, didTappedDropDown button:UIButton)
}
class JumbledTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jumbledLbl: UILabel!
    
    weak var delegate:QuestionCellDelegate?
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var selectedNoLbl: UILabel!
    
    var cellData:QuestionModel?{
        didSet{
            jumbledLbl.text = cellData?.question
            let srNo = cellData?.serialNo ?? ""
            
            if srNo.isEmpty {
                selectedNoLbl.text = ""
                dropDownBtn.isHidden = false
            }
            else{
                selectedNoLbl.text = srNo
                dropDownBtn.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        jumbledLbl.layer.cornerRadius = 10
        jumbledLbl.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func onDropDownBtnClicked(_ sender: Any) {
        print("btn pressed")
        let button = sender as! UIButton
        self.delegate?.selectedQuestionCell(cell: self, didTappedDropDown: button)
    }
}
