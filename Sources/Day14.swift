//
//  Day14.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 18/12/24.
//

import Foundation

struct Day14: DailySolvable {

    typealias Position = (x: Int, y: Int)
    typealias Velocity = (vX: Int, vY: Int)

    struct Robot {

        var position: Position
        let velocity: Velocity
    }

    static let day = 14
    let robots: [Robot]
    let bathroomWide = 101
    let bathroomTall = 103
    let timesInSeconds = 100

    init(input: String) {
        robots = input
            .split(separator: "\n")
            .compactMap { Self.parseRobot(String($0)) }
    }

    func answerPart1() -> Int {
        var robots = robots
        updatePositions(&robots, after: timesInSeconds)

        var safetyFactor = [0, 0, 0, 0]
        for robot in robots {
            guard robot.position.x >= 0, robot.position.x < bathroomWide,
                  robot.position.y >= 0, robot.position.y < bathroomTall else { continue }
            if robot.position.x < bathroomWide / 2, robot.position.y < bathroomTall / 2 {
                // top-left
                safetyFactor[0] += 1
            } else if robot.position.x < bathroomWide / 2, robot.position.y > bathroomTall / 2 {
                // bottom-left
                safetyFactor[1] += 1
            } else if robot.position.x > bathroomWide / 2, robot.position.y < bathroomTall / 2 {
                // top-right
                safetyFactor[2] += 1
            } else if robot.position.x > bathroomWide / 2, robot.position.y > bathroomTall / 2 {
                // bottom-right
                safetyFactor[3] += 1
            }
        }

        return safetyFactor.reduce(1, *)
    }

    func answerPart2() -> Int {
        var robots = robots
        var seconds = 1
        var positions = Set<Point>()

        while true {
            updatePositions(&robots, after: 1)
            positions = .init(robots.map { Point(x: $0.position.x, y: $0.position.y) })

            if positions.count == robots.count {
                printRobotsInBathroom(robots: robots)
                break
            }
            seconds += 1
        }

        return seconds
    }
}

extension Day14 {

    private static func parseRobot(_ string: String) -> Robot? {
        let parts = string.split(separator: " ")
        guard parts.count == 2 else { return nil }

        let positionString = parts[0].map(String.init)
        let velocityString = parts[1].map(String.init)
        guard positionString.count >= 4, positionString.joined().hasPrefix("p="),
              velocityString.count >= 4, velocityString.joined().hasPrefix("v=") else {
            return nil
        }

        let positionPart = positionString[2 ..< positionString.count].joined().split(separator: ",")
        let velocityPart = velocityString[2 ..< velocityString.count].joined().split(separator: ",")
        guard positionPart.count == 2, let pX = Int(positionPart[0]), let pY = Int(positionPart[1]),
              velocityPart.count == 2, let vX = Int(velocityPart[0]), let vY = Int(velocityPart[1]) else {
            return nil
        }
        
        return Robot(position: (pX, pY), velocity: (vX, vY))
    }

    private func updatePositions(_ robots: inout [Robot], after seconds: Int) {
        for i in (0 ..< robots.count) {
            var robot = robots[i]
            var x = (robot.position.x + robot.velocity.vX * seconds) % bathroomWide
            var y = (robot.position.y + robot.velocity.vY * seconds) % bathroomTall

            if x < 0 {
                x += bathroomWide
            }
            if y < 0 {
                y += bathroomTall
            }

            robot.position = (x, y)
            robots[i] = robot
        }
    }

    private func printRobotsInBathroom(robots: [Robot]) {
        var bathroom = Array(repeating: Array(repeating: ".", count: bathroomWide), count: bathroomTall)

        for robot in robots {
            bathroom[robot.position.y][robot.position.x] = "#"
        }

        for i in (0 ..< bathroomTall) {
            for j in (0 ..< bathroomWide) {
                print(bathroom[i][j], terminator: "")
            }
            print()
        }
    }
}
