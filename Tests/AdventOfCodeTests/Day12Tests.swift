//
//  Day12Tests.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 16/12/24.
//

@testable import aoc
import Testing

struct Day12Tests {

    @Test func testPart1WithInput1() {
        let input = """
        AAAA
        BBCD
        BBCC
        EEEC
        """
        let day = Day12(input: input)
        #expect(day.answerPart1() == 140)
    }

    @Test func testPart1WithInput2() {
        let input = """
        OOOOO
        OXOXO
        OOOOO
        OXOXO
        OOOOO
        """
        let day = Day12(input: input)
        #expect(day.answerPart1() == 772)
    }

    @Test func testPart1WithInput3() {
        let input = """
        RRRRIICCFF
        RRRRIICCCF
        VVRRRCCFFF
        VVRCCCJFFF
        VVVVCJJCFE
        VVIVCCJJEE
        VVIIICJJEE
        MIIIIIJJEE
        MIIISIJEEE
        MMMISSJEEE
        """
        let day = Day12(input: input)
        #expect(day.answerPart1() == 1930)
    }

    @Test func testPart2WithInput1() {
        let input = """
        AAAA
        BBCD
        BBCC
        EEEC
        """
        let day = Day12(input: input)
        #expect(day.answerPart2() == 80)
    }

    @Test func testPart2WithInput2() {
        let input = """
        EEEEE
        EXXXX
        EEEEE
        EXXXX
        EEEEE
        """
        let day = Day12(input: input)
        #expect(day.answerPart2() == 236)
    }

    @Test func testPart2WithInput3() {
        let input = """
        AAAAAA
        AAABBA
        AAABBA
        ABBAAA
        ABBAAA
        AAAAAA
        """
        let day = Day12(input: input)
        #expect(day.answerPart2() == 368)
    }

    @Test func testPart2WithInput4() {
        let input = """
        RRRRIICCFF
        RRRRIICCCF
        VVRRRCCFFF
        VVRCCCJFFF
        VVVVCJJCFE
        VVIVCCJJEE
        VVIIICJJEE
        MIIIIIJJEE
        MIIISIJEEE
        MMMISSJEEE
        """
        let day = Day12(input: input)
        #expect(day.answerPart2() == 1206)
    }
}
