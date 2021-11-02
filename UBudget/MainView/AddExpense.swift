//
//  AddExpense.swift
//  UBudget
//
//  Created by Sami Hatna on 16/08/2021.
//

import SwiftUI
import WidgetKit

struct AddExpense: View {
    let userDefaults = UserDefaults(suiteName: "group.com.my.app.unibudgeter") ?? UserDefaults.standard
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var weeklyBudget: [Double]
    @Binding var yearTotal: Double
    @State var expenseAmount = ""
    @Binding var overlayOpacity: Double
    @Binding var blurRadius: Double
    
    @Binding var isExpense: Bool
    
    var currencySymbol: String {
        let locale = Locale.current
        return locale.currencySymbol!
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15.0).foregroundColor(colorScheme == .dark ? .white : .black).overlay(
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0).foregroundColor(colorScheme == .dark ? .black : .white).frame(width: 300, height: 35)
                        HStack (spacing: 1) {
                            Text(isExpense ? "– " + currencySymbol : "+ " + currencySymbol).font(Font.custom("DIN", size: 20))
                            TextField("", text: $expenseAmount)
                                .background(colorScheme == .dark ? Color.black : Color.white)
                                .frame(width: 260 - currencySymbol.widthOfString(usingFont: UIFont(name: "DIN", size: 20)!))
                                .accentColor(colorScheme == .dark ? .white : .black)
                                .keyboardType(.decimalPad).font(Font.custom("DIN", size: 20))
                        }
                    }.padding(.bottom, 10)
                    
                    Button(action: {
                        if isExpense {
                            weeklyBudget[1] -= Double(expenseAmount) ?? 0
                            userDefaults.set(weeklyBudget[1], forKey: "weeklySpend")
                            yearTotal -= Double(expenseAmount) ?? 0
                            UserDefaults(suiteName: "group.com.my.app.unibudgeter")?.set(yearTotal, forKey: "total")
                        }
                        else {
                            weeklyBudget[1] += Double(expenseAmount) ?? 0
                            userDefaults.set(weeklyBudget[1], forKey: "weeklySpend")
                            if weeklyBudget[1] > weeklyBudget[0] {
                                weeklyBudget[0] = weeklyBudget[1]
                                userDefaults.set(weeklyBudget[0], forKey: "weeklyTotal")
                            }
                            yearTotal += Double(expenseAmount) ?? 0
                            UserDefaults(suiteName: "group.com.my.app.unibudgeter")?.set(yearTotal, forKey: "total")
                        }
                        
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        expenseAmount = ""
                        withAnimation(.linear(duration: 0.3)) {
                            overlayOpacity = 0.0
                            blurRadius = 0
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 30.0).stroke(colorScheme == .dark ? Color.black : Color.white, lineWidth: 1.0).overlay(
                            Text(isExpense ? "Add Expense" : "Add Extra Money").foregroundColor(colorScheme == .dark ? .black : .white).font(Font.custom("DIN", size: 20))
                        ).frame(width: isExpense ? 150 : 180, height: 30)
                    }
                }
            ).frame(width: UIScreen.main.bounds.width - 50, height: 120)
            RoundedRectangle(cornerRadius: 15.0).stroke(colorScheme == .dark ? Color.black : Color.white, lineWidth: 1).frame(width: UIScreen.main.bounds.width - 50, height: 120)
        }
    }
}

extension String {
   func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

