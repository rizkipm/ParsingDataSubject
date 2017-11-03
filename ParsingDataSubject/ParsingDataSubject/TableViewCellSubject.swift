//
//  TableViewCellSubject.swift
//  ParsingDataSubject
//
//  Created by Rizki Syaputra on 11/3/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit

class TableViewCellSubject: UITableViewCell {

    @IBOutlet weak var labelSubject: UILabel!
    @IBOutlet weak var labelId: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
