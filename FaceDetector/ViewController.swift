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
        imageView.frame = CGRect(x: 0, y: 40, width: self.view.frame.width, height: imageViewHeight)
        view.addSubview(imageView)
        
        
        
    }


}

