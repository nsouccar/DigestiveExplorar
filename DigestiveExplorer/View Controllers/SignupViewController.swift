//
//  SignupViewController.swift
//  DigestiveExplorer
//
//  Created by Noa on 7/19/18.
//  Copyright © 2018 Noa Souccar. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth




class signUpViewController: UIViewController {
    @IBOutlet weak var signupForm: UIView!
    
    @IBOutlet var password: UITextField!
    @IBOutlet var email: UITextField!
    
    @IBOutlet var createAccountButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signupForm.alpha = 0.0

        setBackgroundColor()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateForm()
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
    
    func animateForm () {
        UIView.animate(withDuration: 1.0, delay: 0.01, options:UIViewAnimationOptions.curveEaseIn,  animations: {self.signupForm.alpha = 1.0
        }, completion:nil)
        
    }
    
    @IBAction func register(_ sender: Any) {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion: {(user, error) in
            
            if error != nil {
                print(error!)
            } else {
                print("registration successful")
            }
            
        })
        
        
        
    }
    
    
    
    
    
}
