//
//  PhotoManager.swift
//  TribalTestApp
//
//  Created by Fernando Borges Paul on 28/11/20.
//

import Foundation

struct PhotoManager {
    
    
    let accessKey = "REcT8eCrRCAcqRmk8GtBqRicbubSBgt3cbrtjtrlktA"
    
    func performRequest() {
        
        if let url = URL(string: "https://api.unsplash.com/photos/?client_id=\(accessKey)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
               if let data = data {
                  do {
                    let image = try JSONDecoder().decode([Image].self, from: data)
                    print(image)

                    
                  } catch let error {
                     print(error)
                  }
               }
            }.resume()
        }
    }
    
    
}

extension URL {
    private static var baseUrl: String {
        return "https://api.unsplash.com/"
    }

    static func with(string: String) -> URL? {
        return URL(string: "\(baseUrl)\(string)")
    }
}
