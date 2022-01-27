//
//  MovieDetailTableViewCell.swift
//  
//
//  Created by MANISH KUMAR on 1/26/22.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureUI(title: String, detail: String) {
        titleLabel.text = title
        detailLabel.text = detail
        accessibilityLabel = "\(title) + \(detail)"
        accessibilityTraits = .staticText
    }
}
