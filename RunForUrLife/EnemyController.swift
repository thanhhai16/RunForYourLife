//
//  EnemyController.swift
//  RunForUrLife
//
//  Created by Admin on 10/1/16.
//  Copyright © 2016 HaiTrung. All rights reserved.
//

import SpriteKit

class EnemyController : Controller {
    var you: View!
<<<<<<< HEAD
    var youHealth = 3
=======
>>>>>>> ef982c5789889e9bb01a22176632e6bc76a1ee16
    func setup(_ parent : SKNode, speed : CGFloat) -> Void {
        view.run(SKAction.repeatForever(SKAction.sequence(
            [SKAction.run({
                self.addFlyAction(parent, speed: speed)
            }), SKAction.wait(forDuration: 0.01)])))
<<<<<<< HEAD
        confirgurePhysics()
        self.setupContact()

        
=======
>>>>>>> ef982c5789889e9bb01a22176632e6bc76a1ee16
    }
    
    func update(_ you: View) -> Void {
        self.you = you
    }    
    func addFlyAction(_ parent : SKNode, speed : CGFloat) -> Void {
        let distance = you.position.distance(self.view.position)
        let time = distance / speed
        let flyAction = SKAction.move(to: you.position, duration: TimeInterval(time))
        self.view.run(flyAction)
    }
    func confirgurePhysics() -> Void {
<<<<<<< HEAD
        view.physicsBody = SKPhysicsBody(rectangleOf: self.view.size)
        
        view.physicsBody?.categoryBitMask = PHYSIC_MASK_ENEMY
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.contactTestBitMask = PHYSIC_MASK_YOU
        
    }
    func setupContact() {
        self.view.handleContact = {
            otherView in
            if let enemyView = otherView as? youView {
                if let eGetHit = enemyView.getHit {
                    eGetHit(2)
                    self.view.removeFromParent()
                }
            }
            
        }
    }

=======
        
    }
>>>>>>> ef982c5789889e9bb01a22176632e6bc76a1ee16
    
    func setupRespond() -> Void {
        
    }
}
