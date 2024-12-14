//
//  Day11.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 14/12/24.
//

struct Day11: DailySolvable {

    static let day = 11

    let input: [Int]

    init(input: String) {
        self.input = input
            .trimmingCharacters(in: .newlines)
            .split(separator: " ")
            .compactMap { Int($0) }
    }

    func answerPart1() -> Int {
        blink(25)
    }

    func answerPart2() -> Int {
        blink(75)
    }

    private func blink(_ count: Int) -> Int {
        var stones = input.reduce(into: [Int: Int]()) {
            $0[$1, default: 0] += 1
        }

        for _ in 0 ..< count {
            var transformed = [Int: Int]()
            for (stone, _) in stones {
                for value in transform(stone) {
                    transformed[value, default: 0] += stones[stone] ?? 0
                }
            }

            stones = transformed
        }

        return stones.values.reduce(0, +)
    }

    private func transform(_ stone: Int) -> [Int] {
        if stone == 0 {
            return [1]
        } else if "\(stone)".count % 2 == 0 {
            let digits = "\(stone)".map(String.init)
            return [
                Int(digits[0 ..< digits.count / 2].joined()),
                Int(digits[digits.count / 2 ..< digits.count].joined())
            ].compactMap { $0 }
        } else {
            return [stone * 2024]
        }
    }
}
