//
//  ManualSettingViewController.swift
//  PhotoEditorForPassport
//
//  Created by Pawan iOS on 04/10/2022.
//

import UIKit
import AVFoundation

class ManualSettingViewController: UIViewController {
    
    // MARK: - IBOutlets, Variables & Constants
    @IBOutlet weak var frameImage: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headSize: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var widht: UILabel!
    
    var  minZoomScale:CGFloat!
    var  mainImage: UIImage?
    var  userheadSize: String?
    var  userwidht: String?
    var  userheight: String?
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainImageView.image = mainImage
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 5
        
        headSize.text = ("Head \(userheadSize!)%")
        headSize.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        let widhtDouble = Double(userwidht!)
        let converUserWidht = round(96.0 * widhtDouble! / 2.54)
        widht.text = ("\(converUserWidht)px")
        
        let heightDouble = Double(userheight!)
        let converUserHeight = round(96.0 * heightDouble! / 2.54)
        heightLbl.text = ("\(converUserHeight)px")
        heightLbl.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        navigationItem.title = "Crop"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextAddButtonTapped))
        
        scrollView.contentOffset.y = scrollView.frame.height/4
        
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 53/255.0, green: 152/255.0, blue: 219/255.0, alpha: 1.0)
        
        navigationController?.navigationBar.backgroundColor = UIColor(displayP3Red: 53/255.0, green: 152/255.0, blue: 219/255.0, alpha: 1.0)
      
    }
    
    // MARK: - Selectors
    @objc func nextAddButtonTapped(sender: UIBarButtonItem) {
        
        let gridToImage = self.frameImage.convert(self.frameImage.bounds, to: self.mainImageView)
        let croppedImage = self.mainImageView.snapshot(of: gridToImage)
        
        let removeBackGroundViewController = RemoveBackgroundViewController()
        removeBackGroundViewController.bgRemoveImage = croppedImage
        navigationController?.pushViewController(removeBackGroundViewController, animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension ManualSettingViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first as? UIImageView
    }
}

// MARK: - UIView
extension UIView {
    /// Create image snapshot of view.
    func snapshot(of rect: CGRect? = nil) -> UIImage {
        return UIGraphicsImageRenderer(bounds: rect ?? bounds).image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
}
