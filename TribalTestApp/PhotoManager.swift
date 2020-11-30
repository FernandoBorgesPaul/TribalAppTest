//
//  PhotoManager.swift
//  TribalTestApp
//
//  Created by Fernando Borges Paul on 28/11/20.
//

import Foundation

protocol PhotoManagerDelegate {
    func didUpdatePhoto (_ photomanager: PhotoManager, photo: ImageModel)
    func didFailWithError(error: Error)
}

struct PhotoManager {
    
    
    let accessKey = "REcT8eCrRCAcqRmk8GtBqRicbubSBgt3cbrtjtrlktA"
    
    var delegate: PhotoManagerDelegate?
    
    func performRequest() {
        
        if let url = URL(string: "https://api.unsplash.com/photos/?client_id=\(accessKey)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
//               if let data = data {
//                  do {
//                    let image = try JSONDecoder().decode([Image].self, from: data)
//                    print(image)
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let photo = parseJSON(photoData: safeData) {
                        self.delegate?.didUpdatePhoto(self, photo: photo)

                    }
//                  } catch let error {
//                     print(error)
//                  }
               }
            }.resume()
        }
    
    
        func parseJSON(photoData: Data) -> ImageModel? {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode([Image].self, from: photoData)
                let id = decodedData[0].id
                let width = decodedData[0].width
                let height = decodedData[0].height
                let color = decodedData[0].color
                let likes = decodedData[0].likes
                let user = decodedData[0].user.name
                let urls = decodedData[0].urls.full
                let bio = decodedData[0].user.bio
                let location = decodedData[0].user.location ?? "Unknown"
              
                // We create an instance of ImageModel so you can get the methods and property from it
                let image = ImageModel(id: id, width: width, height: height, color: color, likes: likes, user: user!, urls: urls!, bio: bio, location: location)
                
                return image
                
            } catch {
                delegate?.didFailWithError(error: error)
                return nil
            }
        }}
    
}

extension URL {
    private static var baseUrl: String {
        return "https://api.unsplash.com/"
    }

    static func with(string: String) -> URL? {
        return URL(string: "\(baseUrl)\(string)")
    }
}
