//
//  ContentView.swift
//  BrooksLaw
//
//  Created by Cédric Bahirwe on 09/12/2022.
//

import SwiftUI

struct ContentView: View {
    private let item: CGFloat = 10
    @State private var engine = Engine(people: 3, plan: 300)

    var body: some View {
        ZStack {
            Color("backgroundColor").ignoresSafeArea()

            VStack {
                Text("\(engine.people) People = \(engine.lines.count) Line\(engine.lines.count <= 1 ? "" : "s")")
                    .font(.system(.title, design: .rounded, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top)

                ZStack {
                    ForEach(engine.lines, id:\.self) {
                        LineView(line: $0)
                    }

                    ForEach(0..<engine.points.count, id: \.self) { i in
                        let point = engine.points[i]
                        Circle()
                            .stroke(point.color, lineWidth: 2) // Uncomment this line for dynamic coloring
//                            .stroke(Color("strokeColor"), lineWidth: 2)
                            .background(Color("backgroundColor"))
                            .frame(width: item, height: item)
                            .position(x: point.x, y: point.y)
                    }
                }
                .frame(width: engine.width, height: engine.height)
                .animation(.interpolatingSpring(stiffness: 50, damping: 2), value: engine.people)
//                .animation(.interpolatingSpring(stiffness: <#T##Double#>, damping: <#T##Double#>), value: engine.people)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                VStack {
                    HStack {
                        Button("Decrease") {
                            engine.decreasePeople()
                        }

                        Stepper {

                        } onIncrement: {
                            engine.increasePeople()
                        } onDecrement: {
                            engine.decreasePeople()
                        }
                        .labelsHidden()

                        Button("Increase") {
                            engine.increasePeople()
                        }

                    }
                    ScrollView {
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(engine.debugs) {
                                Text("Point \($0.id) - X: \($0.x, specifier: "%0.2f") and Y: \($0.y, specifier: "%0.2f")")
                                Divider()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(1)
                            .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
                .frame(height: 280)
                .background(.thinMaterial)
                .cornerRadius(10)
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
