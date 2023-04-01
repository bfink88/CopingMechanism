//
//  GameScene.swift
//  CopingMechanism
//
//  Created by Brandon Fink on 12/5/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var circleArray: [hourCircle] = []
    var circlenum = 0
    var ymultiplier = -0.4
    var xmultiplier = -0.30
    var centerline = SKShapeNode()
    var startingx = CGFloat()
    var startingy = CGFloat()
    var holdCounter = 0
    var flagA = 0
    var number0 = SKLabelNode()
    var number25 = SKLabelNode()
    var number50 = SKLabelNode()
    var number75 = SKLabelNode()
    var number100 = SKLabelNode()
    var touchedCircle = SKSpriteNode()
    var touchedhourCircle = hourCircle()
    let UD = UserDefaults()
    
    class hourCircle {
        var circName = ""
        var filled = 0
        var index = 0
        var spriteNode = SKSpriteNode(imageNamed: "circle0")
    }
    
    override func didMove(to view: SKView) {
        

        for i in 1...4 {
            startingx = self.frame.width * self.xmultiplier
            self.ymultiplier = -0.4
            for j in 1...10 {
                var newCircle = hourCircle()
                startingy = self.frame.height * self.ymultiplier
                //var circlenew = SKSpriteNode(imageNamed: "circle0")
                newCircle.circName = nameCircle(circlecounter: self.circlenum)
                newCircle.spriteNode.name = nameCircle(circlecounter: self.circlenum)
                newCircle.index = self.circlenum
                self.circlenum+=1
                //circlenew.name = nameCircle(circlecounter: self.circlenum)
                //circlenew.position = CGPoint(x: startingx, y: startingy)
                newCircle.spriteNode.position = CGPoint(x: startingx, y: startingy)
                self.addChild(newCircle.spriteNode)
                //self.circleArray.add(circlenew)
                self.circleArray.append(newCircle)
                self.ymultiplier += 0.09
            }
            self.xmultiplier += 0.2
        }
        if let c0 = UD.value(forKey: "Namecircle0") as? Int{
            loadCircles()
            //let c0String = String(c0)
            //NSLog(c0String)
        }
        //self.circleA = SKSpriteNode(imageNamed: "circle0")
        //self.circleB = SKSpriteNode(imageNamed: "circle0")
        //self.circleC = SKSpriteNode(imageNamed: "circle0")
        //self.circleD = SKSpriteNode(imageNamed: "circle0")
        self.centerline = SKShapeNode(rect: CGRect(x: 0, y: (self.frame.height/2) * -1, width: 5, height: self.frame.height))
        //circleA.name="circleA"
        //circleB.name="circleB"
        //circleC.name="circleC"
        //circleD.name="circleD"
        centerline.name="centerline"
        //circleA.position = CGPoint(x: startingx, y: startingy)
        //circleB.position = CGPoint(x: startingx * 2.5, y: startingy*2)
        //circleC.position = CGPoint(x: startingx * -1, y: startingy*3)
        //circleD.position = CGPoint(x: startingx * -2.5, y: startingy*4)
        
        //self.addChild(circleA)
        self.addChild(centerline)
        //self.addChild(circleB)
        //self.addChild(circleC)
        //self.addChild(circleD)
        

    }
    func nameCircle(circlecounter num : Int) -> String {
        let circName = "circle" + String(self.circlenum)
        return circName
    }
    
    func touchDown(atPoint pos : CGPoint) {
        for hc in self.circleArray {
            if hc.spriteNode.contains(pos){
                self.flagA = 1
                self.touchedCircle = hc.spriteNode
                self.touchedhourCircle = hc
                //NSLog(hc.spriteNode.name!)
            }
        }
        switch self.touchedhourCircle.filled{
        case 0:
            self.holdCounter=0
        case 25:
            self.holdCounter=100
        case 50:
            self.holdCounter=200
        case 75:
            self.holdCounter=300
        case 100:
            self.holdCounter=400
        default:
            self.holdCounter=0
        }
        /*for node in self.children {
            if node.contains(pos) {
                self.flagA = 1
                self.touchedCircle=node as! SKSpriteNode
                NSLog(node.name!)
            }
        }
         */
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
 
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchMoved(toPoint: t.location(in: self))

        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchUp(atPoint: t.location(in: self))
            self.flagA = 0
            self.holdCounter = 0
            self.touchedCircle = SKSpriteNode()
            self.number0.removeFromParent()
            self.number25.removeFromParent()
            self.number50.removeFromParent()
            self.number75.removeFromParent()
            self.number100.removeFromParent()
            
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if self.flagA == 1 {
            //NSLog("Holding A")
            self.holdCounter+=1
        }

        if self.holdCounter == 100{
            self.number100.removeFromParent()
            show0()
        }else if(self.holdCounter == 200){
            show25()
        }else if(self.holdCounter == 300){
            show50()
        }else if(self.holdCounter == 400){
            show75()
        }else if(self.holdCounter == 500){
            show100()
            self.holdCounter=0
        }
        
    }
    func show0(){
        var circlepoint = self.touchedCircle.position
        var circleName = self.touchedCircle.name
        self.touchedCircle.removeFromParent()
        self.touchedCircle = SKSpriteNode(imageNamed: "circle0")
        self.touchedCircle.position = circlepoint
        self.touchedCircle.name = circleName
        self.addChild(self.touchedCircle)
        self.number0 = SKLabelNode(text: "0%")
        self.number0.fontColor = UIColor.red
        self.addChild(number0)
        self.number0.fontSize=48
        self.number0.position=CGPoint(x: circlepoint.x, y: circlepoint.y+25)
        //NSLog(self.touchedCircle.name!)
        NSLog(String(self.touchedhourCircle.index))
        self.touchedhourCircle.filled=0
        self.saveCircles()
        
    }
    func show25(){
        var circlepoint = self.touchedCircle.position
        var circleName = self.touchedCircle.name
        self.touchedCircle.removeFromParent()
        self.touchedCircle = SKSpriteNode(imageNamed: "circle25")
        self.touchedCircle.position = circlepoint
        self.touchedCircle.name = circleName
        self.addChild(self.touchedCircle)
        self.number0.removeFromParent()
        self.number25 = SKLabelNode(text: "25%")
        self.number25.fontColor = UIColor.red
        self.addChild(number25)
        self.number25.fontSize=48
        self.number25.position=CGPoint(x: circlepoint.x, y: circlepoint.y+25)
        //NSLog(self.touchedCircle.name!)
        NSLog(String(self.touchedhourCircle.index))
        self.touchedhourCircle.filled=25
        self.saveCircles()


    }
    
    func show50(){
        var circlepoint = self.touchedCircle.position
        var circleName = self.touchedCircle.name
        self.touchedCircle.removeFromParent()
        self.touchedCircle = SKSpriteNode(imageNamed: "circle50")
        self.touchedCircle.position = circlepoint
        self.touchedCircle.name = circleName
        self.addChild(self.touchedCircle)
        self.number25.removeFromParent()
        self.number50 = SKLabelNode(text: "50%")
        self.number50.fontColor = UIColor.red
        self.addChild(number50)
        self.number50.fontSize=48
        self.number50.position=CGPoint(x: circlepoint.x, y: circlepoint.y+25)
        //NSLog(self.touchedCircle.name!)
        NSLog(String(self.touchedhourCircle.index))
        self.touchedhourCircle.filled=50
        self.saveCircles()

    }
    func show75(){
        var circlepoint = self.touchedCircle.position
        var circleName = self.touchedCircle.name
        self.touchedCircle.removeFromParent()
        self.touchedCircle = SKSpriteNode(imageNamed: "circle75")
        self.touchedCircle.position = circlepoint
        self.touchedCircle.name = circleName
        self.addChild(self.touchedCircle)
        self.number50.removeFromParent()
        self.number75 = SKLabelNode(text: "75%")
        self.number75.fontColor = UIColor.red
        self.addChild(number75)
        self.number75.fontSize=48
        self.number75.position=CGPoint(x: circlepoint.x, y: circlepoint.y+25)
        //NSLog(self.touchedCircle.name!)
        NSLog(String(self.touchedhourCircle.index))
        self.touchedhourCircle.filled=75
        self.saveCircles()

    }
    func show100(){
        var circlepoint = self.touchedCircle.position
        var circleName = self.touchedCircle.name
        self.touchedCircle.removeFromParent()
        self.touchedCircle = SKSpriteNode(imageNamed: "circle100")
        self.touchedCircle.position = circlepoint
        self.touchedCircle.name = circleName
        self.addChild(self.touchedCircle)
        self.number75.removeFromParent()
        self.number100 = SKLabelNode(text: "100%")
        self.number100.fontColor = UIColor.red
        self.addChild(number100)
        self.number100.fontSize=48
        self.number100.position=CGPoint(x: circlepoint.x, y: circlepoint.y+25)
        //NSLog(self.touchedCircle.name!)
        NSLog(String(self.touchedhourCircle.index))
        self.touchedhourCircle.filled=100
        self.saveCircles()
    }
    
    func saveCircles(){
        for saveCirc in self.circleArray {
            UD.set(saveCirc.filled, forKey:"Name" + saveCirc.circName)
            UD.set(saveCirc.spriteNode.position.x, forKey: "POSx" + saveCirc.circName)
            UD.set(saveCirc.spriteNode.position.y, forKey: "POSy" + saveCirc.circName)

        }
    }
    func loadCircles(){
        for loadCirc in self.circleArray {
            if let c = UD.value(forKey:"Name" + loadCirc.circName) as? Int{
                loadCirc.filled = c
                var circlepointx = UD.value(forKey: "POSx" + loadCirc.circName) as! CGFloat
                var circlepointy = UD.value(forKey: "POSy" + loadCirc.circName) as! CGFloat
                var circlepointxy = CGPoint(x: circlepointx, y:circlepointy)
                var circleName = loadCirc.spriteNode.name as! String
                switch loadCirc.filled{
                case 0:
                    loadCirc.spriteNode.removeFromParent()
                    loadCirc.spriteNode.name = circleName
                    
                    loadCirc.spriteNode = SKSpriteNode(imageNamed: "circle0")
                    loadCirc.spriteNode.position = circlepointxy
                    self.addChild(loadCirc.spriteNode)
                case 25:
                    loadCirc.spriteNode.removeFromParent()
                    loadCirc.spriteNode.name = circleName
                    
                    loadCirc.spriteNode = SKSpriteNode(imageNamed: "circle25")
                    loadCirc.spriteNode.position = circlepointxy
                    self.addChild(loadCirc.spriteNode)
                case 50:
                    loadCirc.spriteNode.removeFromParent()
                    loadCirc.spriteNode.name = circleName
                    loadCirc.spriteNode = SKSpriteNode(imageNamed: "circle50")
                    loadCirc.spriteNode.position = circlepointxy

                    self.addChild(loadCirc.spriteNode)
                case 75:
                    loadCirc.spriteNode.removeFromParent()
                    loadCirc.spriteNode.name = circleName
                    loadCirc.spriteNode = SKSpriteNode(imageNamed: "circle75")
                    loadCirc.spriteNode.position = circlepointxy

                    self.addChild(loadCirc.spriteNode)
                case 100:
                    loadCirc.spriteNode.removeFromParent()
                    loadCirc.spriteNode.name = circleName
                    loadCirc.spriteNode = SKSpriteNode(imageNamed: "circle100")
                    loadCirc.spriteNode.position = circlepointxy

                    self.addChild(loadCirc.spriteNode)
                default:
                    loadCirc.spriteNode.removeFromParent()
                    loadCirc.spriteNode.name = circleName
                    loadCirc.spriteNode = SKSpriteNode(imageNamed: "circle0")
                    loadCirc.spriteNode.position = circlepointxy

                    self.addChild(loadCirc.spriteNode)
                }
                
                
                let c0String = String(c)
                NSLog(loadCirc.circName + " " + c0String)
            }
            
        }
    }
    
    
}
