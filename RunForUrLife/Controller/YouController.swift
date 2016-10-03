//
//  YouController.swift
//  RunForUrLife
//
//  Created by Hai on 10/1/16.
//  Copyright © 2016 HaiTrung. All rights reserved.
//

import SpriteKit

class YouController : Controller {
    var youHealth = 5
    var SPEED : Float = 200
    var powerUp = false
    var you : View!
    
    override func setup(parent: SKNode) {
        configurePhysics()
        setupResponds(parent : parent)
        
    }
    func update(_ you : View) -> Void {
        self.you = you
    }
    func moveTo(position : CGPoint) -> Void {
        let distance = Float(view.position.distance(position))
        let TIME = distance/SPEED
        let move = SKAction.move(to: position, duration:TimeInterval(TIME) )
        view.run(move)
    }
    func configurePhysics() {
        view.physicsBody = SKPhysicsBody(rectangleOf: self.view.size)
        
        // bitmask
        view.physicsBody?.categoryBitMask = PHYSIC_MASK_YOU
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.contactTestBitMask = PHYSIC_MASK_ENEMY | PHYSIC_MASK_BULLETENEMY
    }
    func setupResponds(parent : SKNode) {
        if let View = self.view as? youView {
            View.getHit = {
                damage in
                if self.powerUp == false {
                    self.youHealth -= damage
                }
                
                
                
            }
        }
        if let View = self.view as? youView {
            View.get = {
                damage in
                if damage == 3 {
                    self.view.run(SKAction.playSoundFileNamed("heal_sound.wav", waitForCompletion: true))
                    self.youHealth = self.youHealth + 2
                    if self.youHealth >= 5 {
                        self.youHealth = 5
                    }
                    
                }
                
                if damage == 1 {
                    self.view.run(SKAction.playSoundFileNamed("powerup_sound.wav", waitForCompletion: true))
                    
                    self.view.run(SKAction.sequence([
                        SKAction.run {
                            self.powerUp = true
                        }, SKAction.wait(forDuration: 5),
                           SKAction.run {
                            self.powerUp = false
                        }
                        ]))
                    self.view.run(SKAction.sequence([
                        SKAction.run {
                            self.view.texture = SKTexture(imageNamed: "main_1.png")
                        }, SKAction.wait(forDuration: 5)
                        , SKAction.run {
                            self.view.texture = SKTexture(imageNamed: "main.png")
                        }
                        ]))
                }
                if damage == 2 {
                    self.view.run(SKAction.playSoundFileNamed("kryp_sound.wav", waitForCompletion: true))
                    
                    self.view.run(SKAction.sequence([
                        SKAction.run {
                            self.SPEED = 100
                        }, SKAction.wait(forDuration: 2),
                           SKAction.run {
                            self.SPEED = 200
                        }
                        ]))
                    self.view.run(SKAction.sequence([
                        SKAction.run {
                            self.view.texture = SKTexture(imageNamed: "main_2.png")
                        }, SKAction.wait(forDuration: 2)
                        , SKAction.run {
                            self.view.texture = SKTexture(imageNamed: "main.png")
                        }
                        ]))
                }
                
                
            }
        }
        
    }
    
    
    
    
}
