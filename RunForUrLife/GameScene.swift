//
//  GameScene.swift
//  RunForUrLife
//
//  Created by Hai on 9/10/16.
//  Copyright (c) 2016 HaiTrung. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var you : View!                     //player
    var lastUpdateTime : TimeInterval = -1
    var gates : [SKSpriteNode] = []             //cac Gate
    var yourScore = 0
    var yourSpeed : CGFloat = 1.5               //toc do di chuyen cua player
    var scoreLabel : SKLabelNode!               //Display your score
    var youHealth = 3
    var healthLabel : SKLabelNode!
    
    
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
        addMain()
        addNest(positionNestInGS)   //them nest vao vitri positionNestInGS
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
    }
}

