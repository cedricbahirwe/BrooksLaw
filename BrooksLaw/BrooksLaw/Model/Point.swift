//
//  Point.swift
//  BrooksLaw
//
//  Created by Cédric Bahirwe on 09/12/2022.
//

import SwiftUI

struct Point: Hashable {
    var id: String { position.debugDescription }

    var position: CGPoint {
        CGPoint(x: x, y: y)
    }

    let x: CGFloat
    let y: CGFloat

    let color: Color

    init(_ position: CGPoint, _ color: Color) {
        self.x = position.x
        self.y = position.y
        self.color = color
    }
}
