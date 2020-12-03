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
        
        let baseURL = "https://api.unsplash.com/photos/?client_id=REcT8eCrRCAcqRmk8GtBqRicbubSBgt3cbrtjtrlktA"
       
        let url = URL(string: baseURL)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            if error == nil {
                do {
                    self.images = try JSONDecoder().decode([Image].self, from: data!)
                } catch {
                    print("Parse error")
                }
                DispatchQueue.main.async {
                    print(self.images.count)
                    self.collectionView.reloadData()
                }
            }
        }.resume()
     
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        
//        cell.contentView.frame = cell.bounds
        cell.photoImageView.downloaded(from: images[indexPath.row].urls.full!)

        return cell
    }
    
}
