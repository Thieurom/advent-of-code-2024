//
//  Direction.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 20/12/24.
//

enum Direction: String {

    case north = "^"
    case south = "v"
    case east = ">"
    case west = "<"

    func turn() -> Direction {
        switch self {
        case .north: return .east
        case .east: return .south
        case .south: return .west
        case .west: return .north
        }
    }
}
