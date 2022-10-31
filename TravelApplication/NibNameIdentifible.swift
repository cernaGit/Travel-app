//
//  NibNameIdentifible.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 17/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit

protocol NibNameIdentifiable {}

extension NibNameIdentifiable where Self: UIView {

    static var identifier: String {
        return String(describing: Self.self)
    }

    static var nib: UINib {
        return UINib(nibName: Self.identifier, bundle: Bundle(for: Self.self))
    }

}
