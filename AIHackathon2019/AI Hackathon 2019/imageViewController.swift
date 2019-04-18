//
//  imageViewController.swift
//  AI Hackathon 2019
//
//  Created by Huzaifa Ahmed on 3/30/19.
//  Copyright © 2019 Huzaifa Ahmad. All rights reserved.
//

import UIKit

class imageViewController: UIViewController, UINavigationControllerDelegate {
    var image: UIImage = #imageLiteral(resourceName: "duplicate"){
        didSet{
            imageView.image = image
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
