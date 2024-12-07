//
//  Day7.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 7/12/24.
//

struct Day7: DailySolvable {

    static let day = 7

    let equations: [(operands: [Int], result: Int)]

    init(input: String) {
        equations = input
            .split(separator: "\n")
            .compactMap {
                let line = $0.split(separator: ":")
                guard line.count == 2, let first = Int(line[0]) else { return nil }
                return (
                    line[1]
                        .trimmingCharacters(in: .whitespaces)
                        .split(separator: " ")
                        .compactMap { Int($0) },
                    first
                )
            }
    }

    func answerPart1() -> Int {
        equations.reduce(into: 0, { partialResult, equation in
            if evaluate(
                equation: equation.operands,
                index: 0,
                target: equation.result,
                current: 0
            ) {
                partialResult += equation.1
            }
        })
    }

    func answerPart2() -> Int {
        equations.reduce(into: 0, { partialResult, equation in
            if evaluate(
                equation: equation.operands,
                index: 0,
                target: equation.result,
                current: 0,
                includeConcat: true
            ) {
                partialResult += equation.1
            }
        })
    }

    private func evaluate(
        equation: [Int],
        index: Int,
        target: Int,
        current: Int,
        includeConcat: Bool = false
    ) -> Bool {
        if index == equation.count {
            return current == target
        }

        var operators: [(Int, Int) -> Int] = [
            { $0 + $1 },
            { index == 0 ? $1 : $0 * $1 }
        ]

        if includeConcat {
            operators.append { Int("\($0)\($1)")! }
        }

        for op in operators {
            if evaluate(
                equation: equation,
                index: index + 1,
                target: target,
                current: op(current, equation[index]),
                includeConcat: includeConcat
            ) {
                return true
            }
        }

        return false
    }
}
