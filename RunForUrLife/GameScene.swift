//
//  GameScene.swift
//  RunForUrLife
//
//  Created by Hai on 9/10/16.
//  Copyright (c) 2016 HaiTrung. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
<<<<<<< HEAD
    var you : youView!                   //player
=======
    var you : View!                     //player
>>>>>>> ef982c5789889e9bb01a22176632e6bc76a1ee16
    var lastUpdateTime : TimeInterval = -1
    var gates : [SKSpriteNode] = []             //cac Gate
    var yourScore = 0
    var yourSpeed : CGFloat = 1.5               //toc do di chuyen cua player
<<<<<<< HEAD
    var scoreLabel : View!               //Display your score
    var youHealth = 5
    var healthLabel : SKSpriteNode!
    var powerUp = false
    
=======
    var scoreLabel : SKLabelNode!               //Display your score
    var youHealth = 3
    var healthLabel : SKLabelNode!
    
    
>>>>>>> ef982c5789889e9bb01a22176632e6bc76a1ee16
    let MAXGate = 4                             //so luong Gate
    var nest : View!
    var nest1: View!
    var youController : YouController!
    var starController : StarController!
    var nestController : NestController!
    var backGroundController : BackGroundController!
    var backGround : View!
    var label : View!
    var labelController : LabelController!
    var powerController : PowerController!
    var healerCoontroler : HealerController!
    let positionNest = CGPoint(x: 1, y: 0.5)    //vi tri nest tuong doi voi Gamescene vd:(1,0) nghia la goc duoi phai
    
    override func didMove(to view: SKView) {
        
        addBackground()
        adddGameSound()
        //vi tri Nest chinh xac trong GameScene
        let positionNestInGS = CGPoint(x: self.frame.size.width * positionNest.x, y: self.frame.size.height * positionNest.y)
        addGate(firstArg: "gate1_0.png", secondArg: 0, thirdArg: CGPoint.zero)
        addGate(firstArg: "gate2_0.png", secondArg: 1, thirdArg: CGPoint(x: self.frame.size.width, y: 0))
        addGate(firstArg: "gate2_0.png", secondArg: 2, thirdArg: CGPoint(x: 0, y: self.frame.size.height))
        addGate(firstArg: "gate1_0.png", secondArg: 3, thirdArg: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
<<<<<<< HEAD
        addPower()
        addHealer()
        addMain()
           //them nest vao vitri positionNestInGS
        addNest1(positionNestInGS)
        addStar()  //star - food
        addLabel()
        addNest(positionNestInGS)
=======
        addMain()
        addNest(positionNestInGS)   //them nest vao vitri positionNestInGS
        addStar()   //star - food
        scoreLabel = SKLabelNode(text: "Score :\(yourScore)")
        healthLabel = SKLabelNode(text: "Health:\(youHealth)")
        addChild(scoreLabel)
>>>>>>> ef982c5789889e9bb01a22176632e6bc76a1ee16
        configurePhysics()
    }
    func addHealer() {
        let healer = View(imageNamed: "Heal_Icon.png")
        
        self.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run {
                healer.removeFromParent()
            }
            ,SKAction.wait(forDuration: 12),
             SKAction.run {
                healer.setScale(0.1)
                self.healerCoontroler = HealerController(view: healer)
                self.healerCoontroler.setup(parent: self, nest : self.nest)
                healer.run(SKAction.repeatForever(SKAction.sequence([
                    SKAction.run {
                        //self.poweUP = self.powerController.powerUP
                    }, SKAction.wait(forDuration: 0.01)
                    ])))
                
                self.addChild(healer)
            }, SKAction.wait(forDuration: 5)
            ])))
    }

    func addPower() {
        let power = View(imageNamed: "power.png")
        
        self.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run {
                power.removeFromParent()
            }
            ,SKAction.wait(forDuration: 10),
             SKAction.run {
                power.setScale(0.1)
                self.powerController = PowerController(view: power)
                self.powerController.setup(parent: self, nest : self.nest)
                power.run(SKAction.repeatForever(SKAction.sequence([
                    SKAction.run {
                        //self.poweUP = self.powerController.powerUP
                    }, SKAction.wait(forDuration: 0.01)
                    ])))
                
                self.addChild(power)
            }, SKAction.wait(forDuration: 5)
            ])))
    }
    func addStar() {
        //them star
        let star = View(imageNamed: "star2.png")
        star.setScale(0.1)  //chinh lai kich thuoc star
        
        //set position cua star bat ki
        self.starController = StarController(view: star)
        starController.setup(parent: self, nest: nest1)
        star.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run {
                self.yourScore = self.starController.score
            }, SKAction.wait(forDuration: 0.01)
            ])))
        
        addChild(star)
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
    
    func addLabel()  {
        label = View()
        self.labelController = LabelController(view: label)
        self.labelController.setup(parent: self)
        label.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run {
                self.labelController.update(score : self.yourScore, health : self.youHealth)
            }, SKAction.wait(forDuration: 0.1)
            ])))
        addChild(label)
        
    }
    func adddGameSound() {
        let gameSound = SKAudioNode(fileNamed: "backGround_Music.wav")
        gameSound.run(SKAction.changeVolume(to: 0.1, duration: 0.1))
        addChild(gameSound)
    }
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
<<<<<<< HEAD
        nest.anchorPoint = CGPoint(x: 1, y: 0.5)
        nest.setScale(0.17)// chinh kich thuoc Nest
        nest.position = location
        self.nestController = NestController(view : nest)
        self.nestController.update(self.you)
        self.nestController.setup(parent: self)
        nest.run(SKAction.repeatForever(SKAction.sequence(
            [SKAction.run({
                self.nestController.update(self.you)
                self.nestController.score = self.yourScore
            }), SKAction.wait(forDuration: 0.1)])))

        addChild(nest)
    }
    func addNest1(_ location : CGPoint){
        //cai Nest vao vi tri location
        nest1 = View(imageNamed: "nest_0.png")
        nest1.anchorPoint = CGPoint(x: 1, y: 0.5)
        nest1.setScale(0.17)// chinh kich thuoc Nest
        nest1.position = location
        addChild(nest1)
        
=======
        //        let positionNestInGS = CGPoint(x: self.frame.size.width * positionNest.x, y: self.frame.size.height * positionNest.y)
        nest.anchorPoint = CGPoint(x: 1, y: 0.5)
        nest.setScale(0.17)// chinh kich thuoc Nest
        nest.position = location
        
        let nestController = NestController(view: nest)
        
        nestController.update(self.you)
        
        nest.run(SKAction.repeatForever(SKAction.sequence(
            [SKAction.run({
                nestController.update(self.you)
            }), SKAction.wait(forDuration: 0.01)])))
        nestController.setup(parent: self)
        
        addChild(nest)
>>>>>>> ef982c5789889e9bb01a22176632e6bc76a1ee16
    }
    
    
    func addMain() {
        //add player vao trung tam
        you = youView(imageNamed: "main.png")
        you.setScale(0.8) //chinh lai kich thuoc player
        you.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        self.youController = YouController(view : you as youView)
        youController.setup(parent: self)
        you.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run {
                self.youHealth = self.youController.youHealth
                self.youController.update(self.you)
                //self.powerUp = self.youController.powerUp
            }, SKAction.wait(forDuration: 0.1)
            ])))
        addChild(you)
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let touchPosition = touch.location(in: self)
            youController.moveTo(position: touchPosition)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
<<<<<<< HEAD
        if youHealth <= 0 {
            let gameOver = GameOverSence(size: (self.view?.frame.size)!)
            gameOver.set_up(score: self.yourScore)
            self.view?.presentScene(gameOver, transition: SKTransition.fade(with: UIColor.blue, duration: 0.1))
        }
=======
        updateLabel()
        updateHealthLabel()
>>>>>>> ef982c5789889e9bb01a22176632e6bc76a1ee16
    }
}

