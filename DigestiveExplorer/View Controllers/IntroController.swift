//
//  IntroController.swift
//  DigestiveExplorer
//
//  Created by Noa on 6/13/18.
//  Copyright © 2018 Noa Souccar. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase



class IntroController: UIViewController {
    
  

    @IBOutlet var foxImage: UIImageView!
    @IBOutlet var password: UITextField!
    @IBOutlet var username: UITextField!
    @IBOutlet var owlView: UIView!
    private var imageName: String = "b.png"
    @IBAction func showPassword(_ sender: Any) {
        password.isSecureTextEntry = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animate()
        owlView.layer.cornerRadius = 9
        owlView.clipsToBounds = true
        owlView.layer.cornerRadius = owlView.frame.size.width/2
       owlView.clipsToBounds = true
        setBackgroundColor()
      
    
}
    func setBackgroundColor(){
        let colorTop =  UIColor(red: 133.0/255.0, green: 193.0/255.0, blue: 233.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 27.0/255.0, green: 79.0/255.0, blue: 144.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func animate() {
    
        let imageNames = ["a.png", "d.png"]
        var animatedImages = [UIImage]()
        
        for i in 0..<imageNames.count {
            animatedImages.append(UIImage(named: imageNames[i])!)
        }
        
        self.foxImage.animationImages = animatedImages
        foxImage.animationDuration = 10.0
        foxImage.startAnimating()
        
        }

}

