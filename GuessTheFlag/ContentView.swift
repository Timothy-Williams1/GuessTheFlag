//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Student on 9/30/24.
//
import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Spain","UK","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    //Challenge 1
    @State private var userScore = 0
    
    //Challenge 3
    @State private var finalAlert = false
    @State private var questionNumber = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
            
            Text("Guess the Flag")
                .font(.largeTitle.bold())
                .foregroundStyle(.white)
            
            VStack(spacing: 15) {
                VStack {
                    
                    Text("Tap the flag of")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                    
                    Text(countries[correctAnswer])
                    //.forgroundstyle
                        .font(.largeTitle.weight(.semibold))
                }
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 5)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))
            
            Spacer()
            Spacer()
            
                Text("score: \(userScore)")
                .foregroundStyle(.white)
                .font(.title.bold())
            
            Spacer()
            }
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            
            Text("Your score is \(userScore)")
            
            //challenge 3
            Text("your score is \(userScore). \(8 - questionNumber) question number")
        }
        
        //Challenge 3
        .alert(scoreTitle, isPresented: $finalAlert) {
            Button("Play Again?", action: reset)
        } message: {
            Text("Final score is \(userScore)")
        }
    }
    
    func flagTapped(_ number: Int) {
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            
            // Challenge 1
            userScore += 1
    } else {
        scoreTitle = "Wrong"
        
        // Challenge 2
        scoreTitle = "Wrong! that is the flage of \(countries[number])"
        
        // Challenge 1
        if userScore > 0 {
            userScore -= 1
        }
    }
    
        // Challenge 3
        if questionNumber < 8 {
            showingScore = true
        } else {
            finalAlert = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
 //Challenge 3
func reset(){
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
    questionNumber = 0
    userScore = 0
    }
}

#Preview {
    ContentView()
}
