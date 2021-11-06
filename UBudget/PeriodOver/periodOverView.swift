//
//  PeriodOverView.swift
//  UBudget
//
//  Created by Sami Hatna on 25/10/2021.
//

import SwiftUI

// Displays a summary screen when budgeting period is over, offering user chance to start budgeting again
// Swipe up to view summary stats
struct periodOverView: View {
    @State var arrowOpacity1 = 1.0
    @State var arrowOpacity2 = 0.5
    @State var infoText = "Swipe up for more"
    @State var arrowRotation = 0.0
    
    @State var overlayOffset = UIScreen.main.bounds.height
    
    @State var graphData: [SaveData]
    
    var body: some View {
        ZStack {
            Backdrop()
            
            VStack {
                Spacer()
                
                Text("Congratulations!")
                    .foregroundColor(.white).font(Font.custom("DIN Bold", size: 40)).padding(.bottom, 5)
                Text("You have reached the end of your budgeting period")
                    .foregroundColor(.white).font(Font.custom("DIN", size: 20))
                    .multilineTextAlignment(.center).padding(.bottom, 10)
                
                Button(action: {
                    // Redisplay onboarding screen if user wants to budget again
                    UserDefaults.standard.set(true, forKey: "didLaunchBefore")
                }) {
                    ZStack (alignment: .center) {
                        RoundedRectangle(cornerRadius: 30).fill(Color.white).frame(width: 200, height: 40)
                        Text("Start a new budget").foregroundColor(.black)
                            .font(Font.custom("DIN", size: 20)).multilineTextAlignment(.center)
                    }
                }
                
                Spacer()
                
                // Visual telling user to swipe up/down to show/dismiss view
                VStack {
                    swipeUpArrow()
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                        .frame(width: 12, height: 5).opacity(arrowOpacity1)
                        .rotationEffect(.degrees(arrowRotation))
                    swipeUpArrow()
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                        .opacity(arrowOpacity2).rotationEffect(.degrees(arrowRotation))
                        .frame(width: 12, height: 5).padding(.top, -20)
                }.padding(.bottom, -15).onAppear {
                    withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)) {
                        arrowOpacity1 = 0.5
                        arrowOpacity2 = 1
                    }
                }
                
                Text(infoText).foregroundColor(.white).font(Font.custom("DIN", size: 15)).padding(.bottom, 15)
            }.padding()
            
            DetailsView(graphData: graphData).offset(y: overlayOffset)
            
        }.background(Color.white.edgesIgnoringSafeArea(.all))
            .gesture(
                // Handles user swipes by changing DetailsView offset
                DragGesture()
                    .onChanged { move in
                        if move.startLocation.y > move.location.y {
                            infoText = "Swipe down to dismiss"
                            arrowRotation = 180
                            withAnimation(.linear(duration: 0.2)) {
                                overlayOffset = 0
                            }
                        }
                        else if move.startLocation.y < move.location.y {
                            infoText = "Swipe up for more"
                            arrowRotation = 0
                            withAnimation(.linear(duration: 0.2)) {
                                overlayOffset = UIScreen.main.bounds.height
                            }
                        }
                    }
            )
    }
}

