//
//  PhotoViewController.swift
//  TribalTestApp
//
//  Created by Fernando Borges Paul on 02/12/20.
//

import UIKit

class PhotoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var photoManager = PhotoManager()
    
    var images = [Image]()

   
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //MARK: - URL Session for Array of Images
        let baseURL = "https://api.unsplash.com/photos/?client_id=\(photoManager.accessKey)"
       
        let url = URL(string: baseURL)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            if error == nil {
                do {
                    self.images = try JSONDecoder().decode([Image].self, from: data!)
                } catch {
                    print("Parse error")
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }.resume()
     
    }
    
    // MARK: - CollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.photoImageView.downloaded(from: images[indexPath.row].urls.full!)  // It is better to use the photos in small format to optimize loading time.

        return cell
    }
    
}
