//
//  ItemCell.swift
//  PharmacyTask
//
//  Created by Mohamed Kotb Saied Kotb on 18/07/2024.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var ndcLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var fullQuantityLabel: UILabel!
    @IBOutlet weak var partialQuantityLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    @IBOutlet weak var lotNumberLabel: UILabel!

    @IBOutlet weak var updateButton: UIButton!
    
    func configure(with item: Item) {
        ndcLabel.text = item.ndc
        descriptionLabel.text = item.description
        manufacturerLabel.text = item.manufacturer
        fullQuantityLabel.text = "\(item.fullQuantity)"
        partialQuantityLabel.text = "\(item.partialQuantity)"
        expirationDateLabel.text = item.expirationDate
        lotNumberLabel.text = item.lotNumber
    }
}
