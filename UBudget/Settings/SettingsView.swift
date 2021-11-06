//
//  SettingsView.swift
//  UBudget
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
            // Close settings button
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) { showingSettings.toggle() }
                }) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }.padding(.trailing, 10)
            }
            
            Text("Settings").font(Font.custom("DIN", size: 40)).padding(.bottom, 15)
            
            HStack {
                Text("Change Start and End Dates")
                    .font(Font.custom("DIN", size: 20))
                    .padding(.leading, 15).padding(.bottom, -4)
                Spacer()
            }
            
            // Pass values from userdefaults in as bindings
            StartEndWidget(startDate: $startDate, endDate: $endDate).padding(.bottom, 20)

            HStack {
                Text("Edit Off-Budget Dates")
                    .font(Font.custom("DIN", size: 20))
                    .padding(.leading, 15).padding(.bottom, -4)
                Spacer()
            }
            
            VancancyView(dateCollection: $notOnBudget, isOnboarding: false)
                .padding(.trailing, 4).padding(.bottom, 20)
            
            HStack {
                Text("Edit Recurring Payments")
                    .font(Font.custom("DIN", size: 20))
                    .padding(.leading, 15).padding(.bottom, -4)
                Spacer()
            }
            
            DeductiblesView(deductibleCollection: $deductibleCollection, showingSheet: $showingSheet, isOnboarding: false)
            
            Button(action: {
                // Save edited values to userdefaults - will be evaluated onAppear of Home.swift
                UserDefaults.standard.set(try? PropertyListEncoder().encode(notOnBudget), forKey: "notOnBudget")
                UserDefaults.standard.set(try? PropertyListEncoder().encode(deductibleCollection), forKey: "deductibles")
                UserDefaults.standard.set(startDate.timeIntervalSince1970, forKey: "startDate")
                UserDefaults.standard.set(endDate.timeIntervalSince1970, forKey: "endDate")
                // If start date, end date or notOnBudget dates change, the weekly budget needs to be recalculated, so flag is changed
                if checkStart != startDate || checkEnd != endDate || notOnBudget != checkNotOnBudget {
                    needsUpdating = true
                }
                showingSettings = false
            }) {
                Text("Save Changes")
                    .font(Font.custom("DIN", size: 25)).foregroundColor(Color.black)
                    .padding([.leading, .trailing], 10).padding([.top, .bottom], 5)
                    .background(
                    RoundedRectangle(cornerRadius: 30).fill(Color.white).overlay(
                        RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 1)
                    )
                )
            }.padding(.top, 20)
            
            Button(action: {
                UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            }) {
                Text("Start a new budget")
                    .font(Font.custom("DIN", size: 17))
                    .foregroundColor(.red).underline()
            }
        }
        .sheet(isPresented: $showingSheet) {
            // Add deductible window implemented as a sheet
            AddDeductible(deductibleCollection: $deductibleCollection, showingSheet: $showingSheet)
        }
    }
}

