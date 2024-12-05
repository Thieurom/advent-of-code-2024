//
//  Day1.swift
//  advent-of-code-2024
//
//  Created by Doan Thieu on 5/12/24.
//

struct Day1: DailySolvable {

    static let day = 1

    let input: [[Int]]

    init(input: String) {
        self.input = input
            .split(separator: "\n")
            .map {
                $0.split(separator: " ").compactMap { Int($0) }
            }
    }

    func answerPart1() -> Int {
        let left = column(0).sorted()
        let right = column(1).sorted()
        return left
            .enumerated()
            .reduce(0) {
                $0 + abs($1.element - right[$1.offset])
            }
    }

    func answerPart2() -> Int {
        var score = 0
        let freq = column(1).reduce(into: [Int: Int]()) {
            $0[$1, default: 0] += 1
        }
        for num in column(0) {
            if let count = freq[num] {
                score += num * count
            }
        }
        return score
    }

    private func column(_ n: Int) -> [Int] {
        input
            .compactMap { $0.indices ~= n ? $0[n] : nil }
    }
}
