//
//  YouController.swift
//  RunForUrLife
//
//  Created by Hai on 10/1/16.
//  Copyright © 2016 HaiTrung. All rights reserved.
//

import SpriteKit

class YouController : Controller {
    let SPEED : Float = 150
    override func setup(parent: SKNode) {
        configurePhysics()
    }
    func moveTo(position : CGPoint) -> Void {
        let distance = Float(view.position.distance(position))
        let TIME = distance/SPEED
        let move = SKAction.move(to: position, duration:TimeInterval(TIME) )
        view.run(move)
    }
    func configurePhysics() {
        // physics body
//        var offsetX = CGFloat(view.frame.size.width * view.anchorPoint.x)
//        var offsetY = CGFloat(view.frame.size.height * view.anchorPoint.y)
//        
//        let path = CGMutablePath()
//        path.move(to: CGPoint(x: 4 - offsetX, y: 17 - offsetY))
//        path.addLine(to: CGPoint(x: 21 - offsetX, y: 17-offsetY))
//        path.addLine(to: CGPoint(x: 24 - offsetX, y: 15 - offsetY))
//        path.addLine(to: CGPoint(x: 24 - offsetX, y: 14 - offsetY))
//        path.addLine(to: CGPoint(x: 21 - offsetX, y: 9 - offsetY))
//        path.addLine(to: CGPoint(x: 20 - offsetX, y: 8 - offsetY))
//        path.addLine(to: CGPoint(x: 12 - offsetX, y: 0 - offsetY))
//        path.addLine(to: CGPoint(x: 3 - offsetX, y: 9 - offsetY))
//        path.addLine(to: CGPoint(x: 0 - offsetX, y: 12 - offsetY))
//        path.addLine(to: CGPoint(x: 0 - offsetX, y: 14 - offsetY))
//        
//        path.closeSubpath()
        
//        view.physicsBody = SKPhysicsBody(polygonFrom: path)
        view.physicsBody = SKPhysicsBody(rectangleOf: self.view.size)
        
        // bitmask
        view.physicsBody?.categoryBitMask = PHYSIC_MASK_YOU
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.contactTestBitMask = PHYSIC_MASK_STAR
        }
    func setupContact() {
        self.view.handleContact = {
            otherView in
            if let starView = otherView as? View {
                starView.removeFromParent()
                
            }
            
        }
        
    }

    
}
