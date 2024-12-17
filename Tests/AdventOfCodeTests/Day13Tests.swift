//
//  Day13Tests.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 17/12/24.
//

@testable import aoc
import Testing

struct Day13Tests {

    let input = """
    Button A: X+94, Y+34
    Button B: X+22, Y+67
    Prize: X=8400, Y=5400

    Button A: X+26, Y+66
    Button B: X+67, Y+21
    Prize: X=12748, Y=12176

    Button A: X+17, Y+86
    Button B: X+84, Y+37
    Prize: X=7870, Y=6450

    Button A: X+69, Y+23
    Button B: X+27, Y+71
    Prize: X=18641, Y=10279
    """

    @Test func testPart1() {
        let day = Day13(input: input)
        #expect(day.answerPart1() == 480)
    }
}
