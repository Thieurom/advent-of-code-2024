//
//  File.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 9/12/24.
//

@testable import aoc
import Testing

struct Day9Tests {

    let input = "2333133121414131402"

    @Test func testPart1() {
        let day = Day9(input: input)
        #expect(day.answerPart1() == 1928)
    }

    @Test func testPart2() {
        let day = Day9(input: input)
        #expect(day.answerPart2() == 2858)
    }
}
