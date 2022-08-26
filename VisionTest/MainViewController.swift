//
//  ViewController.swift
//  VisionTest
//
//  Created by blackRaven on 2022/08/25.
//

import UIKit
import Vision

class MainViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var imageOrientation = CGImagePropertyOrientation(.up)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = UIImage(named: "group") {
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            imageOrientation = CGImagePropertyOrientation(image.imageOrientation)
            
            guard let cgImage = image.cgImage else { return }
            
            setupVision(image: cgImage)
        }
    }
    
    private func setupVision(image: CGImage) {
        let faceDetectionRequest = VNDetectFaceRectanglesRequest(completionHandler: self.handleFaceDetectionRequest)
        
        let imageRequestHandler = VNImageRequestHandler(cgImage: image, orientation: imageOrientation, options: [:])
        
        do {
            try imageRequestHandler.perform([faceDetectionRequest])
        } catch let error as NSError {
            print(error)
            return
        }
    }
    
    private func handleFaceDetectionRequest( request: VNRequest?, error: Error?) {
        if let requestError = error as NSError? {
            print(requestError)
            return
        }
        
        guard let image = imageView.image else { return }
        guard let cgImage = image.cgImage else { return }
        
        
        
        let imageRect = self.determineScale(cgImage: cgImage, imageViewFrame: imageView.frame)
        
        self.imageView.layer.sublayers = nil
        
        if let results = request?.results as? [VNFaceObservation] {
            for observation in results {
                let faceRect = convertUnitToPoint(originalImageRect: imageRect, targetRect: observation.boundingBox)
                
                let titleRect = CGRect(x: faceRect.origin.x,
                                       y: faceRect.origin.y - 5,
                                       width: faceRect.size.width + 5,
                                       height: faceRect.size.height + 5)
                
                let textLayer = CATextLayer()
                textLayer.string = "🐦"
                textLayer.fontSize = faceRect.width
                textLayer.frame = titleRect
                textLayer.contentsScale = UIScreen.main.scale
                
                self.imageView.layer.addSublayer(textLayer)
            }
        }
    }


}

