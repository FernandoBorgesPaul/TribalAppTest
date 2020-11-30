//
//  ViewController.swift
//  TribalTestApp
//
//  Created by Fernando Borges Paul on 28/11/20.
//

import UIKit

class ViewController: UIViewController {
    
    var photoManager = PhotoManager()
    
//    var user = [PhotoManager].self
    
    @IBOutlet weak var userPofileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var userNumberOfPhotos: UILabel!
    @IBOutlet weak var userNumberOfCollections: UILabel!
    @IBOutlet weak var userLikes: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userPofileImage.layer.cornerRadius = CGFloat(userPofileImage.frame.height / 2)
        userPofileImage.clipsToBounds = true
        // Do any additional setup after loading the view.
        photoManager.delegate = self
       photoManager.performRequest()
        
    }


}

extension ViewController: PhotoManagerDelegate {
    func didUpdatePhoto(_ photomanager: PhotoManager, photo: ImageModel) {
        DispatchQueue.main.sync {
            self.userName.text = photo.user
            self.userBio.text = photo.bio
            self.userLikes.text = ("\(photo.likes)")
            self.userLocation.text = photo.location
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

