//
//  PhotosCollectionViewModeling.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 20/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

protocol PhotosCollectionViewModeling {

    var didUpdatePhotos: (() -> Void)? { get set }

    func updatePhotos()
    func numberOfPhotos() -> Int
    func photo(at index: Int) -> Photos

}
