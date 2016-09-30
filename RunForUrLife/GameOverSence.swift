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
    override func didMoveToView(view: SKView) {
        let backGround = SKSpriteNode(imageNamed: "background_over.png")
        backGround.setScale(0.8)
        backGround.anchorPoint = CGPointZero
        backGround.position = CGPointZero

        let gameOver = SKLabelNode(text: "GAME OVER")
        gameOver.fontName = "Tahoma";
        gameOver.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
//        let scoreLabel = SKLabelNode(text: "Your Score: \(gameScene.yourScore)")
//        scoreLabel.fontName = "Tahoma"; scoreLabel.fontSize = 8
//        scoreLabel.position = CGPoint(x: self.frame.width/2, y: self.frame.width/3)
        let tap = SKLabelNode(text: "Tap to Restart")
        tap.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2.3)
        addChild(backGround)
        addChild(gameOver)
        addChild(tap)
       
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let gameScene = GameScene(size: (self.view?.frame.size)!)
        
        self.view?.presentScene(gameScene, transition: SKTransition.fadeWithColor(UIColor.whiteColor(), duration: 0.01))
    }
}