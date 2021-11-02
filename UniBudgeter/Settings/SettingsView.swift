//
//  SettingsView.swift
//  UniBudgeter
//
//  Created by Sami Hatna on 22/08/2021.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var showingSettings: Bool
    @State var notOnBudget: [DateStruct]
    
    @State var showingSheet = false
    @State var deductibleCollection: [DeductibleStruct]
    
    @State var startDate: Date
    @State var endDate: Date
    
    @Binding var needsUpdating: Bool
    
    var checkStart: Date
    var checkEnd: Date
    var checkNotOnBudget: [DateStruct]
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) { showingSettings.toggle() }
                }) {
                    Image(systemName: "xmark.circle").resizable().frame(width: 20, height: 20).foregroundColor(colorScheme == .dark ? .white : .black)
                }.padding(.trailing, 10)
            }
            
            Text("Settings").font(Font.custom("DIN", size: 40)).padding(.bottom, 15)
            
            HStack {
                Text("Change Start and End Dates").font(Font.custom("DIN", size: 20)).padding(.leading, 15).padding(.bottom, -4)
                Spacer()
            }
            StartEndWidget(startDate: $startDate, endDate: $endDate).padding(.bottom, 20)

            HStack {
                Text("Edit Off-Budget Dates").font(Font.custom("DIN", size: 20)).padding(.leading, 15).padding(.bottom, -4)
                Spacer()
            }
            VancancyView(dateCollection: $notOnBudget, isOnboarding: false).padding(.trailing, 4).padding(.bottom, 20)
            
            HStack {
                Text("Edit Recurring Payments").font(Font.custom("DIN", size: 20)).padding(.leading, 15).padding(.bottom, -4)
                Spacer()
            }
            DeductiblesView(deductibleCollection: $deductibleCollection, showingSheet: $showingSheet, isOnboarding: false)
            
            Button(action: {
                UserDefaults.standard.set(try? PropertyListEncoder().encode(notOnBudget), forKey: "notOnBudget")
                UserDefaults.standard.set(try? PropertyListEncoder().encode(deductibleCollection), forKey: "deductibles")
                UserDefaults.standard.set(startDate.timeIntervalSince1970, forKey: "startDate")
                UserDefaults.standard.set(endDate.timeIntervalSince1970, forKey: "endDate")
                if checkStart != startDate || checkEnd != endDate || notOnBudget != checkNotOnBudget {
                    needsUpdating = true
                }
                showingSettings = false
            }) {
                Text("Save Changes").font(Font.custom("DIN", size: 25)).foregroundColor(Color.black)
                    .padding([.leading, .trailing], 10).padding([.top, .bottom], 5)
                    .background(
                    RoundedRectangle(cornerRadius: 30).fill(Color.white).overlay(
                        RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 1)
                    )
                )
            }.padding(.top, 20).padding(.bottom, 10)
        }
        .sheet(isPresented: $showingSheet) {
            AddDeductible(deductibleCollection: $deductibleCollection, showingSheet: $showingSheet)
        }
    }
}

