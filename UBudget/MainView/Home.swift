//
//  Home.swift
//  UBudget
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
    @State var start: Date
    @State var end: Date
    @State var notOnBudget: [DateStruct]
    @State var difference: Int
    @State var overlayOpacity = 0.0
    @State var blurRadius = 0.0
    
    @State var isExpense = false
    
    @Binding var showGuideOverlay: Bool
    
    var body: some View {
        ZStack (alignment: .center) {
            
            VStack {
                Toolbar(showingSettings: $showingSettings, showingExplore: $showingExplore)
                
                Spacer()
                
                BudgetVisual(weekTotal: $weeklyBudget, yearTotal: yearTotal, deductibleList: $deductibleList)
                    .overlay(BubbleOverlay().offset(x: 100, y: -150).opacity(showGuideOverlay ? 1 : 0))
                
                Spacer()
                
                // Bottom set of buttons
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
                            Circle()
                                .fill(colorScheme == .dark ? Color.white : Color.black)
                                .frame(width: 50, height: 50)
                            Image("addmoneyicon")
                                .resizable()
                                .frame(width: 30, height: 30)
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
                            Circle()
                                .fill(colorScheme == .dark ? Color.white : Color.black)
                                .frame(width: 70, height: 70)
                            Image("addexpenseicon")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }.padding(.bottom, 5)
                    
                    Spacer()
                    
                    Button(action: {
                        showingGuide = true
                    }) {
                        ZStack {
                            Circle()
                                .fill(colorScheme == .dark ? Color.white : Color.black)
                                .frame(width: 50, height: 50)
                            Image("guideicon")
                                .resizable()
                                .frame(width: 13, height: 22)
                                .foregroundColor(.white)
                        }
                    }.padding(.bottom, 5)
                    .overlay(GuideOverlay().offset(x: -20, y: -65).opacity(showGuideOverlay ? 1 : 0))
                    .onAppear {
                        // If the user is seeing this screen for the first time, display the instructional overlays
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
            .contentShape(Rectangle())
            .onTapGesture {
                // Hide keyboard
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                // Hide any overlay windows
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
            
            AddExpense(weeklyBudget: $weeklyBudget, yearTotal: $yearTotal, overlayOpacity: $overlayOpacity, blurRadius: $blurRadius, isExpense: $isExpense)
                .opacity(overlayOpacity)
                .frame(height: 160)
        }
    }
}


