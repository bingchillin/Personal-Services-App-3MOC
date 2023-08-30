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
    
    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet weak var acceptedLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func redraw(with request: Requete) {
        self.titleLabel.text = request.title
        self.typeLabel.text = "\(request.type)"
        
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
