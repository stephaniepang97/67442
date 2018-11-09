//
//  QuestionTableCell.swift
//  Thoughtful
//
//  Created by Stephanie Pang on 11/9/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import UIKit

class QuestionTableCell: UITableViewCell {
  
  @IBOutlet weak var question: UILabel!
  @IBOutlet weak var answer: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
