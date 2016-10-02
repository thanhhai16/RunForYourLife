//
//  KrypController.swift
//  RunForUrLife
//
//  Created by Hai on 10/2/16.
//  Copyright © 2016 HaiTrung. All rights reserved.
//

import SpriteKit

class KrypController : Controller {
    static var SPEED : CGFloat = 100
    func setup(_ parent: SKNode, you : View, nest : View) {
        addFlyAction(parent, you: you, nest: nest)
        setupContact()
        confirgurePhysics()
    }
    
    func addFlyAction(_ parent: SKNode, you : View, nest : View) -> Void {
        let parentSize = parent.frame.size
        let time = (parentSize.height + parentSize.width) / 300
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
                if let eGetHit = enemyView.get {
                    eGetHit(2)
                    self.view.removeFromParent()
                }
            }
            
        }
    }
    func confirgurePhysics() -> Void {
        view.physicsBody = SKPhysicsBody(rectangleOf: self.view.size)
        
        view.physicsBody?.categoryBitMask = PHYSIC_MASK_KRYP
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.contactTestBitMask = PHYSIC_MASK_YOU
        
    }
    
    
}
