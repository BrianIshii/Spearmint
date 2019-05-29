//
//  AddImageViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit
import FirebaseMLVision

class AddImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var textRecognizer: VisionTextRecognizer!

    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let i = image {
            selectedImageView.image = i
        }
        
        let vision = Vision.vision()
        textRecognizer = vision.onDeviceTextRecognizer()
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        selectedImageView.isUserInteractionEnabled = true
        selectedImageView.image = UIImage(imageLiteralResourceName: "default")

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onSelectImageView(_ sender: Any) {
        print("hi")
        selectImage()
    }
    
    @IBAction func takePicture(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        selectedImageView.image = selectedImage
        image = selectedImage
        
        //uncomment to get text of image
        let visionImage = VisionImage(image: selectedImageView.image!)
        textRecognizer.process(visionImage) { (features, error) in
            self.processResult(from: features, error: error)
        }
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func selectImage() {
        let imagePickerController = UIImagePickerController()
        
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func processResult(from text: VisionText?, error: Error?) {
        guard let features = text, let image = selectedImageView.image else { return }
        
        for block in text!.blocks {
            for line in block.lines {
                for element in line.elements {
                    print(element.text)
                }
            }
        }
    }

}
