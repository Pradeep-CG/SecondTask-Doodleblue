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
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.gray.cgColor, UIColor.white.cgColor, UIColor.white.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.questionTableView {
            if let viewWithTag = self.view.viewWithTag(101) {
                viewWithTag.removeFromSuperview()
                self.selectedRowIndex = -1
            }
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
            
            let yCord = (showRect.origin.y + showRect.size.height - 5)
            
            print("rect \(showRect)")
            print("y = \(showRect.origin.y)")
            print("yCord = \(yCord)")
            
            var yCoordinate:CGFloat = 0.0
            let widthValue:CGFloat = 50.0
            let heightValue:CGFloat = 30 * CGFloat(dropdownArray.count)
            let buttonHeight:CGFloat = 30.0
            
            let dropDownView = UIView.init(frame: CGRect(x: showRect.origin.x - 45, y: yCord, width: widthValue, height: heightValue))
            dropDownView.tag = 101
            dropDownView.layer.borderWidth = 1
            dropDownView.layer.borderColor = UIColor.white.cgColor
            dropDownView.layer.masksToBounds = false
            dropDownView.layer.shadowRadius = 4
            dropDownView.layer.shadowOpacity = 1
            dropDownView.layer.shadowColor = UIColor.gray.cgColor
            dropDownView.layer.shadowOffset = CGSize(width: 0 , height:2)
            
            for item in 0..<dropdownArray.count {
                let button = UIButton.init(frame: CGRect(x: 0, y: yCoordinate, width: widthValue, height: buttonHeight))
                button.setTitle("\(dropdownArray[item])", for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .gray
                button.tag = item
                button.addTarget(self, action: #selector(self.onDropDownBtnClicked), for: .touchUpInside)
                dropDownView.addSubview(button)
                
                yCoordinate = yCoordinate + buttonHeight
                
                let label = UILabel.init(frame: CGRect(x: 0, y: yCoordinate - 1, width: widthValue, height: 1))
                label.backgroundColor = .lightGray
                dropDownView.addSubview(label)
            }
            self.view.addSubview(dropDownView)
        }
    }
    
    @objc func onDropDownBtnClicked(sender: UIButton!) {
        
        print("button tag =\(sender.tag)")
        let selectedValue = sender.tag
        questionArray?[selectedRowIndex].serialNo = "\(dropdownArray[selectedValue])"
        self.sequenceDictionary["\(dropdownArray[selectedValue])"] = questionArray?[selectedRowIndex].question
        self.questionTableView.reloadData()
        dropdownArray.remove(at: sender.tag)
        print("removed array = \(dropdownArray)")
        
        if let viewWithTag = self.view.viewWithTag(101) {
            viewWithTag.removeFromSuperview()
            self.selectedRowIndex = -1
        }
    }
    
}

extension QuestionViewController: SequenceCellDelegate{
    
    func selectedSequenceCell(cell: SequenceTableViewCell, didTappedEraseDown button: UIButton) {
        
        guard let indexPath = self.questionTableView.indexPath(for: cell) else { return }
        print("Button tapped on row \(indexPath.row)")
        
        for item in 0..<questionArray!.count {
            if questionArray?[item].question == sequenceDictionary["\(indexPath.row + 1)"] {
                let serialNo = Int(questionArray?[item].serialNo ?? "0") ?? 0
                dropdownArray.append(serialNo)
                dropdownArray = dropdownArray.sorted()
                questionArray?[item].serialNo = ""
            }
        }
        sequenceDictionary["\(indexPath.row + 1)"] = nil
        self.questionTableView.reloadData()
        print(sequenceDictionary)
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
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        if section == 0 {
            label.text = "* The given statements are in jumbled order, Use the dropdown to set the correct order"
        }
        else{
            label.text = "Here the question will be ordered in the correct sequence"
        }
        label.font = UIFont(name: "futuraPTMediumFont", size: 16)
        
        headerView.addSubview(label)
        
        return headerView
    }

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
            cell.delegate = self
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
}
