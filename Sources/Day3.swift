//
//  Day3.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 5/12/24.
//

struct Day3: DailySolvable {

    static let day = 3

    let instructions: [String]

    init(input: String) {
        instructions = input
            .split(separator: "\n")
            .joined()
            .map(String.init)
    }

    func answerPart1() -> Int {
        var result = 0
        var i = 0

        while i < instructions.count {
            if instructions[i] == "m" {
                guard i + 3 < instructions.count else { break }
                if instructions[i ... i+3].joined() == "mul(" {
                    var j = i + 4
                    var a = 0
                    while j < instructions.count, Int(instructions[j]) != nil, instructions[j] != "," {
                        a = a * 10 + Int(instructions[j])!
                        j += 1
                    }
                    if j == i + 4 || instructions[j] != "," {
                        i += 1
                        continue
                    }
                    var l = j + 1
                    var b = 0
                    while l < instructions.count, Int(instructions[l]) != nil, instructions[l] != ")" {
                        b = b * 10 + Int(instructions[l])!
                        l += 1
                    }
                    if l == j + 1 || instructions[l] != ")" {
                        i += 1
                        continue
                    }
                    result += a * b
                    i = l + 1
                } else {
                    i += 1
                }
            } else {
                i += 1
            }
        }

        return result
    }

    func answerPart2() -> Int {
        var result = 0
        var i = 0
        var enabled = true

        while i < instructions.count {
            if instructions[i] == "m" && enabled {
                guard i + 3 < instructions.count else { break }
                if instructions[i ... i + 3].joined() == "mul(" {
                    var k = i + 4
                    var a = 0
                    while k < instructions.count, Int(instructions[k]) != nil, instructions[k] != "," {
                        a = a * 10 + Int(instructions[k])!
                        k += 1
                    }
                    if k == i + 4 || instructions[k] != "," {
                        i += 1
                        continue
                    }
                    var l = k + 1
                    var b = 0
                    while l < instructions.count, Int(instructions[l]) != nil, instructions[l] != ")" {
                        b = b * 10 + Int(instructions[l])!
                        l += 1
                    }
                    if l == k + 1 || instructions[l] != ")" {
                        i += 1
                        continue
                    }
                    result += a * b
                    i = l + 1
                } else {
                    i += 1
                }
            } else if instructions[i] == "d" {
                if i + 3 < instructions.count, instructions[i ... i + 3].joined() == "do()" {
                    enabled = true
                    i += 4
                } else if i + 6 < instructions.count, instructions[i ... i + 6].joined() == "don't()" {
                    enabled = false
                    i += 7
                } else {
                    i += 1
                }
            } else {
                i += 1
            }
        }

        return result
    }
}
