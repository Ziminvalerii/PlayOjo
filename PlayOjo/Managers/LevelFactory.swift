//
//  LevelFactory.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 29.09.2022.
//

import SpriteKit

class LevelFactory {
    var sceneSize: CGSize
    var currentLevel = Levels.first
    var levels: Levels.AllCases = Levels.allCases
    var flacons = [BottleNode]()
    var prevous = [BubleNode]() {
        didSet {
          //  if prevous.count > 5 {
           //     prevous.removeFirst()
            //}
        }
    }
    init(sceneSize: CGSize) {
        self.sceneSize = sceneSize
        self.flacons = createFlacons()
        UserDefaultsValues.levelIndex = 10
        currentLevel = levels[UserDefaultsValues.levelIndex]
    }
    
    func setCurrentLevel() {
        currentLevel = levels[UserDefaultsValues.levelIndex]
    }
    
    func createFlacons() -> [BottleNode] {
       var bottles = [BottleNode]()
        
        let rowCount = currentLevel.flaskCount > 5 ? 2 : 1
        let spaceBetweenY = (sceneSize.height - (200 * CGFloat(rowCount)))/(CGFloat(rowCount) + 1)
        var yPos :CGFloat = -225
        var step = 0
        for j in 0 ..< rowCount {
            var flacksCount = currentLevel.flaskCount
            if rowCount == 2 {
             flacksCount = j >= 1 ? currentLevel.flaskCount : 5
            }
            let div = (flacksCount - step)%2==0 ? 1 : 1.5
            let spacebetween: CGFloat = (sceneSize.width - (50 * CGFloat(flacksCount - step)))/(CGFloat(flacksCount - step)+div)
            var xPos:CGFloat = -sceneSize.width/2 + 50/2 + spacebetween
           
            for i in step ..< flacksCount {
                let bottle = BottleNode(levelFactory: self)
                bottle.position =  CGPoint(x: xPos, y: yPos)
                xPos += bottle.size.width + spacebetween
                bottle.bubbles = createBubles(currentIndex: i, pos: CGPoint(x: bottle.position.x, y: bottle.frame.maxY + 10))
                bottle.bubbles.map {$0.currentBottle = bottle}
                bottles.append(bottle)
            }
            step += 5
            yPos = 25
           
        }
        return bottles
        
    }
    
 //   private func spawnBottles
    
    func createBubles(currentIndex: Int, pos: CGPoint) -> [BubleNode] {
        var bubles = [BubleNode]()
        var timeInterval = Date().timeIntervalSince1970
        for buble in currentLevel.bublesInFlaks {
            if buble.0 == currentIndex {
                let buble = buble.1.map {
                    return  BubleNode(type: $0)
                }
                buble.map({
                    $0.position = CGPoint(x: pos.x, y: pos.y)
                })
                bubles.append(contentsOf: buble)
                return bubles
            }
        }
        return [BubleNode]()
    }
}
