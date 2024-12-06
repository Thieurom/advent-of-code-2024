//
//  Day4.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 5/12/24.
//

struct Day4: DailySolvable {

    static let day = 4

    let xmas = "XMAS"
    let xDashMas = ["MAS", "SAM"]
    let matrix: [[String]]

    var jump: Int { xmas.count - 1}

    init(input: String) {
        matrix = input
            .split(separator: "\n")
            .map { $0.map(String.init) }
    }

    func answerPart1() -> Int {
        var count = 0

        for i in (0 ..< matrix.count) {
            for j in (0 ..< matrix[i].count) {
                // East
                if j + jump < matrix[i].count, matrix[i][j ... j + jump].joined() == xmas {
                    count += 1
                }
                // West
                if j - jump >= 0, matrix[i][j - jump ... j].reversed().joined() == xmas {
                    count += 1
                }
                // North
                if i - jump >= 0, (i - jump ... i).map({ matrix[$0][j] }).reversed().joined() == xmas {
                    count += 1
                }
                // South
                if i + jump < matrix.count, (i ... i + jump).map({ matrix[$0][j] }).joined() == xmas {
                    count += 1
                }
                // North-East
                if i - jump >= 0, j + jump < matrix[i].count,
                   (0 ... jump).map({ (i - $0, j + $0) }).map({ matrix[$0.0][$0.1] }).joined() == xmas {
                    count += 1
                }
                // North-West
                if i - jump >= 0, j - jump >= 0,
                   (0 ... jump).map({ (i - $0, j - $0) }).map({ matrix[$0.0][$0.1] }).joined() == xmas {
                    count += 1
                }
                // South-East
                if i + jump < matrix.count, j + jump < matrix[i].count,
                   (0 ... jump).map({ (i + $0, j + $0) }).map({ matrix[$0.0][$0.1] }).joined() == xmas {
                    count += 1
                }
                // South-West
                if i + jump < matrix.count, j - jump >= 0,
                   (0 ... jump).map({ (i + $0, j - $0) }).map({ matrix[$0.0][$0.1] }).joined() == xmas {
                    count += 1
                }
            }
        }

        return count
    }

    func answerPart2() -> Int {
        guard matrix.count >= 3, matrix[0].count >= 3 else { return 0 }

        var count = 0

        for i in (1 ..< matrix.count - 1) {
            for j in (1 ..< matrix[i].count - 1) {
                let diag1 = [(i - 1, j - 1), (i, j), (i + 1, j + 1)]
                    .map { matrix[$0.0][$0.1] }
                    .joined()
                let diag2 = [(i - 1, j + 1), (i, j), (i + 1, j - 1)]
                    .map { matrix[$0.0][$0.1] }
                    .joined()
                if xDashMas.contains(diag1) && xDashMas.contains(diag2) {
                    count += 1
                }
            }
        }

        return count
    }
}
