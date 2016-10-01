//
//  StarController.swift
//  RunForUrLife
//
//  Created by Hai on 10/1/16.
//  Copyright © 2016 HaiTrung. All rights reserved.
//

import SpriteKit

class StarController: Controller {
    var score = 0
    func setup(parent: SKNode, nest : View) {
        starSpawn(parent: parent, nest: nest)
        setupContact(parent: parent, nest: nest)
        configurePhysics()
            }
    func starSpawn(parent : SKNode, nest : View) -> Void {
        repeat {
            view.position = CGPoint(x: CGFloat(Int(arc4random_uniform(UInt32 (parent.frame.size.width)))), y: CGFloat(Int(arc4random_uniform(UInt32 (parent.frame.size.height)))))
        }while view.position.distance(nest.position) < nest.frame.width * 2
    }
    func configurePhysics() {
        view.physicsBody = SKPhysicsBody.init(rectangleOf: view.frame.size)
        view.physicsBody?.categoryBitMask = PHYSIC_MASK_STAR
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.contactTestBitMask = PHYSIC_MASK_YOU
        
    }
    func setupContact(parent : SKNode, nest : View) {
        self.view.handleContact = {
            otherView in
            if let youView = otherView as? View {
                self.view.run(SKAction.playSoundFileNamed("pickup_.wav", waitForCompletion: false))
                self.view.run(SKAction.run {
                    self.starSpawn(parent: parent, nest: nest)
                    self.score = self.score + 1
                    
                }
                )
                
            }
            
        }
        
    }
    func getScore(score : Int) -> Void {
        self.score = score
    }
}
