//
//  CustomPicker.swift
//  UBudget
//
//  Created by Sami Hatna on 24/08/2021.
//

import SwiftUI

struct CustomPicker: View {
    @Binding var options: [String]
    @Binding var choice: String
    
    // Binding of UIKit DatePicker
    // Provides more customisability than SwiftUI counterpart
    init(options: Binding<[String]>, choice: Binding<String>) {
            UISegmentedControl.appearance().selectedSegmentTintColor = .white
            UISegmentedControl.appearance().setTitleTextAttributes(
                [
                    .font: UIFont(name: "DIN", size: 15) ?? UIFont.boldSystemFont(ofSize: 15),
                    .foregroundColor: UIColor.black
            ], for: .selected)

            UISegmentedControl.appearance().setTitleTextAttributes(
                [
                    .font: UIFont(name: "DIN", size: 15) ?? UIFont.boldSystemFont(ofSize: 15),
                    .foregroundColor: UIColor.white
            ], for: .normal)
        
        self._options = options
        self._choice = choice
    }
    
    var body: some View {
        Picker("", selection: $choice) {
            ForEach(options, id: \.self) {
                Text($0)
            }
        }.pickerStyle(SegmentedPickerStyle()).frame(width: 260)
    }
}

