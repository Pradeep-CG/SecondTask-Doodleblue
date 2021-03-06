//
//  SequenceTableViewCell.swift
//  Pradeep-SecondTask
//
//  Created by Pradeep on 04/07/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit

protocol SequenceCellDelegate:class {
    func selectedSequenceCell(cell:SequenceTableViewCell, didTappedEraseDown button:UIButton)
}
class SequenceTableViewCell: UITableViewCell {

    @IBOutlet weak var sequenceLbl: UILabel!
    @IBOutlet weak var serialNoLbl: UILabel!
    
    @IBOutlet weak var eraseBtn: UIButton!
    
    weak var delegate:SequenceCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onEraseBtnClicked(_ sender: Any) {
        
        let button = sender as! UIButton
        self.delegate?.selectedSequenceCell(cell: self, didTappedEraseDown: button)
    }
    
}
