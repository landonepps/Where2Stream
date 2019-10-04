//
//  ShowTableViewCell.swift
//  Where2Stream
//
//  Created by Landon Epps on 10/2/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {

    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var streamingServicesLabel: UILabel!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    
    func updateView(with show: Show) {
        imageActivityIndicator.isHidden = false
        imageActivityIndicator.startAnimating()
        showImageView.backgroundColor = UIColor.lightGray
        ShowsController.getImageFor(show: show) { image in
            DispatchQueue.main.async {
                self.imageActivityIndicator.isHidden = true
                self.imageActivityIndicator.stopAnimating()
                self.showImageView.image = image
                self.showImageView.backgroundColor = nil
            }
        }
        
        showTitleLabel.text = show.name
        
        let serviceNames = Set<String>(show.services.compactMap { $0.name })
        let sortedServiceNames = serviceNames.sorted()
        streamingServicesLabel.text = "Available on:\n\(sortedServiceNames.joined(separator: ", "))"
    }
}
