//
//  NewsItemCell.swift
//  BCITBlurbBoard
//
//  Created by Matthew Banman on 2015-03-10.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//

import UIKit

class NewsItemCell: UITableViewCell {

    
    @IBOutlet weak var CellTitle: UILabel!
    @IBOutlet weak var MessagePreview: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Author: UILabel!
    @IBOutlet weak var CommentNum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
