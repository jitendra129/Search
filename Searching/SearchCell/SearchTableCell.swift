//
//  SearchTableCell.swift
//  DalmiaBestPrice
//
//  Created by dalmia on 26/07/19.
//  Copyright © 2019 dalmia. All rights reserved.
//

import UIKit

class SearchTableCell: UITableViewCell {
  @IBOutlet weak var lblSearch: UILabel!
      @IBOutlet weak var btnDelete: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
