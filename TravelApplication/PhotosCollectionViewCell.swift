//
//  PhotosCollectionViewCell.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 17/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell, NibNameIdentifiable {

    @IBOutlet weak var imageViewCell: UIImageView!
    
    struct Input {
        let photo: UIImage
    }

    @IBOutlet private weak var photoImageView: UIImageView!

    func configure(with input: Input) {
        photoImageView.image = input.photo
    }

}
