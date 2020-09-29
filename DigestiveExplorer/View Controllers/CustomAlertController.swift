//
//  CustomAlertController.swift
//  DigestiveExplorer
//
//  Created by Noa on 8/12/18.
//  Copyright © 2018 Noa Souccar. All rights reserved.
//

import Foundation
import UIKit


class CustomAlertController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var circleView: UIView!
    
    @IBOutlet var answer1: UIButton!
    @IBOutlet var answer2: UIButton!
    @IBOutlet var answer3: UIButton!
    @IBOutlet var question: UILabel!

    
    
    
    

    
    public var questionTitle: String = "Label"
    public var answer1Title: String = "Label"
    public var answer2Title: String =  "Label"
    public var answer3Title: String =  "Label"
    private var rightAnswerNumber: Int = 1
  
    var delegate: CustomAlertViewDelegate?
    
    func setQuestionTitle(questionTitle: String) {
        self.questionTitle = questionTitle
    }
    func setAnswer1Title(answer1Title: String) {
        self.questionTitle = answer1Title
    }
    
    func setAnswer2Title(answer2Title: String) {
        self.questionTitle = answer2Title
    }
    func setAnswer3Title(answer2Title: String) {
        self.questionTitle = answer2Title
    }
    
    func  setRightAnswer(answer: Int) {
        rightAnswerNumber = answer
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleView.layer.cornerRadius = circleView.frame.size.width/2
        circleView.clipsToBounds = true
        
        circleView.layer.borderColor = UIColor.white.cgColor
        circleView.layer.borderWidth = 5.0
        question = UILabel()
        answer1 = UIButton()
        answer2 = UIButton()
        answer3 = UIButton()
        
        //Labels
        question.text = questionTitle
        answer1.setTitle(answer1Title, for: .normal)
        answer2.setTitle(answer2Title, for: .normal)
        answer3.setTitle(answer3Title, for: .normal)
        
        //Views
   
        
answer1.addTarget(self, action: #selector(button1Pressed), for: UIControlEvents.touchUpInside)
answer2.addTarget(self, action: #selector(button2Pressed), for: UIControlEvents.touchUpInside)
answer3.addTarget(self, action: #selector(button3Pressed), for: UIControlEvents.touchUpInside)
        
}
    
    @objc func button1Pressed(_ sender: Any) {
        
        if rightAnswerNumber == 1 {
         delegate?.rightTapped()
        } else {
            delegate?.wrongTapped()
        }
    }
    
    @objc func button2Pressed(_ sender: Any) {
        if rightAnswerNumber == 2 {
            delegate?.rightTapped()
        } else {
            delegate?.wrongTapped()
        }
    }
    
     @objc func button3Pressed(_ sender: Any) {
        if rightAnswerNumber == 3 {
            delegate?.rightTapped()
        } else {
            delegate?.wrongTapped()
        }
    }
}

protocol CustomAlertViewDelegate: class {
    func wrongTapped()
    func rightTapped()
    
    
}

