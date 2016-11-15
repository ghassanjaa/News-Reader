//
//  VCTableViewCell.swift
//  TripoliScopeNews
//
//  Created by Ghas San on 11/15/16.
//  Copyright © 2016 Ghassan Jaam. All rights reserved.
//

import UIKit

class VCTableViewCell: UITableViewCell {

    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var NewsLbl: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
