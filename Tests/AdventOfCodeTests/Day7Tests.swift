//
//  Day7Tests.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 7/12/24.
//

@testable import aoc
import Testing

struct Day7Tests {

    let input = """
    190: 10 19
    3267: 81 40 27
    83: 17 5
    156: 15 6
    7290: 6 8 6 15
    161011: 16 10 13
    192: 17 8 14
    21037: 9 7 18 13
    292: 11 6 16 20
    """

    @Test func testPart1() {
        let day = Day7(input: input)
        #expect(day.answerPart1() == 3749)
    }

    @Test func testPart2() {
        let day = Day7(input: input)
        #expect(day.answerPart2() == 11387)
    }
}
