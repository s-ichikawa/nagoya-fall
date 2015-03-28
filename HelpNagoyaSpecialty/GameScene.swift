//
//  GameScene.swift
//  HelpNagoyaSpecialty
//
//  Created by ichikawa on 2015/03/21.
//  Copyright (c) 2015年 ichikawa. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene : SKScene, SKPhysicsContactDelegate {
    
    
    var bowl:SKSpriteNode?
    var timer:NSTimer?
    var lowestShape:SKShapeNode?
    var score = 0;
    var scoreLabel: SKLabelNode?
    var scoreList = [100, 200, 300, 500, 800, 1000, 1500]
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
        self.physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        background.size = self.size
        self.addChild(background)
        
        let lowestShape = SKShapeNode(rectOfSize:CGSize(width: self.size.width, height: 10))
        lowestShape.position = CGPoint(x: self.size.width*0.5, y: -10)
        
        let physicsBody = SKPhysicsBody(rectangleOfSize: lowestShape.frame.size)
        physicsBody.dynamic = false
        physicsBody.contactTestBitMask = 0x1 << 1
        lowestShape.physicsBody = physicsBody
        
        self.addChild(lowestShape)
        self.lowestShape = lowestShape
        
        let bowlTexture = SKTexture(imageNamed: "bowl")
        let bowl = SKSpriteNode(texture: bowlTexture)
        bowl.position = CGPoint(x: self.size.width*0.5, y: 100)
        bowl.size = CGSize(width: bowlTexture.size().width*0.5, height: bowlTexture.size().height*0.5)
        bowl.physicsBody = SKPhysicsBody(texture: bowlTexture, size: bowl.size)
        bowl.physicsBody?.dynamic = false
        self.bowl = bowl
        self.addChild(bowl)
        
        var scoreLabel = SKLabelNode(fontNamed: "Helvetica")
        scoreLabel.position = CGPoint(x: self.size.width*0.92, y: self.size.height*0.78)
        scoreLabel.text = "¥0"
        scoreLabel.fontSize = 32
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        scoreLabel.fontColor = UIColor.greenColor()
        self.addChild(scoreLabel)
        self.scoreLabel = scoreLabel
        
        
        self.fallNagoyaSpecialty()
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "fallNagoyaSpecialty", userInfo: nil, repeats: true)
    }
    
    func fallNagoyaSpecialty() {
        let index = Int(arc4random_uniform(7))
        let texture = SKTexture(imageNamed: "\(index)")
        let sprite = SKSpriteNode(texture: texture)
        sprite.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        sprite.size = CGSize(width: texture.size().width*0.5, height: texture.size().height*0.5)
        sprite.physicsBody = SKPhysicsBody(texture: texture, size: sprite.size)
        sprite.physicsBody?.contactTestBitMask = 0x1 << 1
        self.addChild(sprite)
        self.score += self.scoreList[index]
        self.scoreLabel?.text = "¥\(self.score)"
    }

    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.node == self.lowestShape || contact.bodyB.node == self.lowestShape {
            let sprite = SKSpriteNode(imageNamed: "gameover")
            sprite.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
            self.addChild(sprite)
            self.paused = true
            self.timer?.invalidate()
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if let touch: AnyObject = touches.anyObject() {
            let location = touch.locationInNode(self)
            let action = SKAction.moveTo(CGPoint(x: location.x, y: 100), duration: 0.2)
            self.bowl?.runAction(action)
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        if let touch: AnyObject = touches.anyObject() {
            let location = touch.locationInNode(self)
            let action = SKAction.moveTo(CGPoint(x: location.x, y: 100), duration: 0.2)
            self.bowl? .runAction(action)
        }
    }
}