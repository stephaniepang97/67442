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
  
  override init(){
    super.init()
  }
  
}
