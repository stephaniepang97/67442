//
//  SessionDetailViewController.swift
//  Thoughtful
//
//  Created by Stephanie Pang on 12/6/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import UIKit

class SessionDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var startTimeLabel: UILabel!
  @IBOutlet weak var endTimeLabel: UILabel!
  @IBOutlet weak var percentCorrectLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet var customTabBarView: UIView!
  
  var detailItem: Session? {
    didSet {
      // Update the view.
      self.configureView()
    }
  }
  
  func configureView() {
    // Update the user interface for the detail item.
    if let detail: Session = self.detailItem {
      if let startTime = self.startTimeLabel {
        startTime.text = String(describing: detail.startTime)
      }
      if let endTime = self.endTimeLabel {
        endTime.text = String(describing: detail.endTime)
      }
      if let percentCorrect = self.percentCorrectLabel {
        percentCorrect.text = String(detail.percentCorrect) + "%"
      }
    }
  }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      self.configureView()
      self.navigationController?.setNavigationBarHidden(true, animated: true)
      customTabBarView.frame.size.width = self.view.frame.width
      customTabBarView.frame.origin.y = self.view.frame.height-customTabBarView.frame.height
      customTabBarView.backgroundColor = UIColor(white: 1, alpha: 0)
      self.view.addSubview(customTabBarView)
    }
  
  // MARK: - Table View properties
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let detail: Session = self.detailItem {
      return detail.incorrectQuestions.count
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "incorrectQuestionCell", for: indexPath) as! QuestionTableCell
    
    if let detail: Session = self.detailItem {
      let question = detail.incorrectQuestions[indexPath.row]
      // Configure the cell...
      cell.question?.text = String(describing: question.question)
      cell.answer?.text = String(describing: question.answer)
    }
    
    return cell
  }
}
