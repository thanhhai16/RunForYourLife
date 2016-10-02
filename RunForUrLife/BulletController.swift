//
//  BulletController.swift
//  RunForUrLife
//
//  Created by Admin on 10/1/16.
//  Copyright © 2016 HaiTrung. All rights reserved.
//

import SpriteKit

class BulletController : Controller {
    static var SPEED : CGFloat = 100
    func setup(_ parent: SKNode, you : View, nest : View) {
        addFlyAction(parent, you: you, nest: nest)
        setupContact()
        confirgurePhysics()
    }
    
    func addFlyAction(_ parent: SKNode, you : View, nest : View) -> Void {
        let parentSize = parent.frame.size
        let time = (parentSize.height + parentSize.width) / BulletController.SPEED
        var delta = you.position.subtract(nest.position)
        delta = delta.normalize().multiply((parentSize.height + parentSize.width))
        let vectorMove = CGVector(dx: delta.x, dy: delta.y)
        let flyAction = SKAction.move(by: vectorMove, duration: TimeInterval(time))
        self.view.run(flyAction)
        self.view.removeFromParent()
    }
    func setupContact() {
        self.view.handleContact = {
            otherView in
            if let enemyView = otherView as? youView {
                if let eGetHit = enemyView.getHit {
                    eGetHit(1)
                    self.view.removeFromParent()
                }
            }
            
        }
    }
    func confirgurePhysics() -> Void {
        view.physicsBody = SKPhysicsBody(rectangleOf: self.view.size)
        
        view.physicsBody?.categoryBitMask = PHYSIC_MASK_BULLETENEMY
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.contactTestBitMask = PHYSIC_MASK_YOU
        
    }


}
