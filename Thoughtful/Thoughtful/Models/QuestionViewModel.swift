//
//  QuestionViewModel.swift
//  Thoughtful
//
//  Created by Stephanie Pang on 11/9/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// MARK: - QuestionViewModel for interacting with question API
class QuestionViewModel {
  
  var familyName: String
  
  init(familyName: String) {
    self.familyName = familyName
  }
  
  // MARK: - General
  var questions = [Question]()
  
  // MARK: - Saving & Loading Data
  
  func saveQuestion(question : Question) {
    let parameters = [
      "question": question.question,
      "answer": question.answer,
      "created_by": "1"
      ] as [String : String]
    
    Alamofire.upload(
      multipartFormData: { multipartFormData in
        for (key, value) in parameters {
          multipartFormData.append(value.data(using: .utf8)!, withName: key)
        }
        
        if let image = question.attachment {
          let imageData = UIImageJPEGRepresentation(image, 0.5)!
          multipartFormData.append(imageData, withName: "attachment", mimeType: "image/jpg")
        }
    },
      to: "https://thoughtfulapi.herokuapp.com/questions",
      encodingCompletion: { encodingResult in
        switch encodingResult {
        case .success(let upload, _, _):
          upload.responseJSON { response in
            debugPrint(response)
            print(response)
          }
        case .failure(let encodingError):
          print(encodingError)
        }
    })
    
    self.questions.append(question)
  }
  

  func loadQuestions(tableViewController: QuestionsController) {
  
    let quizVM = QuizViewModel(familyName: self.familyName)
    quizVM.fetchQuestions {
      self.questions = quizVM.questions
      tableViewController.tableView.reloadData()
    }
  }
}
