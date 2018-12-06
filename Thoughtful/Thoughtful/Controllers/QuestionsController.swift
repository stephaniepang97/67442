//
//  QuestionsViewController.swift
//  Thoughtful
//
//  Created by Stephanie Pang on 11/9/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import UIKit

class QuestionsController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddQuestionControllerDelegate {
  
  // MARK: - Properties
  var questionsVM = QuestionViewModel()
  @IBOutlet var customTabBarView: UIView!
  @IBOutlet var tableView: UITableView!

  // MARK: - General
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.setNavigationBarHidden(true, animated: true)
    self.tableView.separatorStyle = .none
    self.tableView.delegate = self
    
    customTabBarView.frame.size.width = self.view.frame.width
    customTabBarView.frame.origin.y = self.view.frame.height-customTabBarView.frame.height
    customTabBarView.backgroundColor = UIColor(white: 1, alpha: 0)
    self.view.addSubview(customTabBarView)
    
    questionsVM.loadQuestions(tableViewController: self)
    print("question: \(String(describing: questionsVM.questions))")
    let cellNib = UINib(nibName: "QuestionTableCell", bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: "cell")
  }
  
  @IBAction func unwindToQuestions(segue: UIStoryboardSegue) {
  }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsVM.questions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuestionTableCell
    
      let question = questionsVM.questions[indexPath.row]
      // Configure the cell...
      cell.question?.text = question.question
      cell.answer?.text = question.answer

      return cell
    }

    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      self.performSegue(withIdentifier: "showDetail", sender: tableView)
    }
  
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if (segue.identifier == "showDetail") {
        let qdvc = segue.destination as! QuestionDetailViewController
        if let indexPath = self.tableView.indexPathForSelectedRow {
          let question = questionsVM.questions[indexPath.row]
          qdvc.detailItem = question
        }
      } else if segue.identifier == "addQuestion" {
        let navigationController = segue.destination as! UINavigationController
        let controller = navigationController.topViewController as! AddQuestionController
        controller.delegate = self
      }
    }
  
  // MARK: - Delegate protocols
  func addQuestionControllerDidCancel(controller: AddQuestionController) {
    dismiss(animated: true, completion: nil)
  }
  
  func addQuestionController(controller: AddQuestionController, didFinishAddingQuestion question: Question) {
    let newRowIndex = questionsVM.questions.count
    
    questionsVM.saveQuestion(question: question)
    
    let indexPath = NSIndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths as [IndexPath], with: .automatic)
    
    dismiss(animated: true, completion: nil)
  }
 

}
