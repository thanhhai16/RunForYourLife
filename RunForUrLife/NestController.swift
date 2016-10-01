//
//  NestController.swift
//  RunForUrLife
//
//  Created by Admin on 10/1/16.
//  Copyright © 2016 HaiTrung. All rights reserved.
//

import SpriteKit

class NestController : Controller {
    let timeForNextEnemy = 5
    let timeForNextBullet = 2
    let maxEnemy = 5
    let SPEED_BASE : CGFloat = 100
    var you : View!
    override func setup(parent : SKNode) -> Void {
        var i = 0;
        self.view.run(SKAction.repeatForever(
            SKAction.sequence(
                [SKAction.run({
                    self.addEnemy(parent, speed: self.SPEED_BASE * (1 + CGFloat(i) / 20.0))
                    i += 1;
                }), SKAction.wait(forDuration: TimeInterval(timeForNextEnemy))])))
        
        self.view.run(SKAction.repeatForever(
            SKAction.sequence(
                [SKAction.run({
                    self.addBullet(parent, you: self.you)
                }), SKAction.wait(forDuration: TimeInterval(timeForNextBullet))])))
        
    }
    
    func update(_ you : View) -> Void {
        self.you = you
    }
    func addEnemy(_ parent : SKNode, speed : CGFloat) -> Void {
        let enemy = View(imageNamed: "enemy_1.png")
        var enemyTextures : [SKTexture] = []
        let texture_0 = SKTexture(imageNamed: "enemy_0.png")
        enemyTextures.append(texture_0)
        let texture_1 = SKTexture(imageNamed: "enemy_1.png")
        enemyTextures.append((texture_1))
        let enemyAnimate = SKAction.animate(with: enemyTextures, timePerFrame: 0.1)
        enemy.run(SKAction.repeatForever(enemyAnimate))
        enemy.setScale(0.029)
        enemy.position = self.view.position
        
        
        var nestOpenTextures : [SKTexture] = []
        let nestOpen_0 = SKTexture(imageNamed: "nest_0")
        nestOpenTextures.append(nestOpen_0)
        let nestOpen_1 = SKTexture(imageNamed: "nest_open_1")
        nestOpenTextures.append(nestOpen_1)
        let nestOpen_2 = SKTexture(imageNamed: "nest_open_2")
        nestOpenTextures.append(nestOpen_2)
        let animateOpen = SKAction.animate(with: nestOpenTextures, timePerFrame: 0.07)
        
        self.view.run(animateOpen)
        
        let enemyController = EnemyController(view: enemy)
        enemyController.update(you)
        enemy.run(SKAction.repeatForever(SKAction.sequence(
            [SKAction.run({
                enemyController.update(self.you)
            }), SKAction.wait(forDuration: 0.01)])))
        enemyController.setup(parent, speed: speed)
        parent.addChild(enemy)
        parent.run(SKAction.sequence([SKAction.wait(forDuration: (TimeInterval) (timeForNextEnemy * maxEnemy)),SKAction.run({
            enemy.removeFromParent()
        })]))
    }
    func addBullet(_ parent : SKNode, you : View) -> Void {
        let enemyBullet = View(imageNamed: "bullet-red-dot.png")
        enemyBullet.setScale(0.5)
        
        enemyBullet.position = self.view.position
        
        let bulletController = BulletController(view: enemyBullet)
        
        bulletController.setup(parent, you: you, nest: self.view)
        
        parent.addChild(enemyBullet)
        
        
        var nestShotTexures : [SKTexture] = []
        let nameNestFormat = "nest_"
        for i in 0..<3 {
            let imageName = "\(nameNestFormat)\(i).png"
            let nestShotTexture = SKTexture(imageNamed: imageName)
            nestShotTexures.append(nestShotTexture)
        }
        let animateShot = SKAction.animate(with: nestShotTexures, timePerFrame: 0.07)
        
        self.view.run(animateShot)
        
        let playShotSound = SKAction.playSoundFileNamed("shoot.wav", waitForCompletion: false)
        self.view.run(playShotSound)
        
        parent.run(SKAction.sequence([SKAction.wait(forDuration: (TimeInterval) (5)),SKAction.run({
            enemyBullet.removeFromParent()
        })]))
        
        //        //vector dich chuyen
        //        let vectorMove = you.position.subtract(positionBulletEnemy).normalize().multiply(self.frame.size.height)
        //        //Action dich chuyen
        //        let move = SKAction.moveBy(CGVector(dx: vectorMove.x, dy: vectorMove.y), duration: NSTimeInterval ((self.frame.size.height + self.frame.size.width)/100/enemyBulletSpeed))
        //        let movePeriod = SKAction.sequence([move, SKAction.waitForDuration(0.001)])
        //        let moveForever = SKAction.repeatActionForever(movePeriod)
        //        enemyBullet.runAction(moveForever)
        
    }
}
