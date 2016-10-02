//
//  BoomController.swift
//  RunForUrLife
//
//  Created by Hai on 10/2/16.
//  Copyright © 2016 HaiTrung. All rights reserved.
//

import SpriteKit

class BoomController: Controller {
     func setup(parent: SKNode, nest : View) {
        Action(parent: parent, nest: nest)
    }
    func Action(parent: SKNode, nest : View)  {
        let spot = SKSpriteNode(imageNamed: "smoke.png")
        spot.setScale(0.01)
        repeat {
            spot.position = CGPoint(x: CGFloat(Int(arc4random_uniform(UInt32 (parent.frame.size.width)))), y: CGFloat(Int(arc4random_uniform(UInt32 (parent.frame.size.height)))))
        }while spot.position.distance(nest.position) < nest.frame.width * 2
        self.view.run(SKAction.sequence([
            SKAction.move(to: spot.position, duration: (Double(spot.position.distance(nest.position)))/(100.0)),
            SKAction.run {
                let boom = SKSpriteNode(imageNamed: "boom.png")
                boom.setScale(1)
                boom.position = spot.position
                parent.addChild(boom)
                boom.run(SKAction.playSoundFileNamed("boom_sound.wav", waitForCompletion: true))
                boom.run(SKAction.sequence([
                    SKAction.wait(forDuration: 5),
                    SKAction.run {
                        boom.removeFromParent()
                    }
                    ]))
                self.view.removeFromParent()
            }
            ]))

    }
}
