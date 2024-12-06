//
//  Day5.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 5/12/24.
//

struct Day5: DailySolvable {

    static let day = 5

    let orderingRules: Set<[Int]>
    let updates: [[Int]]

    init(input: String) {
        let sections = input
            .split(separator: "\n\n")

        guard sections.count == 2 else {
            fatalError("Invalid input")
        }

        let rules = sections[0]
            .split(separator: "\n")
            .map {
                $0.split(separator: "|").compactMap { Int($0) }
            }
        orderingRules = Set(rules)

        updates = sections[1]
            .split(separator: "\n")
            .map {
                $0.split(separator: ",").compactMap { Int($0) }
            }
    }

    func answerPart1() -> Int {
        var total = 0

        for update in updates where update.count % 2 == 1 {
            if validateUpdate(update) {
                total += update[update.count / 2]
            }
        }

        return total
    }

    func answerPart2() -> Int {
        var total = 0
        var reorders = [[Int]]()

        for update in updates where update.count % 2 == 1 {
            if !validateUpdate(update) {
                reorders.append(update)
            }
        }

        for i in (0 ..< reorders.count) {
            sortByRules(update: &reorders[i])
        }

        for update in reorders {
            if validateUpdate(update) {
                total += update[update.count / 2]
            }
        }

        return total
    }

    private func validateUpdate(_ update: [Int]) -> Bool {
        guard update.count >= 2 else { return true }

        for i in (0 ..< update.count - 1) {
            for j in (i + 1 ..< update.count) {
                if !orderingRules.contains([update[i], update[j]]) {
                    return false
                }
            }
        }

        return true
    }

    private func sortByRules(update: inout [Int]) {
        update.sort { lhs, rhs in
            if orderingRules.first(where: { $0[0] == lhs && $0[1] == rhs }) != nil {
                return true
            }
            return false
        }
    }
}
