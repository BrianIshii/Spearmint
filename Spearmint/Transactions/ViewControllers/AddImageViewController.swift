//
//  AddImageViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit
import FirebaseMLVision

class AddImageViewController: UIViewController, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var textRecognizer: VisionTextRecognizer!
    weak var previous: AddTransactionViewController?
    weak var addContentsViewController: AddContentsFromImageViewController?
    var visionTextBlocks: [VisionTextBlock]?

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewHeightContraint: NSLayoutConstraint!
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
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        addContentsViewController!.saveItems()
        previous!.unwindFromImage(self)
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        for subview in self.selectedImageView.subviews {
            subview.removeFromSuperview()
        }
        
        updateStackViewHeightContraint()
        
        coordinator.animate(alongsideTransition: nil, completion: {
            _ in

            guard let visionTextBlocks = self.visionTextBlocks else { return }

            DispatchQueue.main.async {

            self.addFrames(visionTextBlocks)
            }

        })
    }
    // MARK: - Navigation

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? AddContentsFromImageViewController {
            addContentsViewController = vc
            vc.previousVC = self
        } else if let vc = segue.destination as? AddBudgetItemsViewController {
            vc.budgetDate = Budget.dateToString(Date())
        }
    }
 
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
        
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        
        selectedImageView.image = selectedImage
        image = selectedImage
        print(selectedImage.size.height)
        
        let aspectRatio = selectedImage.size.height / selectedImage.size.width
        let height: CGFloat = 90
        
        stackViewHeightContraint.constant = height + aspectRatio * self.view.frame.width
        
        //uncomment to get text of image
        let visionImage = VisionImage(image: selectedImageView.image!)
        textRecognizer.process(visionImage) { (features, error) in
            self.processResult(from: features, error: error)
        }
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func updateStackViewHeightContraint() {
        guard let image = image else { return }

        let aspectRatio = image.size.height / image.size.width
        let height: CGFloat = 90
        
        stackViewHeightContraint.constant = height + aspectRatio * self.view.frame.height
        
    }
    
    func selectImage() {
        let imagePickerController = UIImagePickerController()
        
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func processResult(from text: VisionText?, error: Error?) {
        guard let features = text else { return }
        
        visionTextBlocks = features.blocks
        addFrames(features.blocks)
    }
    
    func addFrames(_ blocks: [VisionTextBlock]) {
        for block in blocks {
            for line in block.lines {
                for element in line.elements {
                    //print(element.text + element.frame.debugDescription)
                    let transformedRect = element.frame.applying(transformMatrix())
                    
                    let view = ImageFrameView(frame: transformedRect)
                    view.backgroundColor = .blue
                    view.alpha = 0.3
                    view.text = element.text
                    selectedImageView.addSubview(view)
                    
                    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
                    
                    gestureRecognizer.delegate = self
                    view.addGestureRecognizer(gestureRecognizer)
                }
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func handleTap(_ sender: Any) {
        if let gesture = sender as? UITapGestureRecognizer,
            let view = gesture.view as? ImageFrameView {
            if let vc = addContentsViewController, let text = view.text {
                if vc.textField.isHidden {
                    for cell in vc.tableView.visibleCells {
                        if let cell = cell as? ItemTableViewCell {
                            if cell.textField.isEditing {
                                cell.textField.text?.append(" \(text)")
                            } else if cell.nameTextField.isEditing {
                                cell.nameTextField.text?.append(" \(text)")
                            }
                            vc.saveItems()
                        }
                    }
                } else {
                    vc.textField.text?.append(" \(text)")
                    vc.update()
                }
            }
//            print(view.text)
        }
    }
    
    private func transformMatrix() -> CGAffineTransform {
        guard let image = selectedImageView.image else { return CGAffineTransform() }
        
        let imageViewWidth = selectedImageView.frame.size.width
        let imageViewHeight = selectedImageView.frame.size.height
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        
        let imageViewAspectRatio = imageViewWidth / imageViewHeight
        let imageAspectRatio = imageWidth / imageHeight
        let scale = (imageViewAspectRatio > imageAspectRatio) ?
            imageViewHeight / imageHeight :
            imageViewWidth / imageWidth
        
        // Image view's `contentMode` is `scaleAspectFit`, which scales the image to fit the size of the
        // image view by maintaining the aspect ratio. Multiple by `scale` to get image's original size.
        let scaledImageWidth = imageWidth * scale
        let scaledImageHeight = imageHeight * scale
        let xValue = (imageViewWidth - scaledImageWidth) / CGFloat(2.0)
        let yValue = (imageViewHeight - scaledImageHeight) / CGFloat(2.0)
        
        var transform = CGAffineTransform.identity.translatedBy(x: xValue, y: yValue)
        transform = transform.scaledBy(x: scale, y: scale)
        return transform
    }


}
