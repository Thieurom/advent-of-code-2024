//
//  Day2.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 5/12/24.
//

struct Day2: DailySolvable {

    static let day = 2

    let reports: [[Int]]

    init(input: String) {
        reports = input
            .split(separator: "\n")
            .map {
                $0.split(separator: " ").compactMap { Int($0) }
            }
    }

    func answerPart1() -> Int {
        var safeCount = 0

        for report in reports {
            if checkPart1(report: report) {
                safeCount += 1
            }
        }

        return safeCount
    }

    func answerPart2() -> Int {
        var safeCount = 0

        for report in reports {
            if checkPart2(report: report) {
                safeCount += 1
            }
        }

        return safeCount
    }

    private func checkPart1(report: [Int]) -> Bool {
        guard report.count >= 2 else { return true }

        let diff = report[0] - report[report.count - 1]
        guard diff != 0 else { return false }
        let sign = diff < 0 ? -1 : 1

        for i in (0 ..< report.count - 1) {
            let diff = (report[i] - report[i + 1]) * sign
            guard diff >= 1 && diff <= 3 else { return false }
        }

        return true
    }

    private func checkPart2(report: [Int]) -> Bool {
        guard report.count >= 2 else { return true }

        var index = 0
        for i in (0 ..< report.count - 1) {
            let diff = report[i] - report[i + 1]
            if diff < 1 || diff > 3 {
                index = i
                break
            }
        }

        var decreasingSafe = checkPart1(report: Array(report[0 ..< index] + report[index + 1 ..< report.count]))
        if !decreasingSafe {
            decreasingSafe = checkPart1(
                report: Array(
                    report[0 ..< index + 1] + (index < report.count - 2 ? report[index + 2 ..< report.count] : [])
                )
            )
        }

        index = 0
        for i in (0 ..< report.count - 1) {
            let diff = report[i] - report[i + 1]
            if diff > -1 || diff < -3 {
                index = i
                break
            }
        }

        var increasingSafe = checkPart1(report: Array(report[0 ..< index] + report[index + 1 ..< report.count]))
        if !increasingSafe {
            increasingSafe = checkPart1(
                report: Array(
                    report[0 ..< index + 1] + (index < report.count - 2 ? report[index + 2 ..< report.count] : [])
                )
            )
        }

        return decreasingSafe || increasingSafe
    }
}
