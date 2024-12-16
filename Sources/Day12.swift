//
//  Day12.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 16/12/24.
//

struct Day12: DailySolvable {

    static let day = 12
    let gardenMap: [[String]]

    init(input: String) {
        gardenMap = input.split(separator: "\n")
            .map { $0.map(String.init) }
    }

    func answerPart1() -> Int {
        var visited = Set<Point>()
        var totalPrice = 0

        for i in (0 ..< gardenMap.count){
            for j in (0 ..< gardenMap[i].count){
                var perimeter = 0
                var area = 0
                fencePrice(
                    x: i,
                    y: j,
                    map: gardenMap,
                    visited: &visited,
                    area: &area,
                    perimeterOrSides: &perimeter,
                    perimeterOrSidesIncrement: fencePerimeter
                )
                totalPrice += area * perimeter
            }
        }

        return totalPrice
    }

    func answerPart2() -> Int {
        var visited = Set<Point>()
        var totalPrice = 0

        for i in (0 ..< gardenMap.count){
            for j in (0 ..< gardenMap[i].count){
                var sides = 0
                var area = 0
                fencePrice(
                    x: i,
                    y: j,
                    map: gardenMap,
                    visited: &visited,
                    area: &area,
                    perimeterOrSides: &sides,
                    perimeterOrSidesIncrement: plantCorners
                )
                totalPrice += area * sides
            }
        }

        return totalPrice
    }
}

extension Day12 {

    private func fencePrice(
        x: Int,
        y: Int,
        map: [[String]],
        visited: inout Set<Point>,
        area: inout Int,
        perimeterOrSides: inout Int,
        perimeterOrSidesIncrement: (Int, Int, [[String]]) -> Int
    ) {
        guard !map.isEmpty else { return }

        let point = Point(x: x, y: y)
        guard !visited.contains(point) else { return }

        visited.insert(point)
        area += 1
        perimeterOrSides += perimeterOrSidesIncrement(x, y, map)

        let neighbors: [(Int, Int)] = [
            (x, y + 1),
            (x, y - 1),
            (x + 1, y),
            (x - 1, y)
        ]

        for neighbor in neighbors {
            let neighborX = neighbor.0
            let neighborY = neighbor.1
            guard checkBounds(x: neighborX, y: neighborY, map: map),
                  map[neighborX][neighborY] == map[x][y] else {
                continue
            }
            fencePrice(
                x: neighbor.0,
                y: neighbor.1,
                map: map,
                visited: &visited,
                area: &area,
                perimeterOrSides: &perimeterOrSides,
                perimeterOrSidesIncrement: perimeterOrSidesIncrement
            )
        }
    }

    private func fencePerimeter(x: Int, y: Int, map: [[String]]) -> Int {
        var perimeter = 0
        let neighbors: [(Int, Int)] = [
            (x, y + 1),
            (x, y - 1),
            (x + 1, y),
            (x - 1, y)
        ]

        for neighbor in neighbors {
            if !checkBounds(x: neighbor.0, y: neighbor.1, map: map) ||
                map[neighbor.0][neighbor.1] != map[x][y] {
                perimeter += 1
            }
        }
        return perimeter
    }

    private func plantCorners(x: Int, y: Int, map: [[String]]) -> Int {
        var corners = 0
        let neighbors: [(Int, Int)] = [
            (x - 1, y), // North
            (x, y + 1), // East
            (x + 1, y), // South
            (x, y - 1)  // West
        ]

        let diagonals: [(Int, Int)] = [
            (x - 1, y + 1), // North-East
            (x + 1, y + 1), // South-East
            (x + 1, y - 1), // South-West
            (x - 1, y - 1)  // North-West
        ]

        for i in (0 ..< neighbors.count) {
            let neighbor = neighbors[i]
            let adjacent = neighbors[(i + 1) % neighbors.count]
            let diagonal = diagonals[i]

            // Outer corner
            if (!checkBounds(x: neighbor.0, y: neighbor.1, map: map) || map[neighbor.0][neighbor.1] != map[x][y]) &&
                (!checkBounds(x: adjacent.0, y: adjacent.1, map: map) || map[adjacent.0][adjacent.1] != map[x][y]) {
                corners += 1
            }

            // Inner corner
            if (checkBounds(x: neighbor.0, y: neighbor.1, map: map) && map[neighbor.0][neighbor.1] == map[x][y]) &&
                (checkBounds(x: adjacent.0, y: adjacent.1, map: map) && map[adjacent.0][adjacent.1] == map[x][y]) &&
                (checkBounds(x: diagonal.0, y: diagonal.1, map: map) && map[diagonal.0][diagonal.1] != map[x][y]) {
                corners += 1
            }
        }

        return corners
    }

    private func checkBounds(x: Int, y: Int, map: [[String]]) -> Bool {
        guard !map.isEmpty else { return false }
        return x >= 0 && x < map.count && y >= 0 && y < map[x].count
    }
}
