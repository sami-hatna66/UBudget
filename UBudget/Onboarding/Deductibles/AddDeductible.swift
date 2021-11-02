//
//  SwiftUIView.swift
//  UBudget
//
//  Created by Sami Hatna on 24/08/2021.
//

import SwiftUI

struct AddDeductible: View {
    @State var name = ""
    @State var amount = ""
    @State var intervals = ["Daily", "Weekly", "Monthly", "Yearly"]
    @State var selectedInterval = "Daily"
    
    @Binding var deductibleCollection: [DeductibleStruct]
    @Binding var showingSheet: Bool
    
    var body: some View {
        VStack {
            Text("Add a Recurring Payment").foregroundColor(.white).font(Font.custom("DIN", size: 30)).padding(.bottom, 10)
            
            VStack (alignment: .leading) {
                HStack {
                    Text("Name:").foregroundColor(.white).font(Font.custom("DIN", size: 20)).padding(.trailing, 25)
                        .lineLimit(1).minimumScaleFactor(0.5)
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0).foregroundColor(.white).frame(width: 260, height: 30)
                        TextField("", text: $name).foregroundColor(.black).accentColor(.black).frame(width: 230).background(Color.white).accentColor(.black).font(Font.custom("DIN", size: 15))
                    }
                }
                HStack {
                    Text("Amount:").foregroundColor(.white).font(Font.custom("DIN", size: 20)).padding(.trailing, 10).lineLimit(1).minimumScaleFactor(0.5)
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0).foregroundColor(.white).frame(width: 260, height: 30)
                        TextField("", text: $amount).foregroundColor(.black).accentColor(.black).frame(width: 230).keyboardType(.decimalPad).background(Color.white).accentColor(.black).font(Font.custom("DIN", size: 15))
                    }
                }
                HStack {
                    Text("Interval:").foregroundColor(.white).font(Font.custom("DIN", size: 20)).padding(.trailing, 12).lineLimit(1).minimumScaleFactor(0.5)
                    CustomPicker(options: $intervals, choice: $selectedInterval)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        if name != "" {
                            deductibleCollection.append(DeductibleStruct(name: name, amount: Double(amount) ?? 1, interval: selectedInterval))
                            showingSheet = false
                        }
                    }) {
                        ZStack (alignment: .center) {
                            RoundedRectangle(cornerRadius: 30).fill(Color.white).frame(width: 100, height: 40)
                            Text("Submit").foregroundColor(.black).font(Font.custom("DIN", size: 20)).multilineTextAlignment(.center)
                        }
                    }.padding(.top, 30)
                    Spacer()
                }
            }.padding()
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color(red: 36/255, green: 36/255, blue: 37/255, opacity: 1.0).edgesIgnoringSafeArea(.all))
    }
}

