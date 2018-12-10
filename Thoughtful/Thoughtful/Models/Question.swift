//
//  Question.swift
//  Thoughtful
//
//  Created by Stephanie Pang on 11/9/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import Foundation
import UIKit

class Question: NSObject {
  
  // MARK: - Properties
  var id: Int!
  var question: String!
  var answer: String!
  var created_by: Int!
  var attachment: UIImage?
  
  // Mark: - General
  
  init(id: Int, question: String, answer: String, created_by: Int, attachment: UIImage?) {
    self.id = id
    self.question = question
    self.answer = answer
    self.created_by = created_by
    self.attachment = attachment
  }
  
  override init() {
    super.init()
  }
  
}
