//
//  AllHomeTableViewCell.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 30/08/2023.
//

import UIKit

class AllHomeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func redraw(with request: Requete) {
        self.titleLabel.text = request.title
        self.typeLabel.text = "\(request.type)"
    
    }
    
}
