//
//  File.swift
//  DigestiveExplorer
//
//  Created by Noa on 8/17/18.
//  Copyright © 2018 Noa Souccar. All rights reserved.
//

import Foundation
import UIKit

class WrongandRightController: ViewController {
    
    @IBOutlet var circleView: UIView!
    override func viewDidLoad() {
         super.viewDidLoad()
        circleView.layer.cornerRadius = circleView.frame.size.width/2
       circleView.clipsToBounds = true
        
        circleView.layer.borderColor = UIColor.white.cgColor
        circleView.layer.borderWidth = 5.0
    }
}
