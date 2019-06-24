//
//  ImageViewTableViewCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/19/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class ImageViewTableViewCell: UITableViewCell, ReusableIdentifier {
    @IBOutlet weak var recieptImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension ImageViewTableViewCell: ConfigurableCell {
    func configure(object: Transaction) {
        recieptImageView.image = ImageStore.getImage(transactionID: object.id)
    }
    
    func configure() {
        recieptImageView.image = UIImage(imageLiteralResourceName: "default")
    }
}

