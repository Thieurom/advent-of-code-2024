//
//  Day4Tests.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 5/12/24.
//

@testable import aoc
import Testing

struct Day4Tests {

    let input = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """

    @Test func testPart1() {
        let day = Day4(input: input)
        #expect(day.answerPart1() == 18)
    }

    @Test func testPart2() {
        let day = Day4(input: input)
        #expect(day.answerPart2() == 9)
    }
}
