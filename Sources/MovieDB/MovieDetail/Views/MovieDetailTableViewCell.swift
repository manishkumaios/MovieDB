//
//  MovieDetailTableViewCell.swift
//  
//
//  Created by MANISH KUMAR on 1/26/22.
//

import UIKit



class MovieDetailTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var taglineLabel: UILabel!
    @IBOutlet var posterView: UIImageView!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var releaseStatusLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureUI(cellViewModel: MovieDetailCellViewModel) {
        defer {
            layoutIfNeeded()
        }
        titleLabel.text = cellViewModel.movie.title
        taglineLabel.text = cellViewModel.movie.tagline
        overviewLabel.text = cellViewModel.movie.overview
        releaseDateLabel.text = "Release date \(cellViewModel.movie.releaseDate)"
        releaseStatusLabel.text = cellViewModel.movie.status
        
        guard (posterView.image != nil) else {
            cellViewModel.fetchImage(callback: {(status, data) in
                DispatchQueue.main.async {
                    switch status {
                    case .success:
                        guard let data = data else { return}
                        let originalImage = UIImage.init(data: data)
                        let targetSize = CGSize(width: self.bounds.width, height: 120)
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
