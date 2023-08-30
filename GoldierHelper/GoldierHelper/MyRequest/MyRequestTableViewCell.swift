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
    @IBOutlet weak var titleLabel: UILabel!
    
    func redraw(with request: Requete) {
        self.titleLabel.text = request.title
        if request.type == 1{
            self.typeLabel.text = "Aide ménagère"
        }
        
        if request.type == 2{
            self.typeLabel.text = "Alimentation"
        }
        
        if let accepted = request.accepted {
            self.acceptedLabel.text = accepted ? "Acceptée" : "Non acceptée"
        } else {
            self.acceptedLabel.text = "Non acceptée"
        }
        
        if let done = request.done {
            self.doneLabel.text = done ? "Terminée" : "Non terminée"
        } else {
            self.doneLabel.text = "Non terminée"
        }
    }
}
