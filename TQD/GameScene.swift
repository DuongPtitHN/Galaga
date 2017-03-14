//
//  GameScene.swift
//  TQD
//
//  Created by admin on 3/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import SpriteKit
import GameplayKit



struct Physicscatagory {
    static let enemy : UInt32 = 1 << 1
    static let player : UInt32 = 1 << 2
    static let playerBullets : UInt32 = 1 << 3
    static let enemyBullets : UInt32 = 1 << 4
    
}
class GameScene: SKScene, SKPhysicsContactDelegate {
    var score : Int = 0
    var scoreLbl = UILabel()
    let playerNode = SKSpriteNode(imageNamed: "player.png")
    let arrayTemp : [[Int]] = [
        [1,0,1,0,1],
        [0,1,1,1,0],
        [1,1,1,1,1]
    ]
    var playerBullets: [SKSpriteNode] = []
    var flies : [SKSpriteNode] = []
    
    let playerShootSoundAction = SKAction.playSoundFileNamed("player-shoot.wav", waitForCompletion: false)
    let playerExplosionSound = SKAction.playSoundFileNamed("player-explosion", waitForCompletion: false)
    var enemyButllets: [SKSpriteNode] = []
    //textures anh
    let fly1Texture = SKTexture(imageNamed: "fly")
    let fly2Texture = SKTexture(imageNamed: "fly-1-2")
    let explosion1Texture = SKTexture(imageNamed: "explosion-0")
    let explosion2Texture = SKTexture(imageNamed: "explosion-1")
    let explosion3Texture = SKTexture(imageNamed: "explosion-2")
    let explosion4Texture = SKTexture(imageNamed: "explosion-3")
    let explosion5Texture = SKTexture(imageNamed: "explosion-2-1")
    let explosion6Texture = SKTexture(imageNamed: "explosion-2-2")
    let explosion7Texture = SKTexture(imageNamed: "explosion-2-3")
    let explosion8Texture = SKTexture(imageNamed: "explosion-2-4")
    
   
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0,y: 0)
        addPlayer()
        configPhy()
        addStartField()
        addFly()
        scoreLbl.text = "\(score)"
        scoreLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20 ))
        scoreLbl.textColor = UIColor.red
        self.view?.addSubview(scoreLbl)
        
    }
    func addStartField() -> Void {
    if let startActionNode = SKEmitterNode(fileNamed: "MyParticle.sks"){
        startActionNode.position.y = self.size.height
        addChild(startActionNode)
        }
    }
    func configPhy() -> Void {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate =  self
    }
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        guard let nodeA = bodyA.node, let nodeB = bodyB.node else {
            return
        }
        if ((bodyA.categoryBitMask == Physicscatagory.enemy) && (bodyB.categoryBitMask == Physicscatagory.playerBullets) || (bodyA.categoryBitMask == Physicscatagory.playerBullets) && (bodyB.categoryBitMask == Physicscatagory.enemy))   {
            nodeA.removeFromParent()
            nodeB.removeFromParent()
            addExplosion(position: nodeA.position)
            score = score + 10
            scoreLbl.text = "\(score)"
        }
         if ((bodyA.categoryBitMask == Physicscatagory.enemyBullets) && (bodyB.categoryBitMask == Physicscatagory.player) || (bodyA.categoryBitMask == Physicscatagory.player) && (bodyB.categoryBitMask == Physicscatagory.enemyBullets))   {
            nodeA.removeFromParent()
            nodeB.removeFromParent()
            nodeA.run(playerExplosionSound)
            addExplosionPlayer(position: nodeA.position)
        }
    }
    func addExplosion(position: CGPoint) -> Void {
        let explosionNode = SKSpriteNode(imageNamed: "explosion-0")
        explosionNode.position = position
        addChild(explosionNode)
        var acctionArray = [SKAction]()
        acctionArray.append(SKAction.animate(with:[explosion1Texture, explosion2Texture, explosion3Texture, explosion4Texture], timePerFrame: 0.05))
        acctionArray.append(SKAction.removeFromParent())
        explosionNode.run(SKAction.sequence(acctionArray))
    }
    func addExplosionPlayer(position: CGPoint) -> Void {
        let explosionNode = SKSpriteNode(imageNamed: "explosion-2-1")
        explosionNode.position = position
        addChild(explosionNode)
        var acctionArray = [SKAction]()
        acctionArray.append(SKAction.animate(with:[explosion5Texture, explosion6Texture, explosion7Texture, explosion8Texture], timePerFrame: 0.5))
        acctionArray.append(SKAction.removeFromParent())
        explosionNode.run(SKAction.sequence(acctionArray))
    }
    
    func addFly() -> Void {
        let flywith : CGFloat  = 28
        let flyspace : CGFloat = 10
        let flyXStart : CGFloat = 15
        let flyXMid : CGFloat = size.width / 2
        let flyIndexXMid : CGFloat = 2
        for flyIndex in 0..<5{
            for flyIndex2 in 0..<3
            {
                if (arrayTemp[flyIndex2][flyIndex] == 1  ){
                    let SPACE = flywith + flyspace
                    let flyX : CGFloat = flyXMid + (CGFloat(flyIndex) - flyIndexXMid) * SPACE
                    let flyY : CGFloat = size.height
                    var enemyNode = SKSpriteNode(imageNamed: "fly.png")
                    enemyNode.anchorPoint = CGPoint(x: 0.5, y: 1)
                    enemyNode.position = CGPoint(x: flyX, y: flyY - CGFloat(flyIndex2)*32)
                    enemyNode.physicsBody = SKPhysicsBody(rectangleOf: enemyNode.size)
                    enemyNode.physicsBody?.collisionBitMask = 0
                    enemyNode.physicsBody?.linearDamping = 0
                    enemyNode.physicsBody?.categoryBitMask = Physicscatagory.enemy
                    enemyNode.physicsBody?.contactTestBitMask = Physicscatagory.playerBullets
                    addChild(enemyNode)
                    flies.append(enemyNode)
                    enemyNode.run(SKAction.repeatForever(SKAction.animate(with: [fly1Texture, fly2Texture], timePerFrame: 0.5)))
                    var acctionArray = [SKAction]()
                    acctionArray.append(SKAction.moveTo(x:  enemyNode.position.x + 100, duration: 2))
                    acctionArray.append(SKAction.moveTo(x: enemyNode.position.x - 100, duration: 2))
                    acctionArray.append(SKAction.moveTo(y: enemyNode.position.y - 100, duration: 2))
                    acctionArray.append(SKAction.moveTo(x:  enemyNode.position.x + 100, duration: 2))
                    acctionArray.append(SKAction.moveTo(y: enemyNode.position.y  , duration: 2))
                    enemyNode.run(SKAction.repeatForever(SKAction.sequence(acctionArray)))
                    
                }
            }
        }
    }
    func addBoss(SK : [SKSpriteNode]) -> Void {
        if SK.count == 0 {
//            let bossNode = SKSpriteNode(imageNamed: "fly-3-3.png")
//            bossNode.position = CGPoint(x: self.size.width/2, y: self.size.height - 100)
//            bossNode.size = CGSize(width: 100, height: 100)
//            addChild(bossNode)
        }
    }
    func addPlayer() -> Void {
        playerNode.anchorPoint = CGPoint(x: 0.5, y: 0)        //playerNode.size = CGSize(width: 100, height: 100)
        playerNode.position = CGPoint(x: self.size.width/2, y: 0 )
        playerNode.physicsBody = SKPhysicsBody(rectangleOf: playerNode.size)
        playerNode.physicsBody?.collisionBitMask = 0
        playerNode.physicsBody?.linearDamping = 0
        playerNode.physicsBody?.categoryBitMask = Physicscatagory.player
        playerNode.physicsBody?.contactTestBitMask = Physicscatagory.enemyBullets
        addChild(playerNode)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first{
            let location = firstTouch.location(in: self)
            playerNode.position.x = location.x
        }
    }
    
    var startTime : TimeInterval = -999
    var startTime2 : TimeInterval = -9999
    
    func shoot() -> Void {
        let bulletNode = SKSpriteNode(imageNamed: "bullet-1.png")
        bulletNode.name = "Player bullet"
        bulletNode.position = CGPoint(x: (playerNode.position.x + playerNode.size.width/2) , y: (playerNode.position.y + playerNode.size.height))
        bulletNode.physicsBody = SKPhysicsBody(rectangleOf: bulletNode.size)
        bulletNode.physicsBody?.collisionBitMask = 0
        bulletNode.physicsBody?.velocity = CGVector(dx: 0, dy: 500)
        bulletNode.physicsBody?.linearDamping = 0
        bulletNode.physicsBody?.mass = 0
        bulletNode.physicsBody?.categoryBitMask = Physicscatagory.playerBullets
        bulletNode.physicsBody?.contactTestBitMask = Physicscatagory.enemy
        bulletNode.run(playerShootSoundAction)
        addChild(bulletNode)
        playerBullets.append(bulletNode)
        
        
    }
    func enemyShoot(enemyNode: SKSpriteNode) -> Void {
        let bulletNode2 = SKSpriteNode(imageNamed: "bullet-2.png")
        bulletNode2.name = "Fly bullet"
        bulletNode2.position = CGPoint(x: (enemyNode.position.x ) , y: (enemyNode.position.y - enemyNode.size.height))
        bulletNode2.physicsBody = SKPhysicsBody(rectangleOf: bulletNode2.size)
        bulletNode2.physicsBody?.collisionBitMask = 0
        bulletNode2.physicsBody?.velocity = CGVector(dx: 0, dy: -500)
        bulletNode2.physicsBody?.linearDamping = 0
        bulletNode2.physicsBody?.mass = 0
        bulletNode2.physicsBody?.categoryBitMask = Physicscatagory.enemyBullets
        bulletNode2.physicsBody?.contactTestBitMask = Physicscatagory.player
        addChild(bulletNode2)
        enemyButllets.append(bulletNode2)
//        bulletNode2.run(SKAction.moveTo(x:  playerNode.position.x , duration: 2))
        
    }
    let Player_bullet_name = "Player bullet"
    let Fly_bullet_name = "Fly bullet"
    
    override func update(_ currentTime: TimeInterval) {
        if  startTime == -1 {
            startTime = currentTime
            startTime2 = currentTime
            
        }
        if currentTime - startTime > 0.05{
            if ( playerNode.parent != nil){
                shoot()
                startTime = currentTime
            }
        }
        if currentTime - startTime2 > 1{
            
            for fly in flies{
                enemyShoot(enemyNode: fly)
                break
            }
            startTime2 = currentTime
        }
        self.enumerateChildNodes(withName: Fly_bullet_name){ // xoá đạn
            node, pointer in
            if node.position.y < 0{
                node.removeFromParent()
            }
        }
        for playerBullet in self.playerBullets{ // xoá đạn
            if playerBullet.position.y > self.size.height{
                playerBullet.removeFromParent()
            }
        }
        playerBullets = playerBullets.filter{
            node in
            return node.parent != nil
        }
        flies = flies.filter{
            node in
            return node.parent != nil
        }
        if flies.count == 0 {
//            self.view?.presentScene(SKScene(fileNamed: "MyScene.sks"))
            let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 1.0)
            let nextScene = MyS(size: (self.scene?.size)!)
            nextScene.scaleMode = SKSceneScaleMode.aspectFill
            self.scene?.view?.presentScene(nextScene, transition: transition)
        }
      
    }}
