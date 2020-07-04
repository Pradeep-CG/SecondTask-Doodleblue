//
//  QuestionViewController.swift
//  Pradeep-SecondTask
//
//  Created by Pradeep on 04/07/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
}
extension QuestionViewController: QuestionCellDelegate{
    func customCell(cell: JumbledTableViewCell, didTappedDropDown button: UIButton) {
        
        if let viewWithTag = self.view.viewWithTag(101) {
            viewWithTag.removeFromSuperview()
        }
        //self.questionTableView.isUserInteractionEnabled = false
        /* Get the souce rect frame */
        let buttonFrame = button.frame
        var showRect    = cell.convert(buttonFrame, to: self.questionTableView)
        showRect        = self.questionTableView.convert(showRect, to: view)
        let yCord = (showRect.origin.y + showRect.size.height)
        print("rect \(showRect)")
        print("y = \(showRect.origin.y)")
        print("yCord = \(yCord)")
        
        let dropDownView = UIView.init(frame: CGRect(x: showRect.origin.x - 40, y: yCord, width: 50, height: 100))
        dropDownView.tag = 101
        dropDownView.backgroundColor = .green
        self.view.addSubview(dropDownView)
    }
    
}
extension QuestionViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .white
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)
        label.textAlignment = .center
        if section == 0 {
            label.text = "Use the dropdown to set the correct order"
        }
        else{
            label.text = "Ordered in the corrent sequence"
        }
        label.font = UIFont(name: "futuraPTMediumFont", size: 16) // my custom font
        label.textColor = UIColor.gray// my custom colour

        headerView.addSubview(label)

        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        footerView.backgroundColor = .blue
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "jumbledCell", for: indexPath) as! JumbledTableViewCell
            cell.delegate = self
            cell.jumbledLbl.layer.cornerRadius = 10
            cell.jumbledLbl.clipsToBounds = true
            
            if indexPath.row == 0 {
                cell.jumbledLbl.text = "This is third sentence"
            }
            if indexPath.row == 1 {
                cell.jumbledLbl.text = "This is second sentense ,example for having more words when compared to first one"
            }
            if indexPath.row == 2 {
                cell.jumbledLbl.text = "This is first sentense ,example for having more words when compared to first one,example for having more words when compared to first one, ,example for having more words when compared to first one"
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "sequenceCell", for: indexPath) as! SequenceTableViewCell
            if indexPath.row == 0 {
                cell.sequenceLbl.text = "This is third sentence"
            }
            if indexPath.row == 1 {
                cell.sequenceLbl.text = "This is second sentense ,example for having more words when compared to first one"
            }
            if indexPath.row == 2 {
                cell.sequenceLbl.text = "This is first sentense ,example for having more words when compared to first one,example for having more words when compared to first one, ,example for having more words when compared to first one"
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 60.0
        }
        else{
            return 0.0
        }
    }

}
