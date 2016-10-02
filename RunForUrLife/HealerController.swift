//
//  HealerController.swift
//  RunForUrLife
//
//  Created by Hai on 10/2/16.
//  Copyright © 2016 HaiTrung. All rights reserved.
//

import SpriteKit

class HealerController: Controller {
    var playerController : YouController!
    var powerUP = false
    func setup(parent: SKNode, nest : View) {
        addPower(parent: parent, nest: nest)
        configurePhysics()
        setupContact()
    }
    
    func addPower(parent : SKNode, nest: View) {
        repeat {
            self.view.position = CGPoint(x: CGFloat(Int(arc4random_uniform(UInt32 (parent.frame.size.width)))), y: CGFloat(Int(arc4random_uniform(UInt32 (parent.frame.size.height)))))
        }while self.view.position.distance(nest.position) < nest.frame.width * 2
    }
    func configurePhysics() {
        view.physicsBody = SKPhysicsBody.init(rectangleOf: view.frame.size)
        view.physicsBody?.categoryBitMask = PHYSIC_MASK_HEALER
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.contactTestBitMask = PHYSIC_MASK_YOU
    }
    func setupContact() {
        self.view.handleContact = {
            otherView in
            if let enemyView = otherView as? youView {
                if let eGetHit = enemyView.get {
                    eGetHit(3)
                    self.view.removeFromParent()
                }
            }
            
        }
    }
    
}

