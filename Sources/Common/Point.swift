//
//  Point.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 9/12/24.
//

struct Point: Hashable {

    var x: Int
    var y: Int
}

extension Point {

    func offset(dx: Int = 0, dy: Int = 0) -> Point {
        Point(x: x + dx, y: y + dy)
    }

    func inBounds(width: Int, height: Int) -> Bool {
        x >= 0 && y >= 0 && x < width && y < height
    }
}
