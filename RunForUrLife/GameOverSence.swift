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
    var tapTo : View!
    override func didMove(to view: SKView) {
        let backGround = SKSpriteNode(imageNamed: "background_over.png")
        backGround.setScale(0.5)
        backGround.anchorPoint = CGPoint.zero
        backGround.position = CGPoint.zero

        let scoreLabel = SKLabelNode(text: "Your Score: \(self.score)")
        scoreLabel.fontName = "Zapfino"; scoreLabel.fontSize = 30
        scoreLabel.position = CGPoint(x: self.frame.width/2, y: self.frame.width * 2/3)
        tapTo = View(imageNamed: "replay.png")
        tapTo.setScale(0.8)
        tapTo.name = "Tap"
        tapTo.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 1/5)
        self.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.5),
            SKAction.run {
                self.addChild(self.tapTo)
            }
            ]))
        addChild(backGround)
        addChild(scoreLabel)
       
       
    }
    func set_up(score : Int) -> Void {
        self.score = score
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let tapButton = childNode(withName: "Tap") {
            if let touch = touches.first {
                var location = touch.location(in: self)
                if tapButton.contains(location) {
                    self.run(SKAction.sequence([
                        SKAction.run {
                            self.tapTo.texture = SKTexture(imageNamed: "replay_tap.png")
                        }, SKAction.wait(forDuration: 0.5),
                           SKAction.run {
                            let gameScene = GameScene(size: (self.view?.frame.size)!)
                            self.view?.presentScene(gameScene, transition: SKTransition.doorsOpenHorizontal(withDuration: 1))
                        }
                        ]))
                    

                }
            }
        }

        



        
        

}
}
