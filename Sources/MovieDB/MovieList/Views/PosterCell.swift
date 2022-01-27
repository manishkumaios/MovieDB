//
//  PosterCell.swift
//  
//
//  Created by MANISH KUMAR on 1/26/22.
//

import UIKit

final class PosterCell: UITableViewCell {
    let posterView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 8
        img.clipsToBounds = true
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func prepareForReuse() {
        posterView.image = nil
    }
    
    private func setupUI() {
        contentView.addSubview(posterView)
        posterView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        posterView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        posterView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        posterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//        self.addShadow(shadowColor: .darkGray, offSet: self.intrinsicContentSize, opacity: 0.8, shadowRadius: 8.0, cornerRadius: 8.0, corners: .allCorners)
//        self.configureAndStartShimmering()
    }
    
    func configure(cellViewModel: PosterCellViewModel) {
        guard (posterView.image != nil) else {
            cellViewModel.fetchImage(callback: {(status, data) in
                DispatchQueue.main.async {
                   // self.stopShimmering()
                    switch status {
                    case .success:
                        guard let data = data else { return}
                        self.posterView.image = UIImage.init(data: data)
                    case .error(_):
                        break
                    }
                }
            })
            return
        }
    }
    
}
