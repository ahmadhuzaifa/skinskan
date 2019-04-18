//
//  ViewController1.swift
//  AI Hackathon 2019
//
//  Created by Huzaifa Ahmed on 3/31/19.
//  Copyright © 2019 Huzaifa Ahmad. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {
    let gradientLayer = CAGradientLayer()
    override func viewWillAppear(_ animated: Bool) {
        createGradientLayer()
        iconView.layer.cornerRadius = 20
        iconView.layer.masksToBounds = true
    }
    @IBOutlet weak var iconView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = .black
        
    }
    func createGradientLayer() {
        gradientLayer.colors = [#colorLiteral(red: 0.537254902, green: 0.5058823529, blue: 0.8, alpha: 1).cgColor, #colorLiteral(red: 0.1411764706, green: 0.7764705882, blue: 0.8392156863, alpha: 1).cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        self.view.backgroundColor = .white
    }
}
