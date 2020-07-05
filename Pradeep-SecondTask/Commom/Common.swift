//
//  Common.swift
//  Pradeep-SecondTask
//
//  Created by Pradeep on 05/07/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import Foundation

struct Common {
    
    static var questionArray = [QuestionModel]()
    
    static func getQuestionModel() -> [QuestionModel] {
        
        questionArray.append(QuestionModel(serialNo: "", question: "This is the third sentence"))
        questionArray.append(QuestionModel(serialNo: "", question: "This is the second sentence, example of having more words when compared to the first one"))
        questionArray.append(QuestionModel(serialNo: "", question: "This is the seventh sentence, example of having more words when compared to the sixth one"))
        questionArray.append(QuestionModel(serialNo: "", question: "This is the first sentence, example of having more words when compared to the third one"))
        questionArray.append(QuestionModel(serialNo: "", question: "This is the sixth sentence"))
        questionArray.append(QuestionModel(serialNo: "", question: "This is the fifth sentence, example of having more words when compared to the fourth one"))
        questionArray.append(QuestionModel(serialNo: "", question: "This is the fourth sentence"))
        
        return questionArray
    }
}
