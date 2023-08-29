//
//  NutritionTaskTableViewCell.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 29/08/2023.
//

import UIKit

class NutritionTaskTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func redraw(with request: Requete) {
        self.titleLabel.text = request.title
        self.typeLabel.text = "\(request.type)"
    }
    
}
