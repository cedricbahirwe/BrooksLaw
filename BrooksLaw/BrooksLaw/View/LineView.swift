//
//  LineView.swift
//  BrooksLaw
//
//  Created by Cédric Bahirwe on 09/12/2022.
//

import SwiftUI

struct LineView: View {
    let line: Line
    var body: some View {
        Path { path in
            path.move(to: line.origin)
            path.addLine(to: line.destination)
        }
//        .stroke(Color("strokeColor"), lineWidth: line.width)
        .stroke(line.color, lineWidth: 2) // Uncomment this line for dynamic coloring
    }
}
