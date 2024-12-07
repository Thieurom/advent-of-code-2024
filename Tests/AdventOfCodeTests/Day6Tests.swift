//
//  Day6Tests.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 6/12/24.
//

@testable import aoc
import Testing

struct Day6Tests {

    let input = """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
    """

    @Test func testPart1() {
        let day = Day6(input: input)
        #expect(day.answerPart1() == 41)
    }

    @Test func testPart2() {
        let day = Day6(input: input)
        #expect(day.answerPart2() == 6)
    }
}
