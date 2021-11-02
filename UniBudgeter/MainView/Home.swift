//
//  Home.swift
//  UniBudgeter
//
//  Created by Sami Hatna on 14/08/2021.
//

import SwiftUI

struct Home: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var showingSettings: Bool
    @Binding var showingExplore: Bool
    @Binding var showingGuide: Bool
    
    @Binding var deductibleList: [String]
    
    @State var weeklyBudget: [Double]
    @State var yearTotal: Double
    @State var rolloverChoice: Bool
    @State var start: Date
    @State var end: Date
    @State var notOnBudget: [DateStruct]
    @State var difference: Int
    @State var overlayOpacity = 0.0
    @State var blurRadius = 0.0
    
    @State var isExpense = false
    
    @Binding var showGuideOverlay: Bool
    
    var hasNotch: Bool {
            guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
            if UIDevice.current.orientation.isPortrait {
                return window.safeAreaInsets.top >= 44
            } else {
                return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
            }
        }
    
    var body: some View {
        ZStack (alignment: .center) {
            
            VStack {
                Toolbar(showingSettings: $showingSettings, showingExplore: $showingExplore)
                
                Spacer()
                
                BudgetVisual(weekTotal: $weeklyBudget, yearTotal: yearTotal, deductibleList: $deductibleList)
                    .overlay(BubbleOverlay().offset(x: 100, y: -150).opacity(showGuideOverlay ? 1 : 0))
                
                Spacer()
                
                HStack (alignment: .bottom) {
                    Spacer()
                    Button(action: {
                        isExpense = false
                        withAnimation(.linear(duration: 0.3)) {
                            overlayOpacity = 1.0
                            blurRadius = 5
                        }
                    }) {
                        ZStack {
                            Circle().fill(colorScheme == .dark ? Color.white : Color.black).frame(width: 50, height: 50)
                            Image("addmoneyicon").resizable().frame(width: 30, height: 30)
                        }
                    }.padding(.bottom, 5)
                    
                    Spacer()
                    
                    Button(action: {
                        isExpense = true
                        withAnimation(.linear(duration: 0.3)) {
                            overlayOpacity = 1.0
                            blurRadius = 5
                        }
                    }) {
                        ZStack {
                            Circle().fill(colorScheme == .dark ? Color.white : Color.black).frame(width: 70, height: 70)
                            Image("addexpenseicon").resizable().frame(width: 40, height: 40)
                        }
                    }.padding(.bottom, 5)
                    
                    Spacer()
                    
                    Button(action: {
                        showingGuide = true
                    }) {
                        ZStack {
                            Circle().fill(colorScheme == .dark ? Color.white : Color.black).frame(width: 50, height: 50)
                            Image("guideicon").resizable().frame(width: 13, height: 22).foregroundColor(.white)
                        }
                    }.padding(.bottom, 5)
                    .overlay(GuideOverlay().offset(x: -20, y: -65).opacity(showGuideOverlay ? 1 : 0))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation(.linear(duration: 0.5)) {
                                showGuideOverlay = false
                                UserDefaults.standard.setValue(false, forKey: "showGuideOverlay")
                            }
                        }
                    }
                    
                    Spacer()
                }
                
                
                
            }.blur(radius: CGFloat(blurRadius))
            .contentShape(Rectangle()).onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                withAnimation(.linear(duration: 0.3)) {
                    overlayOpacity = 0.0
                    blurRadius = 0
                }
            }
            .onAppear {
                print(difference)
                print(yearTotal/Double(difference))
                print(weeklyBudget)
            }
            
            AddExpense(weeklyBudget: $weeklyBudget, yearTotal: $yearTotal, overlayOpacity: $overlayOpacity, blurRadius: $blurRadius, isExpense: $isExpense).opacity(overlayOpacity).frame(height: 160)
        }
    }
}

extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return keyWindow?.safeAreaInsets.bottom ?? 0 > 0
        }
        return false
    }

}

