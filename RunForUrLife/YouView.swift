//
//  YouView.swift
//  RunForUrLife
//
//  Created by Hai on 10/2/16.
//  Copyright © 2016 HaiTrung. All rights reserved.
//

import SpriteKit
typealias GetHitType = ((_ dammage: Int)->Void)
typealias GetType = ((_ type: Int)->Void)


class youView: View {
    var getHit : GetHitType?
    var get : GetType?
}
