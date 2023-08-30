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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    
    func redraw(with request: Requete) {
        self.titleLabel.text = request.title
        if request.type == 1{
            self.typeLabel.text = "Aide ménagère"
        }
        
        if request.type == 2{
            self.typeLabel.text = "Alimentation"
        }
    }
    
}
