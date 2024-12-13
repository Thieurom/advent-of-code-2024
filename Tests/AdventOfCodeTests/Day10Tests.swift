//
//  Day10Tests.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 12/12/24.
//

@testable import aoc
import Testing

struct Day10Tests {

    let input = """
    89010123
    78121874
    87430965
    96549874
    45678903
    32019012
    01329801
    10456732
    """

    @Test func testPart1() {
        let day = Day10(input: input)
        #expect(day.answerPart1() == 36)
    }

    @Test func testPart2() {
        let day = Day10(input: input)
        #expect(day.answerPart2() == 81)
    }
}
