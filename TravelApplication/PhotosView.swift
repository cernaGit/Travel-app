//
//  PhotosView.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 17/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit

struct Photo {
    var imageName: String
}

class PhotosView:  UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageName: String = ""
    let placesImage : [UIImage] = [
        UIImage(named: "beach")!,
        UIImage(named: "flay")!,
        UIImage(named: "asie")!,
        UIImage(named: "gracey")!,
        UIImage(named: "praha")!,
        UIImage(named: "trip")!,
        UIImage(named: "woods")!,
        UIImage(named: "lake")!,
        UIImage(named: "london")!,
        UIImage(named: "prague")!,
        UIImage(named: "sea")!,
        UIImage(named: "tramvaj")!
    
    ]
    
    override func viewDidLoad() {
        collectionView.register(PhotoCollectionViewCell.nib, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        super.viewDidLoad()
        
        let itemSize = UIScreen.main.bounds.width/2-2
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        layout.itemSize = CGSize (width: itemSize, height: itemSize)
        
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        collectionView.collectionViewLayout = layout
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = Photo(imageName: imageName)
      
      if segue.identifier == "viewImageSegueIdentifier" {
        if let vc = segue.destination as? DetailPhotoController {
            vc.imageName = item.imageName
        }
      }
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placesImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellImage", for: indexPath) as! PhotoCollectionViewCell
        cell.imageViewCell.image = placesImage[indexPath.item]
        
        return cell
       // return viewModel.self as! UICollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let item = placesImage[indexPath.item]
        performSegue(withIdentifier: "viewImageSegueIdentifier", sender: item)
    
    }
    
   /* @IBAction func addPhoto(_ sender: Any) {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .photoLibrary
                picker.mediaTypes = [kUTTypeImage as String]
                self.present(picker, animated: true, completion: nil)
            }
            
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let possibleImage =
                info[.editedImage] as? UIImage {
                // present in imageView
                imageView.image = possibleImage
            } else if let possibleImage =
                info[.originalImage] as? UIImage {
                // present in imageView
                imageView.image = possibleImage
            }
            imageView.contentMode = .scaleAspectFill
            
            self.dismiss(animated:true, completion: nil)
        }
        
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
            self.dismiss(animated:true, completion: nil)
        }*/
    
    

}


