//
//  ContentView.swift
//  UBudget
//
//  Created by Sami Hatna on 27/07/2021.
//

import SwiftUI

struct ContentView: View {
    let userDefaults = UserDefaults(suiteName: "group.com.my.app.unibudgeter") ?? UserDefaults.standard
    
    @AppStorage("didLaunchBefore") var didLaunchBefore: Bool = true
    @State var showingSettings = false
    @State var showingExplore = false
    @State var showingGuide = false
    
    @AppStorage("showGuideOverlay") var showGuideOverlay: Bool = true
    
    @State var needsUpdating = false
    
    @State var deductibleList: [String] = []
    
    var total: Double {
        UserDefaults(suiteName: "group.com.my.app.unibudgeter")?.double(forKey: "total") ?? 0.0
    }
    
    @AppStorage("applyRollover") var rolloverChoice: Bool = false
    
    var start: Date {
        return Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: "startDate"))
    }
    var end: Date {
        return Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: "endDate"))
    }
    
    var timePeriodOver: Bool {
        if Date() > end {
            return true
        }
        else {
            return false
        }
    }
    
    var notOnBudget: [DateStruct] {
        if let data = UserDefaults.standard.value(forKey:"notOnBudget") as? Data {
            let returnValue = (try? PropertyListDecoder().decode(Array<DateStruct>.self, from: data))!
            return returnValue
        }
        else {
            return []
        }
    }
    
    var deductibles: [DeductibleStruct] {
        if let data = UserDefaults.standard.value(forKey: "deductibles") as? Data {
            let returnValue = (try? PropertyListDecoder().decode(Array<DeductibleStruct>.self, from: data))!
            return returnValue
        }
        else {
            return []
        }
    }
    
    var currencySymbol: String {
        let locale = Locale.current
        return locale.currencySymbol!
    }
    
    var previousWeekData: [SaveData] {
        if let data = UserDefaults.standard.value(forKey: "saveData") as? Data {
            let returnValue = (try? PropertyListDecoder().decode(Array<SaveData>.self, from: data))!
            return returnValue
        }
        else {
            return []
        }
    }
    
    let launchPrevDate = Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: "previousDate"))
    @State var hasChecked = false
    
    var weeklyBudget: [Double] {
        print(previousWeekData)
        let previousDate = Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: "previousDate"))
        if previousDate.isSame(input: Date(), granularity: .weekOfYear) && needsUpdating == false {
            print("Not new week")
            var result = userDefaults.double(forKey: "weeklySpend")
            deductibles.forEach {
                if $0.active {
                    if (previousDate.isSame(input: Date(), granularity: .month) == false) && ($0.interval == "Monthly") {
                        result -= $0.amount
                    }
                    if (previousDate.isSame(input: Date(), granularity: .day) == false) && ($0.interval == "Daily") {
                        result -= $0.amount
                    }
                    if (previousDate.isSame(input: Date(), granularity: .year) == false) && ($0.interval == "Yearly") {
                        result -= $0.amount
                    }
                }
            }
            userDefaults.set(result, forKey: "weeklySpend")
            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "previousDate")
            return [userDefaults.double(forKey: "weeklyTotal"), result]
        }
        else {
            if Calendar.current.dateComponents([.year], from: previousDate).year! > 1980 && needsUpdating == false {
                print("Saving data")
                let savePreviousWeek = [SaveData(start: previousDate.startOfWeek!, end: previousDate.endOfWeek!, total: userDefaults.double(forKey: "weeklyTotal"), spent: userDefaults.double(forKey: "weeklyTotal") - userDefaults.double(forKey: "weeklySpend"))]
                UserDefaults.standard.set(try? PropertyListEncoder().encode(previousWeekData + savePreviousWeek), forKey: "saveData")
            }
            print("new week")
            print(deductibles)
            let weekRange = Date() ... Date().endOfWeek!
            var numOfDays = 7
            if Date().startOfWeek! < start {
                numOfDays -= (start.dayNumberOfWeek()! - 1)
            }
            if Date().endOfWeek! > end {
                print(String(numOfDays) + " -= 7 - " + String(end.dayNumberOfWeek()!))
                numOfDays -= (7 - end.dayNumberOfWeek()!)
            }
            notOnBudget.forEach {
                if $0.active {
                    if weekRange.overlaps($0.start ... $0.end) {
                        if $0.start < Date().startOfWeek! && $0.end > Date().endOfWeek! {
                            numOfDays = 0
                        }
                        else if $0.start < Date().startOfWeek! {
                            numOfDays -= ($0.end.dayNumberOfWeek()!)
                        }
                        else if $0.end > Date().endOfWeek! {
                            numOfDays -= (7 - ($0.start.dayNumberOfWeek()! - 1))
                        }
                        else {
                            numOfDays -= ($0.end.dayNumberOfWeek()! - $0.start.dayNumberOfWeek()! + 1)
                        }
                    }
                }
            }
            print("Yuh: " + String(numOfDays))
            var resultSpend = Double(Double(numOfDays) * (total/Double(difference)))
            
            if difference <= 7 {
                resultSpend = total
            }
                
            let resultTotal = resultSpend
            deductibles.forEach {
                if $0.active {
                    if $0.interval == "Weekly" {
                        resultSpend -= $0.amount
                    }
                    if (previousDate.isSame(input: Date(), granularity: .month) == false) && ($0.interval == "Monthly") {
                        resultSpend -= $0.amount
                    }
                    if (previousDate.isSame(input: Date(), granularity: .day) == false) && ($0.interval == "Daily") {
                        resultSpend -= $0.amount
                    }
                }
            }
            if needsUpdating == false {
                userDefaults.set(resultTotal, forKey: "weeklyTotal")
                userDefaults.set(resultSpend, forKey: "weeklySpend")
                UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "previousDate")
                return [resultTotal, resultSpend]
            }
            else {
                resultSpend -= (userDefaults.double(forKey: "weeklyTotal") - userDefaults.double(forKey: "weeklySpend"))
                userDefaults.set(resultSpend, forKey: "weeklySpend")
                userDefaults.set(resultTotal, forKey: "weeklyTotal")
                UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "previousDate")
                return [resultTotal, resultSpend]
            }
        }
    }
    
    var difference: Int {
        var result = Calendar.current.dateComponents([.day], from: Date(), to: end).day!
        notOnBudget.forEach {
            if $0.active {
                let modifiedEndDate = Calendar.current.date(byAdding: .day, value: 1, to: $0.end)!
                let dayDurationInSeconds: TimeInterval = 60*60*24
                for date in stride(from: $0.start, to: modifiedEndDate, by: dayDurationInSeconds) {
                    let range = Date()...end
                    if range.contains(date) {
                        result -= 1
                    }
                }
            }
        }
        return result
    }
    
    var body: some View {
        if didLaunchBefore {
            Onboarding()
                .edgesIgnoringSafeArea(.bottom)
        }
        else if showingSettings {
            SettingsView(showingSettings: $showingSettings, notOnBudget: notOnBudget, deductibleCollection: deductibles, startDate: start, endDate: end, needsUpdating: $needsUpdating, checkStart: start, checkEnd: end, checkNotOnBudget: notOnBudget)
        }
        else if showingExplore {
            ExploreView(graphData: previousWeekData, showingExplore: $showingExplore)
        }
        else if showingGuide {
            GuideView(showingGuide: $showingGuide)
        }
        else if timePeriodOver {
            periodOverView(graphData: previousWeekData)
        }
        else {
            Home(showingSettings: $showingSettings, showingExplore: $showingExplore, showingGuide: $showingGuide, deductibleList: $deductibleList, weeklyBudget: weeklyBudget, yearTotal: total, rolloverChoice: rolloverChoice, start: start, end: end, notOnBudget: notOnBudget, difference: difference, showGuideOverlay: $showGuideOverlay)
                .onAppear {
                    print("total: " + String(total))
                    needsUpdating = false
                    if hasChecked == false {
                        deductibles.forEach {
                            if $0.active {
                                if (launchPrevDate.isSame(input: Date(), granularity: .weekOfYear) == false) && ($0.interval == "Weekly") {
                                    deductibleList.append("-" + currencySymbol + String(format: "%.2f", $0.amount) + " (" + $0.name + ")")
                                }
                                if (launchPrevDate.isSame(input: Date(), granularity: .month) == false) && ($0.interval == "Monthly") {
                                    deductibleList.append("-" + currencySymbol + String(format: "%.2f", $0.amount) + " (" + $0.name + ")")
                                }
                                if (launchPrevDate.isSame(input: Date(), granularity: .day) == false) && ($0.interval == "Daily") {
                                    deductibleList.append("-" + currencySymbol + String(format: "%.2f", $0.amount) + " (" + $0.name + ")")
                                }
                            }
                        }
                        hasChecked = true
                    }
            }
        }
    }
}

extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}

extension Date {
    func isSame(input: Date, granularity: Calendar.Component) -> Bool {
        var gregorian = Calendar(identifier: .gregorian)
        gregorian.firstWeekday = 2
        return gregorian.isDate(self, equalTo: input, toGranularity: granularity)
    }
    var endOfWeek: Date? {
        var gregorian = Calendar(identifier: .gregorian)
        gregorian.firstWeekday = 2
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    var startOfWeek: Date? {
        var gregorian = Calendar(identifier: .gregorian)
        gregorian.firstWeekday = 2
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    func dayNumberOfWeek() -> Int? {
        let result = Calendar.current.dateComponents([.weekday], from: self).weekday!
        if result == 1 {
            return 7
        }
        else {
            return result - 1
        }
    }
}

extension Date: Strideable {
    public func distance(to other: Date) -> TimeInterval {
        return other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
    }

    public func advanced(by n: TimeInterval) -> Date {
        return self + n
    }
}
