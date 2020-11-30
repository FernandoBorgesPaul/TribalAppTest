//
//  ViewController.swift
//  TribalTestApp
//
//  Created by Fernando Borges Paul on 28/11/20.
//

import UIKit

class ViewController: UIViewController {
    
    var photoManager = PhotoManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        photoManager.performRequest()
        
    }


}

