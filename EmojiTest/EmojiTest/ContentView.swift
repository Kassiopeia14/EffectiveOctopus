//
//  ContentView.swift
//  EmojiTest
//
//  Created by Anastasiia Kasian on 22/07/2023.
//

import SwiftUI

enum Emoji: String, CaseIterable{
    case 🍔, 😺, 🥳, 😈
}

struct ContentView: View {
    
    @State var selection: Emoji = .🍔;
    
    var body: some View {
        NavigationView{
            VStack {
                Text(selection.rawValue)
                    .font(.system(size:150))
                
                Picker("EmojiSelector", selection: $selection){
                    ForEach(Emoji.allCases, id:\.self){
                        emoji in Text(emoji.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            }
            .navigationTitle("Kassiopeia emojis")
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
