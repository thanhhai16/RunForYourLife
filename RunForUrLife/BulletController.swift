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
}
