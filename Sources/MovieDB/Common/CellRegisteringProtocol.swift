//
//  CellRegisteringProtocol.swift
//  
//
//  Created by MANISH KUMAR on 1/26/22.
//

import Foundation
import UIKit
#if SWIFT_PACKAGE
let resourceBundle = Bundle.module
#endif

protocol CellRegisteringProtocol {
    func registerCellWithNib(with aClass: AnyClass, for tableView: UITableView)
    func registerCellWithClass(with aClass: AnyClass, for tableView: UITableView)
}

extension CellRegisteringProtocol {
    func registerCellWithClass(with aClass: AnyClass, for tableView: UITableView) {
        let cellReuseIdentifier = String(describing: aClass)
        tableView.register(aClass, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    
    func registerCellWithNib(with aClass: AnyClass, for tableView: UITableView) {
        let cellReuseIdentifier = String(describing: aClass)
        self.registerCellWithNib(with: aClass, cellReuseIdentifier: cellReuseIdentifier, for: tableView)
    }
  
    private func registerCellWithNib(with aClass: AnyClass, cellReuseIdentifier: String, for tableView: UITableView) {
        let nibName =  String(describing: aClass)
        let bundle = resourceBundle
        let nib = UINib.init(nibName: nibName, bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
    }
}

extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = 1.0 //targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )
        
        // Draw and return the resized UIImage
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(
                size: scaledImageSize
            )
            let scaledImage = renderer.image { _ in
                self.draw(in: CGRect(
                    origin: .zero,
                    size: scaledImageSize
                ))
            }
            
            return scaledImage
        } else {
          return self
        }
        
        
    }
}
