//
//  CGPointUtil.swift
//  FGame
//
//  Created by Admin on 9/4/16.
//  Copyright © 2016 Techkids. All rights reserved.
//



import SpriteKit

import Foundation

extension CGPoint {
    func add(_ other : CGPoint) -> CGPoint {
        let retX = self.x + other.x
        let retY = self.y + other.y
        return CGPoint(x: retX, y: retY)
    }
    func subtract(_ other : CGPoint) -> CGPoint {
        let retX = self.x - other.x
        let retY = self.y - other.y
        return CGPoint(x: retX, y: retY)
    }
    func multiply(_ hs : CGFloat) -> CGPoint {
        let retX = self.x * hs
        let retY = self.y * hs
        return CGPoint(x: retX, y: retY)
    }
    func distance(_ other : CGPoint) -> CGFloat {
        return sqrt((self.x - other.x)*(self.x - other.x) + (self.y - other.y) * (self.y - other.y))
        
    }
    func normalize() -> CGPoint {
        let kc = distance(CGPoint.zero)
        let Result = CGPoint(x: self.x / kc, y: self.y / kc)
        return Result
    }
    
}
extension CGRect {
    func mutiply(_ k : CGFloat) -> CGRect {
        let h = self.size.height*2
        let w = self.size.width*2
        return CGRect(x: self.origin.x, y: self.origin.y, width: w, height: h)
    }
}
