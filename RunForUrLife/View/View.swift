//
//  View.swift
//  RunForUrLife
//
//  Created by Hai on 10/1/16.
//  Copyright © 2016 HaiTrung. All rights reserved.
//

import SpriteKit

typealias HandleContactType = ((_ otherContact : View) -> Void)

class View: SKSpriteNode {
    var handleContact : HandleContactType?
    
}
