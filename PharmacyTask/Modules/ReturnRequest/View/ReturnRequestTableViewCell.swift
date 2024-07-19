//
//  ReturnRequestTableViewCell.swift
//  PharmacyTask
//
//  Created by Mohamed Kotb Saied Kotb on 18/07/2024.
//

import UIKit

class ReturnRequestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ReturnRequestsCellView: UIView!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var numOfItemsLabel: UILabel!
    
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var serviceTypeLabel: UILabel!
    
    
    @IBOutlet weak var assosiatedLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
