//
//  Day8.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 8/12/24.
//

struct Day8: DailySolvable {

    static let day = 8

    let map: [[String]]

    init(input: String) {
        map = input
            .split(separator: "\n")
            .map { $0.map(String.init) }
    }

    func answerPart1() -> Int {
        var antennas = [String: [Point]]()

        for i in (0 ..< map.count) {
            for j in (0 ..< map[i].count) {
                if map[i][j] != "." {
                    antennas[map[i][j], default: []].append(Point(x: j, y: i))
                }
            }
        }

        var antinodes = Set<Point>()
        for nodes in antennas.values where nodes.count >= 2 {
            for i in (0 ..< nodes.count - 1) {
                for j in (i + 1 ..< nodes.count) {
                    let pointI = nodes[i]
                    let pointJ = nodes[j]
                    let deltaX = pointJ.x - pointI.x
                    let deltaY = pointJ.y - pointI.y

                    var point = pointI.offset(dx: -deltaX, dy: -deltaY)
                    if point.inBounds(width: map.count, height: map[0].count) {
                        antinodes.insert(point)
                    }
                    point = pointJ.offset(dx: deltaX, dy: deltaY)
                    if point.inBounds(width: map.count, height: map[0].count) {
                        antinodes.insert(point)
                    }
                }
            }
        }

        return antinodes.count
    }

    func answerPart2() -> Int {
        var antennas = [String: [Point]]()

        for i in (0 ..< map.count) {
            for j in (0 ..< map[i].count) {
                if map[i][j] != "." {
                    antennas[map[i][j], default: []].append(Point(x: j, y: i))
                }
            }
        }

        var antinodes = Set<Point>()
        for nodes in antennas.values where nodes.count >= 2 {
            for i in (0 ..< nodes.count - 1) {
                for j in (i + 1 ..< nodes.count) {
                    let pointI = nodes[i]
                    let pointJ = nodes[j]
                    let deltaX = pointJ.x - pointI.x
                    let deltaY = pointJ.y - pointI.y

                    var point = pointI
                    while point.inBounds(width: map.count, height: map[0].count) {
                        antinodes.insert(point)
                        point = point.offset(dx: -deltaX, dy: -deltaY)
                    }
                    point = pointJ
                    while point.inBounds(width: map.count, height: map[0].count) {
                        antinodes.insert(point)
                        point = point.offset(dx: deltaX, dy: deltaY)
                    }
                }
            }
        }

        return antinodes.count
    }
}
