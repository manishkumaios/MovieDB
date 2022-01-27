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
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
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
        posterView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0).isActive = true
        posterView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 8.0).isActive = true
        posterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0).isActive = true
        posterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8.0).isActive = true
        posterView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        self.addShadow(shadowColor: .darkGray, offSet: CGSize.init(width: self.bounds.width, height: 200.0), opacity: 0.8, shadowRadius: 8.0, cornerRadius: 8.0, corners: .allCorners)
        backgroundColor = .lightGray
        self.configureAndStartShimmering()
    }
    
    func configure(cellViewModel: PosterCellViewModel) {
        guard (posterView.image != nil) else {
            cellViewModel.fetchImage(callback: {(status, data) in
                DispatchQueue.main.async {
                    self.stopShimmering()
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
