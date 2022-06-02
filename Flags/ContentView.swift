//
//  ContentView.swift
//  Flags
//
//  Created by  Mr.Ki on 02.06.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Argentina", "Bangladesh", "Brazil", "Canada", "Germany", "Greece", "Russia", "Sweden", "UK", "USA"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .orange]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 35) {
                VStack {
                    Text("👋Chosoe flag:")
                        .foregroundColor(.white)
                        .font(.headline)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3) { number in
                    Button {
                        flagtapped(number)
                        showingScore = true
                    } label: {
                        Image(countries[number])
                        //  .cornerRadius(20)
                        
                            .clipShape(Circle())
                        //    .frame(width: 250, height: 150)
                        // .aspectRatio(contentMode: .fit)
                            .shadow(color: .purple, radius: 20, x: 5, y: 5)
                        
                    }
                    
                    
                }
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.heavy)
                
            }
        } .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Total score: \(score)"), dismissButton: .default(Text("Continue"))
                  {askQuestion()}
            )
            
        }
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagtapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct✌️"
            score += 1
        } else {
            scoreTitle = "No, It's \(countries[number]) flag"
            if score > 0 {
            score -= 1
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
