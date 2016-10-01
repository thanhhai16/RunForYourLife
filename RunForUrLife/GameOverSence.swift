//
//  GameOverSence.swift
//  RunForUrLife
//
//  Created by Hai on 9/29/16.
//  Copyright © 2016 HaiTrung. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverSence : SKScene {
    var gameScene : GameScene!
    var score = 0
    override func didMove(to view: SKView) {
        let backGround = SKSpriteNode(imageNamed: "background_over.png")
        backGround.setScale(0.5)
        backGround.anchorPoint = CGPoint.zero
        backGround.position = CGPoint.zero

        let scoreLabel = SKLabelNode(text: "Your Score: \(self.score)")
        scoreLabel.fontName = "Tahoma"; scoreLabel.fontSize = 15
        scoreLabel.position = CGPoint(x: self.frame.width/2, y: self.frame.width/3)
        addChild(backGround)
        addChild(scoreLabel)
       
       
    }
    func set_up(score : Int) -> Void {
        self.score = score
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: (self.view?.frame.size)!)
        
        self.view?.presentScene(gameScene, transition: SKTransition.fade(with: UIColor.white, duration: 0.01))
    }
}
