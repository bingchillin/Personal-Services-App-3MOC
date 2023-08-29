//
//  AllRequestTableViewCell.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 27/08/2023.
//

import UIKit

class AllRequestTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    func redraw(with request: Requete) {
        self.titleLabel.text = request.title
        self.typeLabel.text = "\(request.type)"
    }
}
