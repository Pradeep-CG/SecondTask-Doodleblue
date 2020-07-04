//
//  JumbledTableViewCell.swift
//  Pradeep-SecondTask
//
//  Created by Pradeep on 04/07/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit

class JumbledTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jumbledLbl: UILabel!

    
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
    }
}
