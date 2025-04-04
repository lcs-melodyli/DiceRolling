//
//  ContentView.swift
//  DiceRolling
//
//  Created by 利梓萌 on 2025-04-02.
//

import SwiftUI

struct ContentView: View {
    @State private var playerRoll: Int? = nil
    @State private var npcRoll: Int? = nil
    @State private var resultMessage: String = ""
    @State private var coins: Int = 100

    var body: some View {
        VStack(spacing: 30) {
            Text("🎲 骰子比大小")
                .font(.largeTitle)

            Text("你的金币：\(coins)")
                .font(.title2)

            Button("掷骰子") {
                let player = Int.random(in: 1...6)
                let npc = Int.random(in: 1...6)

                playerRoll = player
                npcRoll = npc

                if player > npc {
                    coins += 10
                    resultMessage = "🎉 你赢了！+10金币"
                } else if player < npc {
                    coins -= 10
                    resultMessage = "😢 你输了！-10金币"
                } else {
                    resultMessage = "😐 平局，金币不变"
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)

            if let playerRoll = playerRoll,
               let npcRoll = npcRoll {
                VStack(spacing: 10) {
                    Text("你掷出：\(playerRoll)")
                    Text("A 掷出：\(npcRoll)")
                    Text(resultMessage)
                        .font(.title3)
                        .foregroundColor(.purple)
                }
            }
        }
        .padding()
    }
}



#Preview {
    ContentView()
}
