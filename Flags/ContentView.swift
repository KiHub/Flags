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
    @State private var score = UserDefaults.standard.integer(forKey: "Score")
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scale: CGFloat = 0.4
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .orange]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 35) {
                VStack {
                    Text("👋Chosoe flag:")
                        .foregroundColor(.white)
                        .font(.headline)
                        .shadow(color: .orange, radius: 27, x: 5, y: 5)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .shadow(color: .orange, radius: 27, x: 5, y: 5)
                       
                }
                ForEach(0..<3) { number in
                    Button {
                        flagtapped(number)
                        showingScore = true
                      //  animationOn.toggle()
                    } label: {
                        Image(countries[number])
                        //  .cornerRadius(20)
                        
                            .clipShape(Circle())
                        //    .frame(width: 250, height: 150)
                        // .aspectRatio(contentMode: .fit)
                            .shadow(color: .purple, radius: 20, x: 5, y: 5)
                            .saturation(0.8)
                        
                            .scaleEffect(scale)
                            .onAppear {
                                let baseAnimation = Animation.easeInOut(duration: 1.5)
                                let repeated = baseAnimation
                                    .repeatForever(autoreverses: true)
                                return withAnimation(repeated) {
                                    self.scale = 1
                                }
                            }
                        
                    }
                    
                    
                }
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, style: StrokeStyle( lineWidth: 5, dash: [10, 2])))
                    .shadow(color: .purple, radius: 7, x: 5, y: 5)
                    .rotationEffect(.degrees(10))
                    .scaleEffect(1.2)
//                    .onAppear {
//                        let baseAnimation = Animation.easeInOut(duration: 1)
//                        let repeated = baseAnimation
//                            .repeatForever(autoreverses: true)
//                        return withAnimation(repeated) {
//                            self.scale = 0.5
//                        }
//                    }
                    
                  //  .blur(radius: 2)
                   
                
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
            UserDefaults.standard.set(score, forKey: "Score")
        } else {
            scoreTitle = "No, It's \(countries[number]) flag"
            if score > 0 {
            score -= 1
                UserDefaults.standard.set(score, forKey: "Score")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
