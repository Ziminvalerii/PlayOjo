//
//  GameSceneManager.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 28.09.2022.
//

import SpriteKit

class GameSceneManager: NSObject, GameSceneManagerProtocol {
    weak var scene: SKScene?
    weak var contactManager: ContactManager?
    var parentViewController: GameViewController!
    var toucheble: [Touchable] = [Touchable]()
    var updatable: [Updatable] = [Updatable]()
    var endless: [Endless] = [Endless]()
    var levelFactory: LevelFactory
    
    required init?(scene : SKScene) {
        self.scene = scene
        self.scene?.backgroundColor = .white
        self.levelFactory = LevelFactory(sceneSize: scene.size)
        super.init()
        preparePhysicsForWold(for: scene)
    }
    
    func preparePhysicsForWold(for scene: SKScene) {
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        scene.physicsWorld.contactDelegate = self
    }
}

extension GameSceneManager: Dependable {
    func receiveMessage<T>(with arguments: T) {
    }
}

extension GameSceneManager : SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let collision:UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
    }
}


