//
//  InfoView.swift
//  UBudget
//
//  Created by Sami Hatna on 27/07/2021.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
//        RoundedRectangle(cornerRadius: 15.0).foregroundColor(.white).overlay(
//            Text("Recurring payments are amounts of money which will automatically be deducted from your budget at regular time intervals. They can be used for costs such as rent, insurance, subscriptions, etc.")
//                .font(Font.custom("DIN", size: 20)).foregroundColor(.black).padding().multilineTextAlignment(.center)
//        ).frame(width: UIScreen.main.bounds.width - 50)
        Text("Recurring payments are amounts of money which will automatically be deducted from your budget at regular time intervals. They can be used for costs such as rent, insurance, subscriptions, etc.")
            .font(Font.custom("DIN", size: 20)).foregroundColor(.black).padding().multilineTextAlignment(.center)
            .frame(width: UIScreen.main.bounds.width - 50)
            .background(
                RoundedRectangle(cornerRadius: 15.0).fill(Color.white).frame(width: UIScreen.main.bounds.width - 50)
        )
    }
}

