//
//  Day6.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 6/12/24.
//

enum Direction: String {

    case north = "^"
    case south = ">"
    case east = "v"
    case west = "<"

    func turn() -> Direction {
        switch self {
        case .north: return .east
        case .east: return .south
        case .south: return .west
        case .west: return .north
        }
    }
}

struct Point: Hashable {

    var x: Int
    var y: Int
}

struct Position: Hashable {

    var point: Point
    var heading: Direction

    mutating func turn() {
        heading = heading.turn()
    }

    mutating func move() {
        point = nextPoint()
    }

    func nextPoint() -> Point {
        var point = point

        switch heading {
        case .north: point.y -= 1
        case .east: point.x += 1
        case .south: point.y += 1
        case .west: point.x -= 1
        }

        return point
    }
}

struct Day6: DailySolvable {

    static let day = 6

    let map: [[String]]
    private let obstacle = "#"

    init(input: String) {
        map = input
            .split(separator: "\n")
            .map { $0.map(String.init) }
    }

    func answerPart1() -> Int {
        var guardPosition: Position?

        for i in (0 ..< map.count) {
            for j in (0 ..< map[i].count) {
                if let direction = Direction(rawValue: map[i][j]) {
                    guardPosition = .init(point: .init(x: j, y: i), heading: direction)
                    break
                }
            }
        }

        guard var guardPosition,
              guardPosition.heading.rawValue != obstacle,
              map.isValidPoint(guardPosition.point) else { return 0 }
        var points: Set<Point> = [guardPosition.point]

        while map.isValidPoint(guardPosition.nextPoint()) {
            let nextPoint = guardPosition.nextPoint()
            if map[nextPoint.y][nextPoint.x] == obstacle {
                guardPosition.turn()
            } else {
                points.insert(nextPoint)
                guardPosition.move()
            }
        }

        return points.count
    }

    func answerPart2() -> Int {
        var initialGuardPosition: Position?

        for i in (0 ..< map.count) {
            for j in (0 ..< map[i].count) {
                if let direction = Direction(rawValue: map[i][j]) {
                    initialGuardPosition = .init(point: .init(x: j, y: i), heading: direction)
                    break
                }
            }
        }

        guard var guardPosition = initialGuardPosition,
              guardPosition.heading.rawValue != obstacle,
              map.isValidPoint(guardPosition.point) else { return 0 }
        var points: Set<Point> = [guardPosition.point]

        while map.isValidPoint(guardPosition.nextPoint()) {
            let nextPoint = guardPosition.nextPoint()
            if map[nextPoint.y][nextPoint.x] == obstacle {
                guardPosition.turn()
            } else {
                points.insert(nextPoint)
                guardPosition.move()
            }
        }

        var path = Array(points)
        path.removeAll(where: { $0 == initialGuardPosition?.point })
        guard !path.isEmpty else { return 0 }

        var obstacles = 0
        for i in (0 ..< path.count) {
            var newMap = map
            let point = path[i]
            newMap[point.y][point.x] = obstacle
            guard var position = initialGuardPosition else {
                break
            }
            var positions: Set<Position> = [position]

            while newMap.isValidPoint(position.nextPoint()) {
                let nextPoint = position.nextPoint()
                if newMap[nextPoint.y][nextPoint.x] == obstacle {
                    position.turn()
                } else {
                    let nextPosition = Position(point: nextPoint, heading: position.heading)
                    if positions.contains(nextPosition) {
                        obstacles += 1
                        break
                    } else {
                        positions.insert(nextPosition)
                    }
                    position.move()
                }
            }
        }

        return obstacles
    }
}

extension Array where Element == Array<String> {

    fileprivate func isValidPoint(_ point: Point) -> Bool {
        guard !isEmpty else { return false }
        return point.x >= 0 && point.y >= 0 && point.x < count && point.y < self[0].count
    }
}
