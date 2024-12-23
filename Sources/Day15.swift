//
//  Day15.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 20/12/24.
//

struct Day15: DailySolvable {

    static let day = 15
    let map: [[String]]
    let moves: [Direction]

    init(input: String) {
        (map, moves) = Self.parseInput(input)
    }

    func answerPart1() -> Int {
        var map = map
        var robot: (Int, Int)?

        for i in (0 ..< map.count) {
            for j in (0 ..< map[i].count) {
                if map[i][j] == "@" {
                    robot = (i, j)
                    break
                }
            }
        }

        guard var robot else { return 0 }
        for move in moves {
            robotMoves(&robot, direction: move, map: &map)
        }

        var coordinatesSum = 0
        for i in (0 ..< map.count) {
            for j in (0 ..< map[i].count) {
                let tile = map[i][j]
                guard tile == "O" else { continue }
                coordinatesSum += 100 * i + j
            }
        }

        return coordinatesSum
    }

    func answerPart2() -> Int {
        return -1
    }
}

extension Day15 {

    static func parseInput(_ input: String) -> ([[String]], [Direction]) {
        let input = input.split(separator: "\n\n")
        guard input.count == 2 else {
            return ([], [])
        }

        let map = input[0].split(separator: "\n")
            .map { $0.map(String.init) }
        let moves = input[1]
            .split(separator: "\n")
            .joined()
            .compactMap { Direction(rawValue: String($0)) }

        return (map, moves)
    }

    private func robotMoves(
        _ robot: inout (Int, Int),
        direction: Direction,
        map: inout [[String]]
    ) {
        var next = direction.next(from: robot)
        loop: while true {
            switch map[next.0][next.1] {
            case "#":
                return
            case ".":
                break loop
            default:
                next = direction.next(from: next)
            }
        }

        guard robot.0 != next.0 || robot.1 != next.1 else {
            return
        }

        map[robot.0][robot.1] = "."
        robot = direction.next(from: robot)
        map[robot.0][robot.1] = "@"
        if robot.0 != next.0 || robot.1 != next.1 {
            map[next.0][next.1] = "O"
        }
    }
}

extension Direction {

    fileprivate func next(from: (Int, Int)) -> (Int, Int) {
        switch self {
        case .north: (from.0 - 1, from.1)
        case .east: (from.0, from.1 + 1)
        case .south: (from.0 + 1, from.1)
        case .west: (from.0, from.1 - 1)
        }
    }
}
