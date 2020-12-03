//
//  ViewController.swift
//  TribalTestApp
//
//  Created by Fernando Borges Paul on 28/11/20.
//

import UIKit

class ViewController: UIViewController {
    
    var photoManager = PhotoManager()
    
    
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
        userPofileImage.contentMode = .scaleAspectFit
        // Do any additional setup after loading the view.
        photoManager.delegate = self
       photoManager.performRequest()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCollectionView" {
            let destVC = segue.destination as! PhotoViewController
            
            destVC.photoManager.performRequest()

        }
    }
}

extension ViewController: PhotoManagerDelegate {
    func didUpdatePhoto(_ photomanager: PhotoManager, photo: ImageModel) {
        DispatchQueue.main.sync {
            self.userName.text = photo.user
            self.userBio.text = photo.bio
            self.userLikes.text = ("\(photo.userTotalLikes)")
            self.userLocation.text = photo.location
            self.userPofileImage.image = UIImage(systemName: photo.profileImage)
            self.userNumberOfPhotos.text = ("\(photo.userTotalPhotos)")
            self.userPofileImage.downloaded(from: photo.profileImage)
            self.userNumberOfCollections.text = ("\(photo.userTotalCollections)")
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

