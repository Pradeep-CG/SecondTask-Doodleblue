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
    var questionArray:[QuestionModel]?
    var dropdownArray = [Int]()
    var sequenceDictionary = [String:String]()
    var selectedRowIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionArray = Common.getQuestionModel()
        generateDropDownArray()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        questionTableView.addGestureRecognizer(tap)
        questionTableView.separatorColor = .clear
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    func generateDropDownArray() {
        
        for item in 0..<questionArray!.count {
            dropdownArray.append(item + 1)
        }
        print("dropdown array = \(dropdownArray)")
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
       if let viewWithTag = self.view.viewWithTag(101) {
            viewWithTag.removeFromSuperview()
            self.selectedRowIndex = -1
        }
    }
}

extension QuestionViewController: QuestionCellDelegate{
    
    func selectedQuestionCell(cell: JumbledTableViewCell, didTappedDropDown button: UIButton) {
        
        if let viewWithTag = self.view.viewWithTag(101) {
            viewWithTag.removeFromSuperview()
        }
        
        guard let indexPath = self.questionTableView.indexPath(for: cell) else { return }
        print("Button tapped on row \(indexPath.row)")
        
        if indexPath.row == selectedRowIndex {
            self.selectedRowIndex = -1
        }
        else{
            self.selectedRowIndex = indexPath.row
            
            let buttonFrame = button.frame
            var showRect    = cell.convert(buttonFrame, to: self.questionTableView)
            showRect        = self.questionTableView.convert(showRect, to: view)
            
            let yCord = (showRect.origin.y + showRect.size.height)
            
            print("rect \(showRect)")
            print("y = \(showRect.origin.y)")
            print("yCord = \(yCord)")
            
            var yCoordinate:CGFloat = 0.0
            let widthValue:CGFloat = 50.0
            let heightValue:CGFloat = 30 * CGFloat(dropdownArray.count)
            let buttonHeight:CGFloat = 30.0
            
            let dropDownView = UIView.init(frame: CGRect(x: showRect.origin.x - 45, y: yCord, width: widthValue, height: heightValue))
            dropDownView.tag = 101
            dropDownView.backgroundColor = .purple
            dropDownView.layer.borderWidth = 1
            dropDownView.layer.borderColor = UIColor.gray.cgColor
            
            for item in 0..<dropdownArray.count {
                let button = UIButton.init(frame: CGRect(x: 0, y: yCoordinate, width: widthValue, height: buttonHeight))
                button.setTitle("\(dropdownArray[item])", for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.backgroundColor = .yellow
                button.tag = item
                button.addTarget(self, action: #selector(self.onDropDownBtnClicked), for: .touchUpInside)
                dropDownView.addSubview(button)
                
                yCoordinate = yCoordinate + buttonHeight
                
                let label = UILabel.init(frame: CGRect(x: 0, y: yCoordinate - 1, width: widthValue, height: 1))
                label.backgroundColor = .lightGray
                dropDownView.addSubview(label)
            }
            self.view.addSubview(dropDownView)
            //self.questionTableView.addSubview(dropDownView)
        }
    }
    
   @objc func onDropDownBtnClicked(sender: UIButton!) {
       
      print("button tag =\(sender.tag)")
    let selectedValue = sender.tag
    questionArray?[selectedRowIndex].serialNo = "\(dropdownArray[selectedValue])"
     
    //self.questionTableView.reloadRows(at: [IndexPath(row: selectedRowIndex, section: 0)], with: .automatic)
    self.sequenceDictionary["\(dropdownArray[selectedValue])"] = questionArray?[selectedRowIndex].question
    
    // self.questionTableView.reloadRows(at: [IndexPath(row: sequenceIndex, section: 1)], with: .automatic)
    self.questionTableView.reloadData()
    dropdownArray.remove(at: sender.tag)
     print("removed array = \(dropdownArray)")
    
      if let viewWithTag = self.view.viewWithTag(101) {
          viewWithTag.removeFromSuperview()
          self.selectedRowIndex = -1
      }
   }
}

extension QuestionViewController: sequeceCellDelegate{
    func selectedSequenceCell(cell: SequenceTableViewCell, didTappedEraseDown button: UIButton) {
        
    }
}

extension QuestionViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .gray
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)
        label.textAlignment = .center
        label.textColor = .white
        
        if section == 0 {
            label.text = "Use the dropdown to set the correct order"
        }
        else{
            label.text = "Ordered in the corrent sequence"
        }
        label.font = UIFont(name: "futuraPTMediumFont", size: 16) // my custom font
       //f label.textColor = UIColor.gray// my custom colour

        headerView.addSubview(label)

        return headerView
    }
    /*
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        footerView.backgroundColor = .gray
        return footerView
    }*/
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArray!.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "jumbledCell", for: indexPath) as! JumbledTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            cell.cellData = questionArray![indexPath.row]
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "sequenceCell", for: indexPath) as! SequenceTableViewCell
            cell.selectionStyle = .none
            cell.serialNoLbl.text = "\(indexPath.row + 1)."
            if let question = sequenceDictionary["\(indexPath.row + 1)"] {
                cell.sequenceLbl.text = question
                cell.eraseBtn.isHidden = false
            }
            else{
                cell.sequenceLbl.text = " "
                cell.eraseBtn.isHidden = true
            }
            return cell
        }
    }
    /*
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 60.0
        }
        else{
            return 0.0
        }
    }
*/
}
