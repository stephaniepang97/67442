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
  
  // MARK: - General
  var questions = [Question]()
  
  init() {
    loadQuestions()
  }
  
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
          }
        case .failure(let encodingError):
          print(encodingError)
        }
    }
    )
    
    
      
  }
  
  // TODO: load only family's questions
  func loadQuestions() {
    Alamofire.request("https://thoughtfulapi.herokuapp.com/questions").responseJSON { response in
      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")                         // response serialization result
      
      if let json = response.result.value{
        let swiftyJson = JSON(json)
        if let qs = swiftyJson.arrayObject {
          for index in 0..<qs.count {
            let question = Question()
            let q = swiftyJson[index]
            question.question = q["question"].string
            question.answer = q["answer"].string
            question.created_by = q["user"]["user_id"].int
            
            if let attachmentUrl = q["attachment"]["url"].string {
              let imgUrl = URL(string: "https://thoughtfulapi.herokuapp.com" + attachmentUrl)
//              if let imgData = try? Data(contentsOf: imgUrl!){
//                question.attachment = UIImage(data: imgData)
//              }
              print("retrieving image from: \(String(describing: imgUrl!))")
              Alamofire.download(imgUrl!).responseData { response in
                if let data = response.result.value {
                  question.attachment = UIImage(data: data)
                }
              }
            }
            
            self.questions.append(question)
          }
        }
      }
    }
  }
}
