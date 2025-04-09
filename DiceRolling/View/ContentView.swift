//
//  ContentView.swift
//  DiceRolling
//
//  Created by 利梓萌 on 2025-04-02.
//

import SwiftUI

// MARK: - 模型：记录一场游戏的结果
struct GameResult: Identifiable, Codable {
    let id = UUID()
    let playerRoll: Int
    let npcRoll: Int
    let outcome: String
}

struct ContentView: View {
    @State private var coins: Int = 100
    @State private var playerRoll: Int? = nil
    @State private var npcRoll: Int? = nil
    @State private var resultMessage: String = ""
    @State private var gameHistory: [GameResult] = []

    var body: some View {
        VStack(spacing: 20) {
            Text("🎲 骰子比大小")
                .font(.largeTitle)

            Text("你的金币：\(coins)")
                .font(.title2)

            Button("掷骰子") {
                rollDice()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            if let player = playerRoll, let npc = npcRoll {
                VStack(spacing: 10) {
                    Text("你掷出：\(player)")
                    Text("A 掷出：\(npc)")
                    Text(resultMessage)
                        .font(.title3)
                        .foregroundColor(.purple)
                }
            }

            Divider()
            
            Text("🎮 历史记录")
                .font(.headline)

            ScrollView {
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(gameHistory.reversed()) { game in
                        Text("你：\(game.playerRoll)，A：\(game.npcRoll) → \(game.outcome)")
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
    }

    // MARK: - 掷骰子逻辑
    func rollDice() {
        let player = Int.random(in: 1...6)
        let npc = Int.random(in: 1...6)
        playerRoll = player
        npcRoll = npc

        var outcome = ""
        if player > npc {
            coins += 10
            outcome = "胜利 +10 金币"
        } else if player < npc {
            coins -= 10
            outcome = "失败 -10 金币"
        } else {
            outcome = "平局"
        }

        resultMessage = outcome

        let result = GameResult(playerRoll: player, npcRoll: npc, outcome: outcome)
        gameHistory.append(result)
    }
}


#Preview {
    ContentView()
}
