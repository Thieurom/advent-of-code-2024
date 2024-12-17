//
//  Day13.swift
//  AdventOfCode
//
//  Created by Doan Thieu on 17/12/24.
//

struct Day13: DailySolvable {

    struct ClawMachine {

        var buttonA: (Int, Int)
        var buttonB: (Int, Int)
        let prize: Point
    }

    enum ClawMachineComponent {

        case button(String)
        case prize

        var name: String {
            switch self {
            case let .button(string):
                "Button \(string): "
            case .prize:
                "Prize: "
            }
        }

        var sign: String {
            switch self {
            case .button: "+"
            case .prize: "="
            }
        }
    }

    static let day = 13
    let machines: [ClawMachine]
    private let prizePositionChanges = 10_000_000_000_000

    init(input: String) {
        machines = input
            .split(separator: "\n\n")
            .compactMap { lines -> ClawMachine? in
                let group = lines.split(separator: "\n")
                guard group.count == 3,
                      let buttonA = Self.parseComponent(.button("A"), string: String(group[0])),
                      let buttonB = Self.parseComponent(.button("B"), string: String(group[1])),
                      let prize = Self.parseComponent(.prize, string: String(group[2])) else {
                    return nil
                }
                return ClawMachine(
                    buttonA: buttonA,
                    buttonB: buttonB,
                    prize: Point(x: prize.0, y: prize.1)
                )
            }
    }

    func answerPart1() -> Int {
        var totalTokens = 0

        for machine in machines {
            totalTokens += tokens(machine: machine) ?? 0
        }

        return totalTokens
    }

    func answerPart2() -> Int {
        let updatedMachines = machines.map {
            ClawMachine(
                buttonA: $0.buttonA,
                buttonB: $0.buttonB,
                prize: Point(x: $0.prize.x + prizePositionChanges, y: $0.prize.y + prizePositionChanges)
            )
        }

        var totalTokens = 0

        for machine in updatedMachines {
            totalTokens += tokens(machine: machine) ?? 0
        }

        return totalTokens
    }
}

extension Day13 {

    private static func parseComponent(_ component: ClawMachineComponent, string: String) -> (Int, Int)? {
        guard string.hasPrefix(component.name) else { return nil }

        let string = string.map(String.init)
        let values = string[component.name.count ..< string.count]
            .joined()
            .split(separator: ", ")
        guard values.count == 2 else { return nil }

        let xValue = values[0].map(String.init)
        let yValue = values[1].map(String.init)
        guard xValue.count > 2, xValue.joined().hasPrefix("X\(component.sign)"),
              let x = Int(xValue[2 ..< xValue.count].joined()) else {
            return nil
        }
        guard yValue.count > 2, yValue.joined().hasPrefix("Y\(component.sign)"),
              let y = Int(yValue[2 ..< yValue.count].joined()) else {
            return nil
        }
        return (x, y)
    }

    private func tokens(machine: ClawMachine) -> Int? {
        let eq1 = (machine.buttonA.0, machine.buttonB.0, machine.prize.x)
        let eq2 = (machine.buttonA.1, machine.buttonB.1, machine.prize.y)

        let a = eq1.0 * eq2.1 - eq2.0 * eq1.1
        let a1 = eq1.2 * eq2.1 - eq2.2 * eq1.1
        let b = eq1.1 * eq2.0 - eq2.1 * eq1.0
        let b1 = eq1.2 * eq2.0 - eq2.2 * eq1.0

        guard a != 0, a1 % a == 0, b != 0, b1 % b == 0 else { return nil }
        return 3 * (a1 / a) + (b1 / b)
    }
}
