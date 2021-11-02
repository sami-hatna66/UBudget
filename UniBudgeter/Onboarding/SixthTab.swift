//
//  SixthTab.swift
//  UniBudgeter
//
//  Created by Sami Hatna on 01/08/2021.
//

import SwiftUI

struct SixthTab: View {
    @State var phase = 0.0
    @State var phase2 = 0.0
    @Binding var index: Int
    @State var yOffset = 75
    @State var textOpacity = 0.0
    @State var isError = false
    
    @Binding var totalAmount: String
    @Binding var start: Date
    @Binding var end: Date
    @Binding var dateCollection: [DateStruct]
    @Binding var deductibleCollection: [DeductibleStruct]
    
    let userDefaults = UserDefaults(suiteName: "group.com.my.app.unibudgeter") ?? UserDefaults.standard
    
    var body: some View {
        ZStack (alignment: .center) {
            if index == 5 {
                Backdrop()
            }
            else {
                Wave(amplitude: 5, frequency: 10, phase: 0.0, percent: 0.93).fill(Color.black)
                    .frame(height: UIScreen.main.bounds.height)
            }
            
            
            ZStack {
                VStack {
                    AnimateTick(height: 150, width: 150, index: $index).padding(.bottom, 30)
                    Button(action: {
                        UserDefaults.standard.set(false, forKey: "didLaunchBefore")
                        userDefaults.set(Double(totalAmount), forKey: "total")
                        userDefaults.set(Double(totalAmount), forKey: "totalOverall")
                        // save dates as time intervals from 1970
                        UserDefaults.standard.set(start.timeIntervalSince1970, forKey: "startDate")
                        UserDefaults.standard.set(end.timeIntervalSince1970, forKey: "endDate")
                        var saveDateArray: [DateStruct] = []
                        dateCollection.forEach { date in
                            if date.active {
                                saveDateArray.append(date)
                            }
                        }
                        UserDefaults.standard.set(try? PropertyListEncoder().encode(saveDateArray), forKey: "notOnBudget")
                        var saveDeductibleArray: [DeductibleStruct] = []
                        deductibleCollection.forEach { deductible in
                            if deductible.active {
                                saveDeductibleArray.append(deductible)
                            }
                        }
                        UserDefaults.standard.set(try? PropertyListEncoder().encode(saveDeductibleArray), forKey: "deductibles")
                    }) {
                        ZStack (alignment: .center) {
                            RoundedRectangle(cornerRadius: 30).fill(Color.white).frame(width: 250, height: 50)
                            Text("Start Budgeting").foregroundColor(.black).font(Font.custom("DIN", size: 30)).multilineTextAlignment(.center)
                        }
                    }.opacity(textOpacity).offset(y: CGFloat(yOffset))
                }.opacity(isError ? 0 : 1)
                VStack {
                    AnimateCross(height: 150, width: 150, index: $index).padding(.bottom, 30)
                    Text("There was an error processing some of the data you inputted").opacity(textOpacity).offset(y: CGFloat(yOffset)).foregroundColor(.white).font(Font.custom("DIN", size: 30)).multilineTextAlignment(.center)
                }.padding().opacity(isError ? 1 : 0)
            }
            .onChange(of: index, perform: { _ in
                if index == 5 {
                    var check = true
                    for n in 0..<dateCollection.count {
                        if dateCollection[n].start > dateCollection[n].end {
                            check = false
                        }
                    }
                    
                    guard Double(totalAmount) ?? 0.0 > 0, start < end, check == true else {
                        isError = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(.easeInOut(duration: 1)) {
                                textOpacity = 1
                                yOffset = 0
                            }
                        }
                        return
                    }
                    isError = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.easeInOut(duration: 1)) {
                            textOpacity = 1
                            yOffset = 0
                        }
                    }
                }
                else {
                    textOpacity = 0
                    yOffset = 75
                }
            })
                
        }
    }
}


