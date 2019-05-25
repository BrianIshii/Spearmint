//
//  VisionViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit
import FirebaseMLVision

class VisionViewController: UIViewController {

    var textRecognizer: VisionTextRecognizer!
    
    @IBOutlet weak var imageView: UIImageView!
    
    private lazy var annotationOverlayView: UIView = {
        precondition(isViewLoaded)
        let annotationOverlayView = UIView(frame: .zero)
        annotationOverlayView.translatesAutoresizingMaskIntoConstraints = false
        return annotationOverlayView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vision = Vision.vision()
        textRecognizer = vision.onDeviceTextRecognizer()
        
        imageView.image = UIImage(imageLiteralResourceName: "hi")
        imageView.addSubview(annotationOverlayView)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func buttonPressed(_ sender: Any) {
        
        let visionImage = VisionImage(image: imageView.image!)
        textRecognizer.process(visionImage) { (features, error) in
            self.processResult(from: features, error: error)
        }
    }
    
    func processResult(from text: VisionText?, error: Error?) {
        //removeFrames()
        //guard let features = text, let image = imageView.image else { return }
        guard let features = text, let image = imageView.image else { return }
        
        print("hi")
        let transform = self.transformMatrix()

        for block in text!.blocks {
            drawFrame(block.frame, in: .purple, transform: transform)
            
            // Lines.
            for line in block.lines {
                drawFrame(line.frame, in: .orange, transform: transform)
                
                // Elements.
                for element in line.elements {
                    print(element.text)
                    drawFrame(element.frame, in: .green, transform: transform)

                    let transformedRect = element.frame.applying(transform)


                    let label = UILabel(frame: transformedRect)
                    label.text = element.text
                    label.adjustsFontSizeToFitWidth = true
                    self.annotationOverlayView.addSubview(label)
                }
            }
        }
    }
    
    private func drawFrame(_ frame: CGRect, in color: UIColor, transform: CGAffineTransform) {
        let transformedRect = frame.applying(transform)
        addRectangle(
            frame,
            to: self.annotationOverlayView,
            color: color
        )
    }
    public func addRectangle(_ rectangle: CGRect, to view: UIView, color: UIColor) {
        let rectangleView = UIView(frame: rectangle)
        rectangleView.layer.cornerRadius = Constants.rectangleViewCornerRadius
        rectangleView.alpha = Constants.rectangleViewAlpha
        rectangleView.backgroundColor = color
        view.addSubview(rectangleView)
    }
    
    private func transformMatrix() -> CGAffineTransform {
        guard let image = imageView.image else { return CGAffineTransform() }
        let imageViewWidth = imageView.frame.size.width
        let imageViewHeight = imageView.frame.size.height
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
private enum Constants {
    static let circleViewAlpha: CGFloat = 0.7
    static let rectangleViewAlpha: CGFloat = 0.3
    static let shapeViewAlpha: CGFloat = 0.3
    static let rectangleViewCornerRadius: CGFloat = 10.0
}
