import ArgumentParser

let days: [DailySolvable] = [
    Day1(),
    Day2(),
    Day3(),
    Day4(),
    Day5(),
    Day6(),
    Day7(),
    Day8(),
    Day9(),
    Day10(),
    Day11(),
    Day12(),
    Day13()
]

@main
struct AdventOfCode: ParsableCommand {

    @Option(name: .shortAndLong, help: "The day to solve.")
    var day: Int?

    func run() throws {
        print("Advent Of Code 2024!")

        if let day {
            if let runningDay = days.first(where: { $0.day == day }) {
                print("\(runningDay.name): \(runningDay.answerPart1()) \(runningDay.answerPart2())")
            } else {
                print("There is no day \(day)!")
            }
            return
        }

        for day in days {
            print("\(day.name): \(day.answerPart1()) \(day.answerPart2())")
        }
    }
}
