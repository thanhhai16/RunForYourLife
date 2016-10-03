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
    var youHealth = 3
    var score = 0
    var sC = 0
    
    var krupSetup = false
    var bulletSetup = false
    var enemySetup = false
    
    private func setupInALevel (parent: SKNode) -> Void {
        var i = 0
        if !bulletSetup {
            bulletSetup = true
            self.view.run(SKAction.repeatForever(
            SKAction.sequence(
                [SKAction.wait(forDuration: 1),SKAction.run({
                    self.addBullet(parent, you: self.you)
                }), SKAction.wait(forDuration: TimeInterval(Double(timeForNextBullet) - 2))])))
        }
        if score >= 5 {
            if !krupSetup {
                krupSetup = true
            self.view.run(
                SKAction.repeatForever (
                SKAction.sequence(
                    [
                     SKAction.run({
                        self.addKryp(parent, you: self.you)
                    }),SKAction.wait(forDuration: TimeInterval(3)) ])))
            }
        }
        if score >= 7 {
            if !enemySetup {
                enemySetup = true
            
            self.view.run(
                SKAction.repeatForever(
                    SKAction.sequence(
                    [SKAction.wait(forDuration: 3),SKAction.run({
                        self.addEnemy(parent, speed: self.SPEED_BASE * (1 + CGFloat(i) / 20.0))
                        i += 1;
                    }),SKAction.run{
                        self.addSmoke(parent: parent, nest: self.view)
                        }, SKAction.wait(forDuration: TimeInterval(timeForNextEnemy))])))
            }
        }
    
    }
    override func setup(parent : SKNode) -> Void {
        
        self.view.run(
            SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.run({
                        self.setupInALevel(parent: parent)
                    }),
                    SKAction.wait(forDuration: 1)
                    ])
            )
        )
        
    }
    func update(_ you : View) -> Void {
        self.you = you
    }
    func updateScore(_ score : Int) -> Int {
        self.score = score
        return self.score
    }
    func addScore() -> Int{
        let myScore = self.score
        return myScore
    }


    
    func addSmoke(parent : SKNode, nest : View) {
        let smoke = View(imageNamed: "smoke.png")
        smoke.setScale(0.06)
        smoke.position = view.position
        let boomController = BoomController(view: smoke)
        boomController.setup(parent: parent, nest : nest)
        parent.addChild(smoke)
        
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
                self.youHealth = enemyController.youHealth
            }), SKAction.wait(forDuration: 0.01)])))
        enemyController.setup(parent, speed: speed)
        enemy.run(SKAction.repeatForever(SKAction.sequence(
            [SKAction.run({
                self.youHealth = enemyController.youHealth
            }), SKAction.wait(forDuration: 0.01)])))
        
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
        
    }
    func addKryp(_ parent : SKNode, you : View) -> Void {
        let kryp = View(imageNamed: "kryp.png")
        kryp.setScale(0.1)
        
        kryp.position = self.view.position
        
        let krypController = KrypController(view: kryp)
        
        krypController.setup(parent, you: you, nest: self.view)
        
        parent.addChild(kryp)
        
        
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
            kryp.removeFromParent()
        })]))
        
    }
    
}
