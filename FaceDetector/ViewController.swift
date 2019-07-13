//
//  ViewController.swift
//  FaceDetector
//
//  Created by Omar Alqabbani on 7/12/19.
//  Copyright © 2019 OmarALqabbani. All rights reserved.
//

import UIKit
import Vision


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let image = UIImage(named: "sample1") else {return}
        let imageViewHeight = view.frame.width * (image.size.height / image.size.width)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: imageViewHeight)
        view.addSubview(imageView)
        
        let request = VNDetectFaceRectanglesRequest { (req, error) in
            if let err = error {
                print("error in face detection", err)
                return
            }
            DispatchQueue.main.async {
                req.results?.forEach({ (res) in
                    if let result = res as? VNFaceObservation {
                        print(result.boundingBox)
                        let detectView = UIView()
                        detectView.backgroundColor = UIColor.red
                        detectView.alpha = 0.5
                        let imageViewStartingX: CGFloat = self.view.frame.width
                        let imageViewStartingY: CGFloat = imageView.frame.height
                        let x = imageViewStartingX * result.boundingBox.origin.x
                        let h = imageViewStartingY * result.boundingBox.height
                        let y = imageViewStartingY * (1 -  result.boundingBox.origin.y) - h
                        let w = imageViewStartingX * result.boundingBox.width
                        detectView.frame = CGRect(x: x, y: y, width: w, height: h)
                        self.view.addSubview(detectView)
                    }
                })
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            guard let cgImage = image.cgImage else { return }
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            do {
                try handler.perform([request])
            } catch let error {
                print("error in face detection", error)
                return
            }
        }
    }


}

