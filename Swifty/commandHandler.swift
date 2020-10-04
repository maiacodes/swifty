//
//  commandHandler.swift
//  discord-test
//
//  Created by Perplexed on 04/10/2020.
//

import Sword
import Foundation

struct Command {
    var name: String
    var trigger: String
    var route: (Message, Array<Substring>) -> Void
    
}

var cooldowns = [Snowflake : Date]()

let prefix = "."

let commands = [helpCMD, pollCMD]

func messageCreate(msg: Message) {
    // Ignore bot messages
    if (msg.author?.isBot == true) {
        return
    }
    
    // If messages doesn't begin with prefix then ignore it
    if (msg.content.starts(with: prefix)==false) { return }
    
    // Make variable with trigger, no prefix
    let request = msg.content.dropFirst(prefix.count)
    
    // Find route and run it
    for cmd in commands {
        if request == cmd.trigger || request.starts(with: "\(cmd.trigger) ") {
            if isUserOnCooldown(id: msg.author!.id) {return}
            
            let args = request.split(separator: " ")
            cooldowns[(msg.author?.id)!] = msg.timestamp
            cmd.route(msg, args)
        }
    }
}

func isUserOnCooldown(id: Snowflake)->Bool {
    // Check for cooldown
    let cooldown = cooldowns[id]?.timeIntervalSinceNow
    if cooldown != nil {
        if Int(cooldown!) > -1 {
            return true
        }
    }
    return false
}
