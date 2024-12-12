//
//  Day9.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 9/12/24.
//

struct Block {

    let size: Int
    var data: [Int]
}

struct Day9: DailySolvable {

    static let day = 9

    private let diskMap: [String]

    init(input: String) {
        diskMap = input.map(String.init)
    }

    func answerPart1() -> Int {
        var map = diskMap
            .enumerated()
            .compactMap { offset, element -> [String]? in
                guard let number = Int(String(element)) else { return nil }
                if offset % 2 == 0 {
                    return Array(repeating: "\(offset / 2)", count: number)
                }
                return Array(repeating: ".", count: number)
            }
            .flatMap { $0 }

        var i = 0
        var j = map.count - 1
        while i < j {
            if map[i] == "." {
                map.swapAt(i, j)
                j -= 1
            } else {
                i += 1
            }
        }

        var checksum = 0
        i = 0
        while i < map.count {
            guard let number = Int(map[i]) else { break }
            checksum += number * i
            i += 1
        }
        return checksum
    }

    func answerPart2() -> Int {
        var blocks = diskMap
            .enumerated()
            .compactMap { offset, element -> Block? in
                guard let count = Int(String(element)), count > 0 else { return nil }
                let data = if offset % 2 == 0 {
                    Array(repeating: offset / 2, count: count)
                } else {
                    [Int]()
                }
                return Block(size: count, data: data)
            }

        for i in (0 ..< blocks.count).reversed() {
            let block = blocks[i]
            guard block.data.count == block.size else { continue }

            for j in 0 ..< i {
                let leftBlock = blocks[j]
                if leftBlock.size - leftBlock.data.count >= block.size {
                    blocks[j] = Block(
                        size: leftBlock.size,
                        data: leftBlock.data + block.data
                    )
                    blocks[i] = Block(
                        size: block.size,
                        data: []
                    )
                    break
                }
            }
        }

        var checksum = 0
        var position = 0

        for block in blocks {
            checksum += block
                .data
                .enumerated()
                .reduce(0) {
                    $0 + $1.element * (position + $1.offset)
                }
            position += block.size
        }

        return checksum
    }
}
