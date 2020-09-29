//
//  Questions.swift
//  DigestiveExplorer
//
//  Created by Noa on 8/11/18.
//  Copyright © 2018 Noa Souccar. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

enum DigestiveSystemParts {
    
    case esophagus, stomach, smallIntestine, largeIntestine, anus, mouth
    
    func getTranslations () -> SCNVector3 {
        
        switch self {
        case .mouth: return SCNVector3(0,0,8)
        case .esophagus: return SCNVector3(1,1,1)
        case .anus: return SCNVector3(2,2,2)
        case .largeIntestine: return SCNVector3(3,3,3)
        case .smallIntestine: return SCNVector3(4,4,4)
        case .stomach: return SCNVector3(5, 5, 5)
            
        }
        
    }
    
}
    
    
public class CreateQuestions: CustomAlertViewDelegate {
   
    
    
    func moveNode(eular: Bool, organ: DigestiveSystemParts, node:SCNNode) -> Void  {
        let vector = organ.getTranslations()

        
        if eular == true {
            let euAction = SCNAction.rotateBy(x:CGFloat(vector.x) , y:CGFloat(vector.y) , z: CGFloat(vector.z), duration: 5)
            node.runAction(euAction)
            
        } else if eular == false {
            let transAction = SCNAction.move(by: vector, duration: 5)
            node.runAction(transAction)
        }
        
        
        
    }

    func createQuestion (question: String, ans1: String, ans2: String, ans3: String, storyBoard: UIStoryboard?, rightAnswer: Int) -> CustomAlertController {
       
        let customAlert = storyBoard?.instantiateViewController(withIdentifier: "ID") as! CustomAlertController
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        customAlert.delegate = self
        customAlert.setQuestionTitle(questionTitle: question)
        customAlert.setAnswer1Title(answer1Title: ans1)
        customAlert.setAnswer2Title(answer2Title: ans2)
        customAlert.setAnswer3Title(answer2Title: ans3)
        customAlert.setRightAnswer(answer: rightAnswer)
        
        return customAlert
        
}
    
    func wrongTapped() {
        print("wrong answer") // TODO create wrong view controller
    }
    
    func rightTapped() {
        print("right answer") // TODO create right view controller
    }
    
        
}
    
    

