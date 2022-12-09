//
//  Line.swift
//  BrooksLaw
//
//  Created by Cédric Bahirwe on 09/12/2022.
//

import SwiftUI

struct Line: Equatable, Hashable {
    let origin: CGPoint
    let destination: CGPoint
    let color: Color
    let width: CGFloat

    func hash(into hasher: inout Hasher) {
        hasher.combine(origin.x)
        hasher.combine(origin.y)
        hasher.combine(destination.x)
        hasher.combine(destination.y)
        hasher.combine(color)
    }
}

extension Set where Element == Line {
    func hasLine(_ line: Element) -> Bool {
        contains {
            // Check whether two lines are limilar
            $0.origin == line.destination &&
            $0.destination == line.origin
        }
    }
}
