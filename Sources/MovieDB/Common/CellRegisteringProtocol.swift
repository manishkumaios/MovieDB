//
//  CellRegisteringProtocol.swift
//  
//
//  Created by MANISH KUMAR on 1/26/22.
//

import Foundation
import UIKit

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
        let bundle = Bundle(for: MovieListViewController.self)
        let nib = UINib.init(nibName: nibName, bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
    }
}

extension UIView {
    func addShadow(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner, fillColor: UIColor = .white) {
        
        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath //1
        shadowLayer.path = cgPath //2
        shadowLayer.fillColor = fillColor.cgColor //3
        shadowLayer.shadowColor = shadowColor.cgColor //4
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet //5
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        self.layer.addSublayer(shadowLayer)
    }
}

extension UIView {
    func configureAndStartShimmering() {
        backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.18)
        startShimmering()
    }
    
    func startShimmering() {
        
        let light = UIColor(white: 0, alpha: 0.1).cgColor
        let dark = UIColor.black.cgColor
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [dark, light, dark]
        gradient.frame = CGRect(x: -bounds.size.width, y: 0, width: 3 * bounds.size.width, height: bounds.size.height)
        
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint   = CGPoint(x: 1.0, y: 0.525)
        gradient.locations  = [0.4, 0.5, 0.6]
        
        layer.mask = gradient
        
        let animation: CABasicAnimation = CABasicAnimation.init(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue   = [0.8, 0.9, 1.0]
        
        animation.duration = 1.5
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.isRemovedOnCompletion = false
        
        gradient.add(animation, forKey: "shimmer")
    }
    
    func stopShimmering() {
        layer.mask = nil
    }
}
