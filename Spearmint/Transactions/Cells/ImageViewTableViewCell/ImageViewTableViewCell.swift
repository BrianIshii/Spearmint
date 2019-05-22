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
    weak var controlller: UIViewController?

    @IBOutlet weak var recieptImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func selectImage(_ sender: Any) {
        print("hi")
        
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        controlller!.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        controlller!.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        recieptImageView.image = selectedImage
        
        // Dismiss the picker.
        controlller!.dismiss(animated: true, completion: nil)
    }
}

