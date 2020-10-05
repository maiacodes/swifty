//
//  SwiftyBot.swift
//  discord-test
//
//  Created by Perplexed on 04/10/2020.
//

import Sword
import Foundation

@main class SwiftyBot {
    static let shared = SwiftyBot()
    
    let bot: Sword
    
    var cooldowns: [Snowflake : Date] = [:]
    let prefix = "."
    let commands: [Command] = [.help, .poll, .user]
    
    init() {
        bot = Sword(token: ProcessInfo.processInfo.environment["TOKEN"]!)
        
        bot.editStatus(to: "online", playing: "say .help")

        bot.on(.messageCreate) { data in
            let msg = data as! Message
            self.messageCreate(msg: msg)
        }
    }
    
    func messageCreate(msg: Message) {
        // Ignore bot and webhook messages
        guard let author = msg.author,
              author.isBot != true else {
            return
        }
        
        // If messages doesn't begin with prefix then ignore it
        guard msg.content.hasPrefix(prefix) else {
            return
        }
        
        // Check for cooldown
        guard !isUserOnCooldown(id: author.id) else {
            return
        }
        
        // Remove prefix and split by spaces
        let request = msg.content.dropFirst(prefix.count).split(separator: " ")
        
        // Find first command with given trigger
        if request.count >= 1,
           let cmd = commands.first(where: { $0.trigger == request[0] }) {
            
            cooldowns[author.id] = msg.timestamp
            cmd.route(msg, Array(request.dropFirst()))
            // Don't pass the command itself
            // Would be a lil bit faster to pass the ArraySlice directly
        }
    }

    func isUserOnCooldown(id: Snowflake) -> Bool {
        if let cooldown = cooldowns[id]?.timeIntervalSinceNow {
            // True if the last message was less than a second ago
            return cooldown > -1
        }
        // First message
        return false
    }
    
    static func main() {
        shared.bot.connect()
    }
}
