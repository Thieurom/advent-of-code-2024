//
//  Day10.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 12/12/24.
//

struct Day10: DailySolvable {

    static let day = 10
    let map: [[Int]]

    init(input: String) {
        map = input
            .split(separator: "\n")
            .map {
                $0.compactMap { Int(String($0)) }
            }
    }

    func answerPart1() -> Int {
        calculateTrailheadScores(map: map)
    }

    func answerPart2() -> Int {
        calculateTrailheadScores(map: map, isDistinctTrail: true)
    }

    private func calculateTrailheadScores(map: [[Int]], isDistinctTrail: Bool = false) -> Int {
        var totalScores = 0

        for i in (0 ..< map.count) {
            for j in (0 ..< map[i].count) {
                guard map[i][j] == 0 else { continue }
                var nineHeights: Set<Point>? = isDistinctTrail ? nil : .init()
                var scores = 0
                if findTrailhead(
                    map: map,
                    current: (i, j),
                    nineHeights: &nineHeights,
                    scores: &scores
                ) {
                    totalScores += scores
                }
            }
        }

        return totalScores
    }

    private func findTrailhead(
        map: [[Int]],
        current: (Int, Int),
        nineHeights: inout Set<Point>?,
        scores: inout Int
    ) -> Bool {
        let currentX = current.0
        let currentY = current.1
        let point = Point(x: currentX, y: currentY)

        if map[currentX][currentY] == 9 {
            if nineHeights != nil, nineHeights!.contains(point) {
                return false
            }
            nineHeights?.insert(point)
            scores += 1
            return true
        }

        let next = [
            (currentX + 1, currentY),
            (currentX - 1, currentY),
            (currentX, currentY + 1),
            (currentX, currentY - 1)
        ]

        var found = false
        for (x, y) in next {
            guard x >= 0, x < map.count,
                  y >= 0, y < map[0].count,
                  map[x][y] == map[currentX][currentY] + 1 else { continue }
            if findTrailhead(
                map: map,
                current: (x, y),
                nineHeights: &nineHeights,
                scores: &scores
            ), !found {
                found = true
            }
        }

        return found
    }
}
