//
//  ViewController2.swift
//  AI Hackathon 2019
//
//  Created by Huzaifa Ahmed on 3/31/19.
//  Copyright © 2019 Huzaifa Ahmad. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    let gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var getStarted: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        getStarted.layer.cornerRadius = getStarted.frame.height/2

    }
    override func viewWillAppear(_ animated: Bool) {
        createGradientLayer()
    }

    func createGradientLayer() {
        gradientLayer.colors = [#colorLiteral(red: 0.537254902, green: 0.5058823529, blue: 0.8, alpha: 1).cgColor, #colorLiteral(red: 0.1411764706, green: 0.7764705882, blue: 0.8392156863, alpha: 1).cgColor]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        self.view.backgroundColor = .white
    }

}
