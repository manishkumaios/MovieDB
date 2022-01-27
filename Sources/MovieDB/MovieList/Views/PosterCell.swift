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
        posterView.heightAnchor.constraint(equalToConstant: 400.0).isActive = true
    }
    
    func configure(cellViewModel: PosterCellViewModel) {
        
        guard (posterView.image != nil) else {
            cellViewModel.fetchImage(callback: {(status, data) in
                DispatchQueue.main.async {
                    switch status {
                    case .success:
                        guard let data = data else { return}
                        let originalImage = UIImage.init(data: data)
                        let targetSize = CGSize(width: self.bounds.width, height: 400.0)
                        let scaledImage = originalImage?.scalePreservingAspectRatio(
                            targetSize: targetSize
                        )
                        self.posterView.image = scaledImage
                        self.layoutIfNeeded()
                    case .error(_):
                        break
                    }
                }
            })
            return
        }
    }
    
}
