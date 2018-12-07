//
//  SessionTableCell.swift
//  Thoughtful
//
//  Created by Stephanie Pang on 12/6/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import UIKit

class SessionTableCell: UITableViewCell {

  @IBOutlet weak var startTime: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }

}
