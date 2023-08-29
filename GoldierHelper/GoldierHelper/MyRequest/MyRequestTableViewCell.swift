//
//  MyRequestTableViewCell.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 27/08/2023.
//

import UIKit

class MyRequestTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var acceptedLabel: UILabel!
    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
}
