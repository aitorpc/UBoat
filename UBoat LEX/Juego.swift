//
//  Juego.swift
//  UBoat LEX
//
//  Created by Berganza on 16/12/2014.
//  Copyright (c) 2014 Berganza. All rights reserved.
//

import SpriteKit


class Juego: SKScene {

    
    
    
    var submarino = SKSpriteNode()
    var prisma = SKSpriteNode()
    
    var enemigo = SKSpriteNode()
    var moverEnemigo = SKAction()
    
    
    var moverArriba = SKAction()
    var moverAbajo = SKAction()
    
    
    
    let velocidadFondo: CGFloat = 2
    
    
    override func didMoveToView(view: SKView) {
        
        backgroundColor = UIColor.cyanColor()
        
        heroe()
        prismaticos()
        crearEscenario()
        enemy()
    }
    
    func heroe() {
        
        submarino = SKSpriteNode(imageNamed: "UBoat")
        
        submarino.setScale(0.6)
        submarino.zPosition = 1
        submarino.position = CGPointMake(80, 200)
        submarino.name = "heroe"
        
        addChild(submarino)
        
        moverArriba = SKAction.moveByX(0, y: 20, duration: 0.2)
        moverAbajo = SKAction.moveByX(0, y: -20, duration: 0.2)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        
        for toke: AnyObject in touches {
            
            let dondeTocamos = toke.locationInNode(self)
            
            if dondeTocamos.y > submarino.position.y {
                if submarino.position.y < 750 {
                    submarino.runAction(moverArriba)
                }
            } else {
                if submarino.position.y > 50 {
                    submarino.runAction(moverAbajo)
                }
            }
        }
    }
    
    func prismaticos() {
        
        prisma = SKSpriteNode(imageNamed: "prismatic")
        prisma.setScale(0.66)
        prisma.zPosition = 2
        prisma.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        
        addChild(prisma)
    }

    func crearEscenario() {
        
        for var indice = 0; indice < 2; ++indice {
            
            let fondo = SKSpriteNode(imageNamed: "mar4")
            fondo.position = CGPoint(x: indice * Int(fondo.size.width), y: 0)
            fondo.name = "fondo"
            fondo.zPosition = 0
            
            addChild(fondo)

        }
    }
    
    func scrollHorizontal() {
        
        self.enumerateChildNodesWithName("fondo", usingBlock: { (nodo, stop) -> Void in
            if let fondo = nodo as? SKSpriteNode {
                
                fondo.position = CGPoint(
                    x: fondo.position.x - self.velocidadFondo,
                    y: fondo.position.y)
                
                if fondo.position.x <= -fondo.size.width {
                    
                    fondo.position = CGPointMake(
                        fondo.position.x + fondo.size.width * 2,
                        fondo.position.y)
                }
            }
        })
    }
    
    func enemy() {
        
        var randomNumber = UInt(arc4random_uniform(UInt32(size.height)))
        
        enemigo = SKSpriteNode(imageNamed: "enemigo")
        enemigo.setScale(0.3)
        enemigo.zPosition = 1
        enemigo.name = "enemigo"
        
        enemigo.position = CGPoint(
            x: size.width + enemigo.size.width/2,
            y: CGFloat(randomNumber))
        
        addChild(enemigo)
        
        moverEnemigo = SKAction.moveToX(size.width - enemigo.size.width * 3, duration: 2.0)
        
        //let mover = SKAction.moveToX(  -enemigo.size.width/2, duration: 2.0)
        
        //let eliminar = SKAction.removeFromParent()
        
        //enemigo.runAction(SKAction.sequence [ mover, eliminar ])
    }
    
    func sacarEnemigo() {
        /*
        for var i = 0; i < 5; ++i {
            enemy()
            enemigo.runAction(moverEnemigo)
        }
        */
        
        enemigo.runAction(moverEnemigo)
        /*
        if enemigo.position.x <= size.width - enemigo.size.width * 2 {
            enemigo.removeFromParent()
        }
        */
    }
    
    override func update(currentTime: NSTimeInterval) {
        scrollHorizontal()
        sacarEnemigo()
        //enemigo.runAction(moverEnemigo)
    }
}