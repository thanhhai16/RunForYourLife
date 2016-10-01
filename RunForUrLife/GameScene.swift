//
//  GameScene.swift
//  RunForUrLife
//
//  Created by Hai on 9/10/16.
//  Copyright (c) 2016 HaiTrung. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var you : SKSpriteNode!                     //player
    var lastUpdateTime : TimeInterval = -1
    var indexEnemy = 0                          // chi so enemy vua sinh ra
    var enemies : [(SKSpriteNode,CGFloat)] = [] //cac enemy gom: Node va speed cua enemy
    var gates : [SKSpriteNode] = []             //cac Gate
    var yourScore = 0
    var yourSpeed : CGFloat = 1.5               //toc do di chuyen cua player
    var enemySpeed : CGFloat = 1                //toc do di chuyen cua enemy
    var enemyBulletSpeed : CGFloat = 1.1          //toc do di chuyen cua Bullet
    var scoreLabel : SKLabelNode!               //Display your score
    var youHealth = 3
    var healthLabel : SKLabelNode!
    
    let timeNextEnemy = 70                       //khoang tgian sinh enemy
    let timeNextBulletEnemy = 5                 //khoang tgian sinh bullet
    let MAXEnemy = 2                          //so luong enemy
    let MAXGate = 4                             //so luong Gate
    var nest : View!
    var youController : YouController!
    var starController : StarController!
    var backGroundController : BackGroundController!
    var backGround : View!
    
    let positionNest = CGPoint(x: 1, y: 0.5)    //vi tri nest tuong doi voi Gamescene vd:(1,0) nghia la goc duoi phai
    
    override func didMove(to view: SKView) {
        addBackground()
        //vi tri Nest chinh xac trong GameScene
        let positionNestInGS = CGPoint(x: self.frame.size.width * positionNest.x, y: self.frame.size.height * positionNest.y)
        addGate(firstArg: "gate1_0.png", secondArg: 0, thirdArg: CGPoint.zero)
        addGate(firstArg: "gate2_0.png", secondArg: 1, thirdArg: CGPoint(x: self.frame.size.width, y: 0))
        addGate(firstArg: "gate2_0.png", secondArg: 2, thirdArg: CGPoint(x: 0, y: self.frame.size.height))
        addGate(firstArg: "gate1_0.png", secondArg: 3, thirdArg: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        addNest(positionNestInGS)   //them nest vao vitri positionNestInGS
        addMain()   //player
        addStar()   //star - food
        scoreLabel = SKLabelNode(text: "Score :\(yourScore)")
        healthLabel = SKLabelNode(text: "Health:\(youHealth)")
        addChild(scoreLabel)
        configurePhysics()
    }
    func configurePhysics() {
        self.physicsWorld.gravity = CGVector(dx:0, dy:0)
        self.physicsWorld.contactDelegate = self
    }
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        let nodeA = bodyA.node as! View
        let nodeB = bodyB.node as! View
        
        if let aHandleContact = nodeA.handleContact {
            aHandleContact(nodeB)
        }
        if let bHandleContact = nodeB.handleContact {
            bHandleContact(nodeA)
        }
    }
    
    func updateHealthLabel()  {
        //update score
        healthLabel.removeFromParent()   //remove label cu
        healthLabel = SKLabelNode(text: "Health :\(youHealth)")   //them label moi
        healthLabel.position = CGPoint(x: self.frame.width/2, y: 0 + scoreLabel.frame.height)
        healthLabel.fontName = "Tahoma"
        healthLabel.fontColor = UIColor.white
        healthLabel.fontSize = 20
        addChild(healthLabel)    //hien thi label moi
    }

    func updateLabel()  {
        //update score
        scoreLabel.removeFromParent()   //remove label cu
        scoreLabel = SKLabelNode(text: "Score :\(yourScore)")   //them label moi
        scoreLabel.position = CGPoint(x: self.frame.width/2, y: self.frame.height - scoreLabel.frame.height)
        scoreLabel.fontName = "Tahoma"
        scoreLabel.fontColor = UIColor.white
        scoreLabel.fontSize = 20
        addChild(scoreLabel)    //hien thi label moi
    }
