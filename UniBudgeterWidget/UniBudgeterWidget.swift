//
//  UniBudgeterWidget.swift
//  UniBudgeterWidget
//
//  Created by Sami Hatna on 25/09/2021.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    let userDefaults = UserDefaults(suiteName: "group.com.my.app.unibudgeter") ?? UserDefaults.standard
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), weeklySpend: 0.0, weeklyTotal: 0.0, globalTotal: 0.0, remainingTotal: 0.0)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), weeklySpend: userDefaults.double(forKey: "weeklySpend"), weeklyTotal: userDefaults.double(forKey: "weeklyTotal"), globalTotal: userDefaults.double(forKey: "totalOverall"), remainingTotal: userDefaults.double(forKey: "total"))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [SimpleEntry] = [SimpleEntry(date: Date(), weeklySpend: userDefaults.double(forKey: "weeklySpend"), weeklyTotal: userDefaults.double(forKey: "weeklyTotal"), globalTotal: userDefaults.double(forKey: "totalOverall"), remainingTotal: userDefaults.double(forKey: "total"))]

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    
    let weeklySpend: Double
    let weeklyTotal: Double
    let globalTotal: Double
    let remainingTotal: Double
}

struct UniBudgeterWidgetEntryView : View {
    @Environment(\.colorScheme) var colorScheme
    
    var entry: Provider.Entry
    
    var currencySymbol: String {
        let locale = Locale.current
        return locale.currencySymbol!
    }

    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        HStack {
            if widgetFamily == .systemMedium {
                Spacer()
            }
            
            VStack {
                Text("Weekly Budget").foregroundColor(colorScheme == .dark ? .white : .black).font(Font.custom("DIN", size: 17)).lineLimit(1).minimumScaleFactor(0.5)
                
                BudgetCircle(currencySymbol: currencySymbol, total: entry.weeklyTotal, spend: entry.weeklySpend)
            }.padding(3)
            
            if widgetFamily == .systemMedium {
                Spacer()
                VStack {
                    Text("Overall Budget").foregroundColor(colorScheme == .dark ? .white : .black).font(Font.custom("DIN", size: 17)).lineLimit(1).minimumScaleFactor(0.5)
                    
                    BudgetCircle(currencySymbol: currencySymbol, total: entry.globalTotal, spend: entry.remainingTotal)
                }
                Spacer()
            }
        }
    }
}

@main
struct UniBudgeterWidget: Widget {
    @Environment(\.colorScheme) var colorScheme
    
    let kind: String = "UniBudgeterWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            UniBudgeterWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

