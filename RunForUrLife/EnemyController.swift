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
    func setup(_ parent : SKNode, speed : CGFloat) -> Void {
        view.run(SKAction.repeatForever(SKAction.sequence(
            [SKAction.run({
                self.addFlyAction(parent, speed: speed)
            }), SKAction.wait(forDuration: 0.01)])))
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
        
    }
    
    func setupRespond() -> Void {
        
    }
}