//    func music_Background() {
//        musicBackground = View()
//        musicBackground.run(SKAction.repeatForever(SKAction.sequence([
//            SKAction.playSoundFileNamed("backGround_Music.wav", waitForCompletion: true),
//            SKAction.wait(forDuration: 0.1)
//            ])))
//        addChild(musicBackground)
//        
//    }
    func addBackground(){
        //cai background
        backGround = View()
        self.backGroundController = BackGroundController(view: backGround)
        backGroundController.setup(parent: self)
        addChild(backGround)
        
    }
    
    func addNest(_ location : CGPoint){
        //cai Nest vao vi tri location
        nest = View(imageNamed: "nest_0.png")
        let positionNestInGS = CGPoint(x: self.frame.size.width * positionNest.x, y: self.frame.size.height * positionNest.y)
        nest.anchorPoint = CGPoint(x: 1, y: 0.5)
        nest.setScale(0.17)// chinh kich thuoc Nest
        nest.position = location
        addChild(nest)
        var nestShotTexures : [SKTexture] = []
        let nameNestFormat = "nest_"
        for i in 0..<3 {
            let imageName = "\(nameNestFormat)\(i).png"
            let nestShotTexture = SKTexture(imageNamed: imageName)
            nestShotTexures.append(nestShotTexture)
        }
        let animateShot = SKAction.animate(with: nestShotTexures, timePerFrame: 0.07)
        
        let enemyShot = SKAction.run {
            self.addEnemyBullet(positionNestInGS)
            print("1")
        }
        let playShotSound = SKAction.playSoundFileNamed("shoot.wav", waitForCompletion: false)
        let enemyShotPeriod = SKAction.sequence([SKAction.wait(forDuration: 1),animateShot,enemyShot,playShotSound, ])
        nest.run(SKAction.repeatForever(enemyShotPeriod))
        let enemySpawn = SKAction.run {
            self.addEnemy(firstArg: positionNestInGS, secondArg: self.indexEnemy)
            self.indexEnemy += 1
        }
        var nestOpenTextures : [SKTexture] = []
        let nestOpen_0 = SKTexture(imageNamed: "nest_0")
        nestOpenTextures.append(nestOpen_0)
        let nestOpen_1 = SKTexture(imageNamed: "nest_open_1")
        nestOpenTextures.append(nestOpen_1)
        let nestOpen_2 = SKTexture(imageNamed: "nest_open_2")
        nestOpenTextures.append(nestOpen_2)
        let enemySpawnSound = SKAction.playSoundFileNamed("enemy_sound.wav", waitForCompletion: false)
        let animateOpen = SKAction.animate(with: nestOpenTextures, timePerFrame: 0.07)
        let enemySpawnPeriod = SKAction.sequence([SKAction.wait(forDuration: 7),animateOpen, enemySpawn, enemySpawnSound])
        nest.run(SKAction.repeatForever(enemySpawnPeriod))
    }
    
    func addMain() {
        //add player vao trung tam
        you = View(imageNamed: "main.png")
        you.setScale(0.8) //chinh lai kich thuoc player
        you.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        self.youController = YouController(view : you as! View)
        youController.setup(parent: self)
        addChild(you)
        you.name = "you"
        
    }
    
    func addStar() {
        //them star
        let star = View(imageNamed: "star2.png")
        star.setScale(0.1)  //chinh lai kich thuoc star
        
        //set position cua star bat ki
        self.starController = StarController(view: star)
        starController.setup(parent: self, nest: nest)
        star.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run {
                self.yourScore = self.starController.score
            }, SKAction.wait(forDuration: 0.01)
            ])))
        
        addChild(star)
    }
    
    func addGate(firstArg name : String, secondArg index : Int, thirdArg positionGate : CGPoint) {
        //them Gate voi image:name, chi so Gate la index, vi tri Gate: positionGate
        let gate = SKSpriteNode(imageNamed: name)
        gate.setScale(0.03) //chinh lai kich thuoc
        gate.position = positionGate
        var gateTextures : [SKTexture] = []
        let nameGateFormat = name.replacingOccurrences(of: "0.png", with: "")
        print(nameGateFormat)
        for i in 0..<2 {
            let imageName = "\(nameGateFormat)\(i).png"
            let gateTexure = SKTexture(imageNamed: imageName)
            gateTextures.append(gateTexure)
        }
        let animateGate = SKAction.animate(with: gateTextures, timePerFrame: 0.2)
        gate.run(SKAction.repeatForever(animateGate))
        
        addChild(gate)
        //chen vao danh sach cac gate
        gates.insert(gate, at: index)
        //center la point trung tam cua GameScene
        let center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        //cac Gate test va cham forever
        let test = SKAction.run {
            // khoang cach xay ra va cham la bound
            let bound = (gate.frame.size.height + gate.frame.size.width) / 4
            if self.you.position.distance(gate.position) < bound {
                var yourPosition = CGPoint(x: self.frame.size.width, y: self.frame.size.height)
                yourPosition = yourPosition.subtract(positionGate)
                //can dat vi tri cua player ra xa hon bound so voi newGate moi de ko bi cham vao newGate
                //vector: vector can dich chuyen so voi vitri newGate
                let vector = center.subtract(yourPosition).normalize().multiply(bound * 1.5)
                self.you.position = yourPosition.add(vector)
                //                self.you.position = CGPoint(x: self.frame.size.width/2, y: self.size.height)
            }
        }
        let testPeriod = SKAction.sequence([test,SKAction.wait(forDuration: 0.01)])
        let testForever = SKAction.repeatForever(testPeriod)
        gate.run(testForever)
    }
    func addEnemy(firstArg positionEnemy : CGPoint, secondArg index : Int){
        //sinh ra enemy lan thu index + 1
        let enemy = SKSpriteNode(imageNamed: "enemy_1.png")
        var enemyTextures : [SKTexture] = []
        let texture_0 = SKTexture(imageNamed: "enemy_0.png")
        enemyTextures.append(texture_0)
        let texture_1 = SKTexture(imageNamed: "enemy_1.png")
        enemyTextures.append((texture_1))
        let enemyAnimate = SKAction.animate(with: enemyTextures, timePerFrame: 0.1)
        enemy.run(SKAction.repeatForever(enemyAnimate))
        enemy.setScale(0.029)
        enemy.position = positionEnemy
        let flyEnemy = SKAction.run {
            for (en,sp) in self.enemies {
                en.position = en.position.add(self.you.position.subtract(en.position).normalize().multiply(sp))
            }
        }
        self.run(SKAction.repeatForever(SKAction.sequence([flyEnemy, SKAction.wait(forDuration: 0.03)])))
        enemies.insert((enemy, enemySpeed * (1 + CGFloat(index)/15)), at: index % MAXEnemy)
        addChild(enemy)
    }
    
    func addEnemyBullet(_ positionBulletEnemy : CGPoint) {
        //them bullet ban ra tu positionBulletEnemy
        let enemyBullet = SKSpriteNode(imageNamed: "bullet-red-dot.png")
        enemyBullet.setScale(0.5)
        
        enemyBullet.position = positionBulletEnemy
        //vector dich chuyen
        let vectorMove = you.position.subtract(positionBulletEnemy).normalize().multiply(self.frame.size.height)
        //Action dich chuyen
        let move = SKAction.move(by: CGVector(dx: vectorMove.x, dy: vectorMove.y), duration: TimeInterval ((self.frame.size.height + self.frame.size.width)/100/enemyBulletSpeed))
        let movePeriod = SKAction.sequence([move, SKAction.wait(forDuration: 0.01)])
        let moveForever = SKAction.repeatForever(movePeriod)
        enemyBullet.run(moveForever)
        //        //check va cham forever
        addChild(enemyBullet)
        enemyBullet.name = "enemyBullet"
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first{
            let touchPosition = touch.location(in: self)
            self.youController = YouController(view: you as! View)
            youController.moveTo(position: touchPosition)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        updateLabel()
        updateHealthLabel()
        //check va cham cua cac enemy voi player
        for(enIndex,(en,_)) in enemies.enumerated() {
            if en.position.distance(you.position) < (en.frame.size.height + en.frame.size.width) / 2{
                youHealth = youHealth - 2
                en.removeFromParent()
                
                
            }
        }
        enumerateChildNodes(withName: "you"){
            youNode, _ in
            self.enumerateChildNodes(withName: "enemyBullet"){
                enemyBulletNode, _ in
                let bulletFrame = enemyBulletNode.frame
                let youFrame = youNode.frame
                if bulletFrame.intersects(youFrame){
                    self.youHealth = self.youHealth - 1
                    enemyBulletNode.removeFromParent()
                    
                    
                }
            }
        }
        if youHealth <= 0 {
            self.removeFromParent()
            let gameOver = GameOverSence(size: (self.view?.frame.size)!)
            gameOver.set_up(score: self.yourScore)
            self.view?.presentScene(gameOver, transition: SKTransition.fade(with: UIColor.blue, duration: 0.1))
        }
    }
}

