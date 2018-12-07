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

extension NSMutableData {
  func appendString(_ string: String) {
    let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
    append(data!)
  }
}

// MARK: - QuestionViewModel for interacting with question API
class QuestionViewModel {
  
  var familyName: String
  
  init(familyName: String) {
    self.familyName = familyName
  }
  
  // MARK: - General
  var questions = [Question]()
  
  // MARK: - Saving & Loading Data
  func createBody(parameters: [String: String],
                  boundary: String,
                  data: Data,
                  mimeType: String,
                  filename: String) -> Data {
    let body = NSMutableData()
    
    let boundaryPrefix = "--\(boundary)\r\n"
    
    for (key, value) in parameters {
      body.appendString(boundaryPrefix)
      body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
      body.appendString("\(value)\r\n")
    }
    
    body.appendString(boundaryPrefix)
    body.appendString("Content-Disposition: form-data; name=\"attachment\"; filename=\"\(filename)\"\r\n")
    body.appendString("Content-Type: \(mimeType)\r\n\r\n")
    body.append(data)
    body.appendString("\r\n")
    body.appendString("--".appending(boundary.appending("--")))
    
    return body as Data
  }
  
  func saveQuestion(question : Question) {
    
    var r  = URLRequest(url: URL(string: "https://thoughtfulapi.herokuapp.com/questions")!)
    r.httpMethod = "POST"
    let boundary = "Boundary-\(UUID().uuidString)"
    r.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    let params = [
      "question": question.question,
      "answer": question.answer,
      "created_by": String(question.created_by)
      ] as [String : String]
    
    if let image = question.attachment {
      r.httpBody = createBody(parameters: params,
                              boundary: boundary,
                              data: (UIImageJPEGRepresentation(image, 0.7))!,
                              mimeType: "image/jpg",
                              filename: "attachment.jpg")
    }
    
    NSURLConnection.sendAsynchronousRequest(r, queue: OperationQueue.main) {(response, data, error) in
      guard let data = data else { return }
      print(String(data: data, encoding: .utf8)!)
    }
    
    self.questions.append(question)
  }
  
//  Not working with AlamoFire for some reason
  func saveQuestionUsingAlamofire(question : Question) {
    let parameters = [
      "question": question.question,
      "answer": question.answer,
      "created_by": String(question.created_by)
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
	quizVM.fetchQuestions(completion: {
		self.questions = quizVM.questions
		tableViewController.tableView.reloadData()
	}, pictureCallback: {})
  }
}
