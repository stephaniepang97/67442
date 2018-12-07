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
      "created_by": question.created_by
      ] as [String : Any]
    
    Alamofire.upload(
      multipartFormData: { multipartFormData in
        for (key, value) in parameters {
          multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
        }
        
        if let image = question.attachment {
          let imageData = UIImagePNGRepresentation(image)!
          multipartFormData.append(imageData, withName: "attachment")
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
  
  // TODO: load only family's questions
  func loadQuestions(tableViewController: QuestionsController) {
//    Alamofire.request("https://thoughtfulapi.herokuapp.com/questions").responseJSON { response in
//      print("Request: \(String(describing: response.request))")   // original url request
//      print("Response: \(String(describing: response.response))") // http url response
//      print("Result: \(response.result)")                         // response serialization result
//
//      if let json = response.result.value{
//        let swiftyJson = JSON(json)
//        if let qs = swiftyJson.arrayObject {
//          for index in 0..<qs.count {
//            let question = Question()
//            let q = swiftyJson[index]
//      question.id = q["id"].int
//      question.question = q["question"].string
//            question.answer = q["answer"].string
//            question.created_by = q["user"]["user_id"].int
//
//            if let attachmentUrl = q["attachment"]["url"].string {
//              let imgUrl = URL(string: attachmentUrl)
//              Alamofire.request(imgUrl!).responseData { response in
//                print("response from image retrieval: \(String(describing: response))")
//                if let data = response.result.value {
//                  question.attachment = UIImage(data: data)
//                }
//              }
//            }
//
//            self.questions.append(question)
//          }
//        }
//      }
//      tableViewController.tableView.reloadData()
//
//    }
  
    let quizVM = QuizViewModel(familyName: self.familyName)
    quizVM.fetchQuestions {
      self.questions = quizVM.questions
      tableViewController.tableView.reloadData()
    }
  }
}
