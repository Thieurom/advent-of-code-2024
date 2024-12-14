//
//  Day11Tests.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 14/12/24.
//

@testable import aoc
import Testing

struct Day11Tests {

    let input = "125 17"

    @Test func testPart1() {
        let day = Day11(input: input)
        #expect(day.answerPart1() == 55312)
    }
}
