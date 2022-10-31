//
//  PhotoServicing.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 20/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit

protocol PhotosServicing {

    func fetchPhotos(completion: @escaping ([Photos]) -> Void)
}
