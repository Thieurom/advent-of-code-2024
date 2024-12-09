//
//  Day8Tests.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 8/12/24.
//

@testable import aoc
import Testing

struct Day8Tests {

    let input = """
    ............
    ........0...
    .....0......
    .......0....
    ....0.......
    ......A.....
    ............
    ............
    ........A...
    .........A..
    ............
    ............
    """

    @Test func testPart1() {
        let day = Day8(input: input)
        #expect(day.answerPart1() == 14)
    }

    @Test func testPart2() {
        let day = Day8(input: input)
        #expect(day.answerPart2() == 34)
    }
}
