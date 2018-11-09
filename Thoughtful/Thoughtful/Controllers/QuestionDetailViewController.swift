//
//  QuestionDetailViewController.swift
//  Thoughtful
//
//  Created by Stephanie Pang on 11/9/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import UIKit

class QuestionDetailViewController: UIViewController {
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var answerLabel: UILabel!
  @IBOutlet weak var createdByLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  
  var detailItem: Question? {
    didSet {
      // Update the view.
      self.configureView()
    }
  }
  
  func configureView() {
    // Update the user interface for the detail item.
    if let detail: Contact = self.detailItem {
      if let name = self.nameLabel {
        name.text = detail.name
      }
      if let email = self.emailLabel {
        email.text = detail.email
      }
      if let workPhone = self.workPhoneLabel {
        workPhone.text = detail.workPhone
      }
      if let homePhone = self.homePhoneLabel {
        homePhone.text = detail.homePhone
      }
      if let imageView = self.imageView {
        imageView.image = detail.image
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    self.configureView()
  }
  
  

}
