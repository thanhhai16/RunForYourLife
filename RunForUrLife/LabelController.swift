//
//  ScoreLabelController.swift
//  RunForUrLife
//
//  Created by Hai on 10/1/16.
//  Copyright © 2016 HaiTrung. All rights reserved.
//

import SpriteKit
class LabelController : Controller {
    var youHealth = 5
    var score = 0
    var sL : SKLabelNode!
    var hL : SKSpriteNode!
    var nodeI : SKSpriteNode!
    override func setup(parent: SKNode) {
        self.view.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run {
                self.hL = self.addHealthLabel(parent: parent)
            }, SKAction.wait(forDuration: 0.05), SKAction.run {
                self.hL.removeFromParent()
            }
            ])))


        self.view.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run {
                self.sL = self.scoreLabel(parent: parent)
            }, SKAction.wait(forDuration: 0.05), SKAction.run {
                self.sL.removeFromParent()
            }
            ])))
    }
    func addHealthLabel(parent : SKNode) -> SKSpriteNode {
        if (youHealth == 4) {
            nodeI = SKSpriteNode(imageNamed: "health_4.png")
            nodeI.setScale(0.3)
            nodeI.position = CGPoint(x: parent.frame.width/2, y: 0 + nodeI.frame.height/2)
            parent.addChild(nodeI)
        }
        if (youHealth == 5) {
            nodeI = SKSpriteNode(imageNamed: "health_5.png")
            nodeI.setScale(0.3)
            nodeI.position = CGPoint(x: parent.frame.width/2, y: 0 + nodeI.frame.height/2)
            parent.addChild(nodeI)
        }


        if (youHealth == 3) {
            nodeI = SKSpriteNode(imageNamed: "health_3.png")
            nodeI.setScale(0.3)
            nodeI.position = CGPoint(x: parent.frame.width/2, y: 0 + nodeI.frame.height/2)
            parent.addChild(nodeI)
        }
        if (youHealth == 2) {
            nodeI = SKSpriteNode(imageNamed: "health_2.png")
            nodeI.setScale(0.3)

            nodeI.position = CGPoint(x: parent.frame.width/2, y: 0 + nodeI.frame.height/2)
            parent.addChild(nodeI)
        }
        if (youHealth == 1) {
            nodeI = SKSpriteNode(imageNamed: "health_1.png")
            nodeI.setScale(0.3)
            nodeI.position = CGPoint(x: parent.frame.width/2, y: 0 + nodeI.frame.height/2)
            parent.addChild(nodeI)
        }
        if (youHealth == 0) {
            nodeI = SKSpriteNode(imageNamed: "health_0.png")
            nodeI.setScale(0.3)
            nodeI.position = CGPoint(x: parent.frame.width/2, y: 0 + nodeI.frame.height/2)
            parent.addChild(nodeI)
        }

        return nodeI
        
    }
    
    func scoreLabel(parent : SKNode) -> SKLabelNode {
        let scoreLabel = SKLabelNode(text: "Score :\(score)")
        scoreLabel.position = CGPoint(x: parent.frame.width/2, y: parent.frame.height - scoreLabel.frame.height)
        scoreLabel.fontName = "Tahoma"
        scoreLabel.fontColor = UIColor.white
        scoreLabel.fontSize = 20
        parent.addChild(scoreLabel)
return scoreLabel    }
        
    func update(score : Int, health : Int) {
        self.score = score
        self.youHealth = health
        
    }
    
    
}

