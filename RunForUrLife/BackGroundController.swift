//
//  BackGroundController.swift
//  RunForUrLife
//
//  Created by Hai on 10/2/16.
//  Copyright © 2016 HaiTrung. All rights reserved.
//

import SpriteKit

class BackGroundController: Controller {
    var health = 3
    override func setup(parent: SKNode) {
        music_Background(parent: parent)
        backGround(parent: parent)
        if health <= 0 {
            view.removeFromParent()
        }
    }
    func music_Background(parent : SKNode) {
        parent.run(SKAction.playSoundFileNamed("backGround_Music.wav", waitForCompletion: false))
            }
    func backGround(parent : SKNode) {
        let background = View(imageNamed: "background.png")
        background.setScale(0.8)
        background.anchorPoint = CGPoint.zero
        background.position = CGPoint.zero
        parent.addChild(background)

    }
    func get_health(health: Int) {
        self.health = health
    }

}
