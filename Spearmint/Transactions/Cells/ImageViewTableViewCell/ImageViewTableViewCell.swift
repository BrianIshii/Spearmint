//
//  ImageViewTableViewCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/19/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class ImageViewTableViewCell: UITableViewCell, ReusableIdentifier, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    static let xib = "ImageViewTableViewCell"
    weak var controller: AddTransactionViewController?

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

    @IBAction func selectImage(_ sender: Any) {
        //controller!.selectImage()
    }
}

extension ImageViewTableViewCell: ConfigurableCell {
    func configure(object: BudgetItem) {
    }
    
    func configure() {
        
    }
}

