//
//  DetailPhotoController.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 23/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit
class DetailPhotoController : UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  var imageName: String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    setupImageView()
  }

override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
  
  private func setupImageView() {
    guard let name = imageName else { return }
    
    if let image = UIImage(named: name) {
      imageView.image = image
    }
  }
  
  
}
