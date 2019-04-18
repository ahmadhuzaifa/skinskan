//
//  RingViewController.swift
//  AI Hackathon 2019
//
//  Created by Huzaifa Ahmed on 3/31/19.
//  Copyright © 2019 Huzaifa Ahmad. All rights reserved.
//

import UIKit

class RingViewController: UIViewController {

    @IBOutlet weak var firstPrediction: UILabel!
    @IBOutlet weak var secondPrediction: UILabel!
    @IBOutlet weak var thirdPrediction: UILabel!
    @IBOutlet weak var fourthPrediction: UILabel!
    
    var firstPredict: String = ""{
        didSet{
            firstPrediction.text = firstPredict
        }
    }
    var secondPredict: String = ""{
        didSet{
            secondPrediction.text = secondPredict
        }
    }
    var thirdPredict: String = ""{
        didSet{
            thirdPrediction.text = thirdPredict
        }
    }
    var fourthPredict: String = ""{
        didSet{
            fourthPrediction.text = fourthPredict
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")

    }
}

