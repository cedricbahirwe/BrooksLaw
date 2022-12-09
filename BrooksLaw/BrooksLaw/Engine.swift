//
//  Engine.swift
//  BrooksLaw
//
//  Created by Cédric Bahirwe on 09/12/2022.
//

import SwiftUI

struct Engine {
    private let radius: CGFloat
    private let plan: CGFloat

    private(set) var debugs: [Debug] = []
    private(set) var people: Int

    var width: CGFloat { plan }

    var height: CGFloat { plan }

    var points: [Point] = []
    var lines: [Line] = []

    init(people: Int, plan: CGFloat) {
        self.people = people
        self.radius = plan / 2
        self.plan = plan

        getPositions()
    }

    /// Determine the number of `points` based on available people
    mutating func getPositions() {
        var points: [Point] = []
        debugs = []
        var currentDegree: CGFloat = 0.0
        let degreePerPerson = 360.0 / CGFloat(people)
        while currentDegree < 360 {
            currentDegree = currentDegree + degreePerPerson
            let nextPoint = getNextPoint(angle: currentDegree)
            points.append(nextPoint)
            debugs.append(.init(debugs.count+1, nextPoint))
        }

        self.points = points
        let channels = getChannels(self.points)
        self.lines = channels
    }

    mutating func increasePeople() {
        guard people != 360 else { return }
        people += 1
        withAnimation(.spring()) {
            getPositions()
        }
    }

    mutating func decreasePeople() {
        guard people != 1 else { return }
        people -= 1
        getPositions()
    }

    /// Calculate the number of `lines` (channels) to be used based on availables `points`(people)
    func getChannels(_ points: [Point]) -> [Line] {
        var lines: Set<Line> = []
        points.forEach { origin in
            points.forEach { destination in
                // Make sure the two points are not the same
                guard origin.position != destination.position else { return }

                let mixColor = Color(
                    UIColor.blend(
                        color1: UIColor(origin.color),
                        color2: UIColor(destination.color)
                    )
                )
                let line = Line(origin: origin.position,
                                destination: destination.position,
                                color: mixColor,
                                width: 1)
                guard !lines.hasLine(line)
                else { return }

                lines.insert(line)
            }
        }

        return Array(lines)
    }

    /// Get the next `point` in the drawing process
    /// - Parameters:
    ///   - angle: the next angle`
    /// - Returns: return the next point to draw
    func getNextPoint(angle: CGFloat) -> Point {

        let x: CGFloat = radius * cosdeg(degrees: angle)

        let y: CGFloat = radius * sindeg(degrees: angle)

        let remainder = CGFloat(angle - radius).truncatingRemainder(dividingBy: 256) / 255

        let point = CGPoint(x: x + width / 2, y: y + height / 2)
        let color = Color(hue: Double(remainder),
                          saturation: 1,
                          brightness: 1)

        return Point(point, color)
    }

    // MARK: - Trigonometrical Helper functions
    private func sindeg(degrees: Double) -> Double {
        return sin(degrees * .pi / 180.0)
    }

    private func cosdeg(degrees: Double) -> Double {
        return cos(degrees * .pi / 180.0)
    }
}

// MARK: - Object for Debug purpose
extension Engine {
    struct Debug: Identifiable {
        private static var counter = 0
        let id: Int
        let point: CGPoint

        var x: CGFloat { point.x }
        var y: CGFloat { point.y }

        init(_ index: Int, _ point: Point) {
//            Engine.Debug.counter += 1
            self.id = index//Engine.Debug.counter
            self.point = point.position
        }
    }
}
