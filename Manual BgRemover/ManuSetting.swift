//
//  ViewController.swift
//  PhotoCrop
//
//  Created by Bassel Ezzeddine on 12/08/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import UIKit

class ManuSetting: UIViewController {
    
    // MARK: - Outlets
    
    var mainImage: UIImage?
      
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.minimumZoomScale = 1
            scrollView.maximumZoomScale = 2
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var view_crop: UIView! {
        didSet {
           // view_crop.layer.cornerRadius = 5
           // view_crop.layer.borderWidth = 3
          //  view_crop.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK: - Actions
    @IBAction func button_crop_clicked(_ sender: Any) {
       
        guard let imageToCrop = imageView.image else {
            return
        }
        
        let cropRect = CGRect(x: view_crop.frame.origin.x - imageView.realImageRect().origin.x,
                              y: view_crop.frame.origin.y - imageView.realImageRect().origin.y,
                              width: view_crop.frame.width,
                              height: view_crop.frame.height)
        
        let croppedImage = ImageCropHandler.sharedInstance.cropImage(imageToCrop,
                                                                     toRect: cropRect,
                                                                     imageViewWidth: imageView.frame.width,
                                                                     imageViewHeight: imageView.frame.height)
        imageView.image = croppedImage
        scrollView.zoomScale = 1
    }
}

// MARK: - UIScrollViewDelegate
extension ManuSetting: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
